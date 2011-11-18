module Buildr
  module Haxe
    module Compiler
      class HXCPP < HaxeCompilerBase

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx

        def compiler_args
          [ "-cpp #{@output}" ]
        end

      end
    end
  end
end
