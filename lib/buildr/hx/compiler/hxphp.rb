module Buildr
  module Haxe
    module Compiler
      class HXPHP < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx

        def compiler_args
          [ "-php #{@output}" ]
        end

      end
    end
  end
end
