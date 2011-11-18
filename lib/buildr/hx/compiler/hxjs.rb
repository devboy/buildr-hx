module Buildr
  module Haxe
    module Compiler
      class HXJS < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx,
                :target_ext => "js",
                :packaging => :js

        def compiler_args
          [ "-js #{@output}" ]
        end

      end
    end
  end
end
