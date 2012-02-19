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
require 'fileutils'

module Buildr
  module AS3
    module Packaging

      class HxlibTask < Rake::FileTask

        include Extension

        attr_accessor :target_hxlib, :src_hxlib

        def initialize(*args) #:nodoc:
          super
          enhance do
            fail "File not found: #{src_hxlib}" unless File.exists? src_hxlib
            FileUtils.cp(src_hxlib, target_hxlib)
          end
        end

        def needed?
          return true unless File.exists?(target_hxlib)
          File.stat(src_hxlib).mtime > File.stat(target_hxlib).mtime
        end

        first_time do
          desc 'create hxlib package task'
          Project.local_task('package_hxlib')
        end

        before_define do |project|
          HxlibTask.define_task('package_hxlib').tap do |package_hxlib|
            package_hxlib
          end
        end

      end

      def package_hxlib(&block)
        task("package_hxlib").enhance &block
      end

      protected

      def package_as_hxlib(file_name)
        fail("Package types don't match! :hxlib vs. :#{compile.packaging.to_s}") unless compile.packaging == :hxlib
        HxlibTask.define_task(file_name).tap do |hxlib|
          hxlib.src_hxlib = File.join(compile.target.to_s, compile.options[:output] || "#{project.name.split(":").last}.#{compile.packaging.to_s}")
          hxlib.target_hxlib = file_name
        end
      end

    end
  end
end