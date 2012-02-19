require "fileutils"
require "pathname"

module Buildr
  module Haxe
    module Compiler
      class HXLib < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx,
                :packaging => :hxlib

        def compile(sources, target, dependencies)
          dependency_list = (generate_dependency_args(dependencies) + generate_source_args(sources)).
              reject{|dep| !( dep.start_with?("-cp") || dep.start_with?("-lib") ) }.
              map{ |dep|
                dep.start_with?("-cp") ? "-cp #{relative_path( dep.gsub("-cp ", "").strip, root_project_dir )}" : dep
              }
          file = get_output_file(target)
          FileUtils.mkdir_p File.dirname(file)
          File.open(file, 'w') {|f| f.write( dependency_list.join("\n") ) }
        end

      end
    end
  end
end
