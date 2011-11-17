module Buildr
  module Haxe
    module Compiler
      class HXSWF < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx,
                :target_ext => "swf",
                :packaging => :swf

      end
    end
  end
end
