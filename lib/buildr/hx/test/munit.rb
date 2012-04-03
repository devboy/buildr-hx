require 'buildr'
require 'fileutils'
require "rexml/document"

module Buildr
  module Haxe
    module Test

      class MUnit < TestFramework::Haxe

        DEFAULT_VERSION = "0.9.2.1"

        "src=test
        bin=bin/test/build
        report=bin/test/report
        hxml=test.hxml
        classPaths=lib"

        def tests(dependencies) #:nodoc:
          candidates = []
          task.project.test.compile.sources.each do |source|
            files = Dir["#{source}/**/*Test.hx"] + Dir["#{source}/**/*Tests.hx"]
            files.each { |item|
              if File.dirname(item) == source
                candidates << File.basename(item, '.*')
              else
                candidates << "#{File.dirname(item).gsub!(source+"/", "").gsub!("/", ".")}.#{File.basename(item, '.*')}"
              end
            }
          end
          candidates
        end

        def run(tests, dependencies) #:nodoc:

          unless Buildr.application.options.dryrun
            create_munit_config
            appwd = Dir.pwd
            Dir.chdir task.project.base_dir

            cmd = "haxelib run munit test"
            cmd << " -browser #{options[:browser]}" unless options[:browser].nil?
            cmd << " -keep-browser-alive" if options[:keepbrowseralive]
            cmd << " -coverage" if options[:coverage]

            fail "Problems...oh noes!" unless system cmd

            Dir.chdir appwd

            Dir[File.join(task.project.path_to(:reports, :munit),"**/TEST-*.xml")].each do |xml_report|
              doc = REXML::Document.new File.new(xml_report)
              name = doc.elements["testsuite"].attributes["name"]
              failures = Integer(doc.elements["testsuite"].attributes["failures"])
              errors = Integer(doc.elements["testsuite"].attributes["errors"])
              tests -= [name] unless failures + errors == 0
            end

          end
          tests
        end

        def create_munit_config
          file = File.join(task.project.base_dir, ".munit")
          puts "Creating munit config '#{file}'"
          File.open(file, 'w') { |f| f.write(
              "version=#{options[:version].nil? ? DEFAULT_VERSION : options[:version]}
               src=#{task.project.path_to(:source, :test, :hx)}
               bin=#{task.project.test.compile.target}
               report=#{task.project.path_to(:reports, :munit)}
               hxml=#{get_hxml_file}
               classPaths=#{task.project.compile.sources.map(&:to_s).join(',')}"
          ) }
        end

        def get_hxml_file
          file = "test.hxml"
          file = task.project.test.compile.options[:hxml] unless task.project.test.compile.options[:hxml].nil?
          File.join(task.project.base_dir, file)
        end

      end
    end
  end

end