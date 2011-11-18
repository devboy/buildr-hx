module Buildr
  module Haxe
    module Compiler
      class HXNeko < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx,
                :target_ext => "n",
                :packaging => :n

        def compiler_args
          [ "-neko #{@output}" ]
        end

      end
    end
  end
end
