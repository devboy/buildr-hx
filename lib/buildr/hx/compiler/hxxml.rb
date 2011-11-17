module Buildr
  module Haxe
    module Compiler
      class HXXML < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx,
                :target_ext => "xml",
                :packaging => :xml

        COMPILE_OPTIONS << :version

        def compile(sources, target, dependencies) #:nodoc:
          @output = @project.get_hx_output(is_test(sources,target,dependencies))
          super
        end

        def compiler_args
          [ "-xml #{@output}" ]
        end

      end
    end
  end
end
