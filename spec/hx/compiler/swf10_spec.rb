require File.dirname(__FILE__) + '/../../../spec/spec_helper'

describe Buildr::Haxe::Compiler::SWF10 do

  it 'should report the language as :haxe' do
    define('foo').compile.using(:swf10).language.should eql(:haxe)
  end

end