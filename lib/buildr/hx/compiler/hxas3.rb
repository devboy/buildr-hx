module Buildr
  module Haxe
    module Compiler
      class HXAS3 < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx

        def compiler_args
          [ "-as3 #{@output}" ]
        end

      end
    end
  end
end
