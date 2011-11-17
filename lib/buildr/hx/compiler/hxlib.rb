module Buildr
  module Haxe
    module Compiler
      class HXLib < Buildr::Compiler::Base

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx

        def compile(sources, target, dependencies)
        end

        def needed?(sources, target, dependencies)
          true
        end

      end
    end
  end
end
