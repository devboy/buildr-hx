module Buildr
  module Haxe
    module Compiler
      class HXXML < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx,
                :target_ext => "xml",
                :packaging => :xml

        def compiler_args
          [ "-xml #{@output}" ]
        end

      end
    end
  end
end
