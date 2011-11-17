module Buildr
  module Haxe
    module Compiler
      class HXPHP < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx

        COMPILE_OPTIONS << :version

        def compile(sources, target, dependencies) #:nodoc:
          @output = @project.get_hx_output(is_test(sources,target,dependencies))
          super
        end

        def compiler_args
          [ "-neko #{@output}" ]
        end

      end
    end
  end
end
