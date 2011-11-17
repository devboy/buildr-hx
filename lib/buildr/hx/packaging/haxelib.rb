#
# Copyright (C) 2011 by Dominic Graefen / http://devboy.org
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

require 'buildr'
require "fileutils"

module Buildr
  module Haxe
    module Packaging
      include Extension

      class HaxelibTask < Buildr::ZipTask

        def initialize(*args) #:nodoc:
          super
          enhance do
            include *@project.compile.sources.collect { |src| File.join(src, "**", "*") }
            xml = @project._("haxelib.xml")
            File.open(xml, 'w') {|f| f.write(haxelib_xml) }
            include xml, :as => "haxelib.xml"
          end
        end

        attr_accessor :url, :license, :tags, :user

        protected

        def associate(project)
          @project = project
        end

        def haxelib_xml
          buffer =''
          xml = Builder::XmlMarkup.new(:target=>buffer, :indent => 2)
          xml.project(:name => @project.name, :url => url, :license => license) do
            xml.description @project.comment
            xml.version(@project.version, :name => @project.version)
            @tags.each { |tag| xml.tag :v => tag }
            xml.user :name => @user
            haxelib_dependencies.each{ |dep| xml.depends :name => dep[:id], :version => dep[:version] }
          end
          buffer
        end

        def haxelib_dependencies
          haxelib_deps = []
          @project.compile.dependencies.each{ |dep| haxelib_deps << dep.to_spec_hash if dep.is_a? HaxeLib }
          haxelib_deps
        end

      end

      def package_as_haxelib(file_name)
        HaxelibTask.define_task(file_name).tap do |haxelib|
          haxelib.send :associate, self
        end
      end

      def package_as_haxelib_spec(spec)
        spec.merge :type=>:zip
      end

    end
  end
end