module Buildr
  module Haxe
    module Compiler
      class HaxeCompilerBase < Buildr::Compiler::Base

        COMPILE_OPTIONS = [:warnings, :debug, :args, :main, :output, :hxml, :resources, :flags]

        def initialize(project, options)
          super
          options[:debug] = Buildr.options.debug if options[:debug].nil?
          options[:warnings] ||= true
          options[:flags] ||= []
        end

        def compile(sources, target, dependencies)
          check_options options, COMPILE_OPTIONS
          @output = get_output_file(target)
          is_test = is_test?(sources, target, dependencies)
          args = ["haxe"]
          sources += @project.compile.sources.map(&:to_s) if is_test
          args += generate_source_args sources
          args += generate_dependency_args dependencies
          args += base_compiler_args
          args += compiler_args if respond_to? :compiler_args
          unless Buildr.application.options.dryrun
            create_hxml args, is_test
            appwd = Dir.pwd
            Dir.chdir @project.base_dir
            file = File.join(@project.base_dir, options[:hxml] || is_test ? "test.hxml" : "compile.hxml")
            fail("Compilation failed!") unless system "haxe \"#{file}\""
            Dir.chdir appwd
          end
        end

        def needed?(sources, target, dependencies)
          return true unless File.exist? get_output_file(target)
          source_files = Dir.glob(sources.collect { |source| "#{source}/**/*" })
          dep_files = dependencies.collect { |dep|
            File.directory?(dep) ? Dir.glob("#{dep}/**/*") : dep
          }.flatten
          maxtime = (source_files + dep_files).collect { |file| File.stat(file).mtime }.max || Time.at(0)
          maxtime > File.stat(get_output_file(target)).mtime
        end

        protected

        def base_compiler_args #:nodoc:
          args = []
          args << "-main #{options[:main]}"
          args << '-debug' if options[:debug]
          args += options[:resources].map{|id,path| "-resource #{path}@#{id.to_s}"} unless options[:resources].nil?
          options[:flags] << "ENV_#{Buildr.environment.upcase}"
          args += options[:flags].map{|flag| "-D #{flag.to_s}"} unless options[:flags].nil?
          args + Array(options[:args])
        end

        def generate_source_args sources
          sources.collect { |source| "-cp #{source}" }
        end

        def generate_dependency_args dependencies
          args = []
          dependencies.each { |dep|
            spec = HaxeLib.path_to_spec(dep)
            if spec
              args << "-lib #{spec[:id]}:#{spec[:version]}"
              #elsif File.extname(dep) == ".zip" && Buildr.zip(dep).contain?("haxelib.xml")
              #  xml = Zip::ZipFile.open(dep) { |zip| zip.file.read("haxelib.xml") }
              #  require 'rexml/document'
              #  doc = REXML::Document.new(xml)
              #  id = doc.root.attribute("name")
              #  version = doc.root.elements['version'].attribute("name")
              #  fail "Could not install #{id}:#{version}." unless install_haxelib_zip dep
              #  args << "-lib #{id}:#{version}"
            elsif File.extname(dep) == ".swf"
              args << "-swf-lib #{dep}"
            elsif File.extname(dep) == ".hxlib"
              args += File.read(dep).split("\n").map{ |dep|
                dep.start_with?("-cp") ? "-cp #{File.join(root_project_dir, dep.gsub("-cp ", "").strip )}" : dep
              }
            end
          }
          args
        end

        def install_haxelib_zip zip
          system "haxelib test \"#{zip}\""
        end

        def is_test?(sources, target, dependencies)
          test_task = @project.test.compile
          sources==test_task.sources && dependencies==test_task.dependencies.collect { |dep| dep.to_s } && target==test_task.target.to_s
        end

        def get_output_file target
          file = "#{@project.name.split(":").last}.#{self.class.packaging.to_s}"
          file = options[:output] unless options[:output].nil?
          File.join(target.to_s, file)
        end

        def create_hxml( args, is_test )
          file = File.join(@project.base_dir, options[:hxml] || is_test ? "test.hxml" : "compile.hxml")
          puts "Creating hxml '#{file}'"
          with_path = ["cp", "swf-lib", "swf", "js", "as3", "cpp", "neko", "xml", "swf9", "resource"].map{|p|"-#{p}"}
          File.open(file, 'w') {|f| f.write(
              args.reject{|a| a == "haxe"}.
                  map{|a|
                      cmd = a.split(" ").first
                    if with_path.include? cmd
                      path = a.gsub(cmd,"").strip
                      path, id = path.split("@") if cmd == "-resource"
                      path = relative_path(path,@project.base_dir)
                      entry = "#{cmd} #{path}"
                      id.nil? ? entry : entry + "@#{id}"
                    else
                      a
                    end
                  }.
                  join("\n")
          ) }
        end

        def relative_path path, from
          Pathname.new(path).relative_path_from(Pathname.new(from)).to_s
        end

        def root_project_dir
          Buildr.application.instance_eval { find_rakefile_location.last }
        end

      end
    end
  end
end
