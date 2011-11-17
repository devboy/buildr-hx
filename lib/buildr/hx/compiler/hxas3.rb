module Buildr
  module Haxe
    module Compiler
      class HXAS3 < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx

        COMPILE_OPTIONS << :version

        def compile(sources, target, dependencies) #:nodoc:
          @output = @project.get_hx_output(is_test(sources,target,dependencies))
          super
        end

        def compiler_args
          [ "-as3 #{@output}" ]
        end

      end
    end
  end
end
