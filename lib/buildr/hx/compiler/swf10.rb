module Buildr
  module Haxe
    module Compiler
      class SWF10 < Buildr::Compiler::Base

        specify :language => :haxe,
                :sources => :hx, :source_ext => :hx,
                :target_ext => "swf",
                :packaging => :swf

        COMPILE_OPTIONS = [:warnings, :debug, :args, :flexsdk, :apparat, :output]

        def initialize(project, options)
          super
          options[:debug] = Buildr.options.debug if options[:debug].nil?
          options[:warnings] ||= true
        end

        def compile(sources, target, dependencies)
          check_options options, COMPILE_OPTIONS
          unless Buildr.application.options.dryrun
          end
        end

        def needed?(sources, target, dependencies)
          true
        end

      end
    end
  end
end
