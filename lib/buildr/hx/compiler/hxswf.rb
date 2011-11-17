module Buildr
  module Haxe
    module Compiler
      class HXSWF < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx,
                :target_ext => "swf",
                :packaging => :swf

        COMPILE_OPTIONS << :version

        def compile(sources, target, dependencies)
          @output = @project.get_hx_output(is_test(sources,target,dependencies))
          super
        end

        def compiler_args
          [ "-swf #{@output}",
            "-swf-version #{options[:version]}" ]
        end

      end
    end
  end
end
