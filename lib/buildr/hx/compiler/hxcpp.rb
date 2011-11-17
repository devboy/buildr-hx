module Buildr
  module Haxe
    module Compiler
      class HXCPP < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx

        COMPILE_OPTIONS << :version

        def compile(sources, target, dependencies) #:nodoc:

          @project.haxelib("hxcpp:2.08.0")

          @output = @project.get_hx_output(is_test(sources,target,dependencies))
          super
        end

        def compiler_args
          [ "-cpp #{@output}" ]
        end

      end
    end
  end
end
