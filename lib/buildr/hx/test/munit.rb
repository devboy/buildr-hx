require 'buildr'
require 'fileutils'
require "rexml/document"
require "pathname"

module Buildr
  module Haxe
    module Test

      class MUnit < TestFramework::Haxe

        DEFAULT_VERSION = "0.9.2.1"

        def initialize(test_task, options)
          super
          @task.compile.enhance [generate_test_suites]
        end

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
            appwd = Dir.pwd
            Dir.chdir task.project.base_dir

            cmd = "haxelib run munit test"
            cmd << " -browser #{options[:browser]}" unless options[:browser].nil?
            cmd << " -keep-browser-alive" if options[:keepbrowseralive]
            cmd << " -coverage" if options[:coverage]

            fail "Failed to run MUnit TestRunner!" unless system cmd

            Dir.chdir appwd

            Dir[File.join(task.project.path_to(:reports, :munit), "**/TEST-*.xml")].each do |xml_report|
              doc = REXML::Document.new File.new(xml_report)
              name = doc.elements["testsuite"].attributes["name"]
              failures = Integer(doc.elements["testsuite"].attributes["failures"])
              errors = Integer(doc.elements["testsuite"].attributes["errors"])
              tests -= [name] unless failures + errors == 0
            end

          end
          tests
        end

        def generate_test_suites
          Rake::Task.define_task :generate_test_suites do
            puts "Generating MUnit Test Suite"
            create_munit_config
            appwd = Dir.pwd
            Dir.chdir task.project.base_dir
            cmd = "haxelib run munit gen"
            fail "Failed to generate MUnit Test Suite" unless system cmd
            Dir.chdir appwd
          end
        end

        def create_munit_config
          file = get_munit_file()
          puts "Generating MUnit configuration '#{file}'"
          File.open(file, 'w') { |f| f.write(
              <<-FILE
version=#{options[:version].nil? ? DEFAULT_VERSION : options[:version]}
src=#{relative_path task.project.path_to(:source, :test, :hx), @task.project.base_dir}
bin=#{relative_path task.project.test.compile.target.to_s, @task.project.base_dir}
report=#{relative_path task.project.path_to(:reports, :munit).to_s, @task.project.base_dir}
hxml=#{relative_path get_hxml_file, @task.project.base_dir}
classPaths=#{task.project.compile.sources.map(&:to_s).map{|s| relative_path s, @task.project.base_dir}.join(',')}
              FILE
          ) }
        end

        def get_munit_file
          File.join(task.project.base_dir, ".munit")
        end

        def get_hxml_file
          file = task.compile.options[:hxml] || "test.hxml"
          File.join(task.project.base_dir, file)
        end

        def relative_path path, from
          Pathname.new(path).relative_path_from(Pathname.new(from)).to_s
        end

      end
    end
  end

end