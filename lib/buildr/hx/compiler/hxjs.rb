module Buildr
  module Haxe
    module Compiler
      class HXJS < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx,
                :target_ext => "js",
                :packaging => :js

        COMPILE_OPTIONS << :version

        def compile(sources, target, dependencies) #:nodoc:
          @output = @project.get_hx_output(is_test(sources,target,dependencies))
          super
        end

        def compiler_args
          [ "-js #{@output}" ]
        end

      end
    end
  end
end
