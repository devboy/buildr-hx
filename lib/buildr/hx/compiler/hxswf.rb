module Buildr
  module Haxe
    module Compiler
      class HXSWF < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx,
                :target_ext => "swf",
                :packaging => :swf

        COMPILE_OPTIONS << :swfversion << :swfheader << :flashstrict

        def compiler_args
          args = []
          args << "-swf #{@output}"
          args << "-swf-version #{options[:swfversion]}"
          args << "-swf-header #{options[:swfheader]}" unless options[:swfheader].nil?
          args << "--flash-strict" if options[:flashstrict]
          args
        end

      end
    end
  end
end
