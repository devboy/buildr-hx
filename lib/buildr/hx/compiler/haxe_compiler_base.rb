module Buildr
  module Haxe
    module Compiler
      class HaxeCompilerBase < Buildr::Compiler::Base

        COMPILE_OPTIONS = [:warnings, :debug, :args, :main, :output]

        def initialize(project, options)
          super
          options[:debug] = Buildr.options.debug if options[:debug].nil?
          options[:warnings] ||= true
        end

        def compile(sources, target, dependencies)
          check_options options, COMPILE_OPTIONS
          args = ["haxe"]
          args += generate_source_args sources
          args += base_compiler_args
          args += compiler_args if respond_to? :compiler_args
          unless Buildr.application.options.dryrun
            sh args.join " "
          end
        end

        def needed?(sources, target, dependencies)
          return true unless File.exist?(@project.get_hx_output(is_test(sources,target,dependencies)))
          source_files = Dir.glob(sources.collect{|source| source = "#{source}/**/*"})
          dep_files = dependencies.collect{ |dep|
            File.directory?(dep) ? Dir.glob("#{dep}/**/*") : dep
          }.flatten
          maxtime = (source_files + dep_files).collect{ |file| File.stat(file).mtime }.max || Time.at(0)
          maxtime > File.stat(@project.get_hx_output(is_test(sources,target,dependencies))).mtime
        end

        private

        def base_compiler_args #:nodoc:
          args = []
          args << "-main #{options[:main]}"
          args << '-prompt' if options[:warnings]
          args << '-debug' if options[:debug]
          args + Array(options[:args])
        end

        def generate_source_args sources
          sources.collect { |source| "-cp #{source}"}
        end

        def is_test( sources, target, dependencies )
          test_task = @project.test.compile
          sources==test_task.sources && dependencies==test_task.dependencies.collect{|dep|dep.to_s} && target==test_task.target.to_s
        end

      end
    end
  end
end
