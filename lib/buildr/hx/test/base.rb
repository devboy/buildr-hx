require 'buildr'

module Buildr
  module Haxe
    module Test
      class TestFramework::Haxe < TestFramework::Base

        class << self

          def applies_to?(project) #:nodoc:
            project.test.compile.language == :haxe
          end

          def dependencies
            unless @dependencies
              super
            end
            @dependencies
          end
        end
      end
    end

  end
end