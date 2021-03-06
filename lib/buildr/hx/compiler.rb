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

require File.dirname(__FILE__) + '/compiler/haxe_compiler_base'
require File.dirname(__FILE__) + '/compiler/hxswf'
require File.dirname(__FILE__) + '/compiler/hxjs'
require File.dirname(__FILE__) + '/compiler/hxneko'
require File.dirname(__FILE__) + '/compiler/hxphp'
require File.dirname(__FILE__) + '/compiler/hxxml'
require File.dirname(__FILE__) + '/compiler/hxas3'
require File.dirname(__FILE__) + '/compiler/hxcpp'
require File.dirname(__FILE__) + '/compiler/hxlib'

Buildr::Compiler << Buildr::Haxe::Compiler::HXSWF
Buildr::Compiler << Buildr::Haxe::Compiler::HXJS
Buildr::Compiler << Buildr::Haxe::Compiler::HXNeko
Buildr::Compiler << Buildr::Haxe::Compiler::HXPHP
Buildr::Compiler << Buildr::Haxe::Compiler::HXXML
Buildr::Compiler << Buildr::Haxe::Compiler::HXAS3
Buildr::Compiler << Buildr::Haxe::Compiler::HXCPP
Buildr::Compiler << Buildr::Haxe::Compiler::HXLib