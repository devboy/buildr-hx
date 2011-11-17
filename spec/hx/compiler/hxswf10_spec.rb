require File.dirname(__FILE__) + '/../../../spec/spec_helper'

describe Buildr::Haxe::Compiler::HXSWF10 do

  it 'should report the language as :haxe' do
    define('foo').compile.using(:hxswf10).language.should eql(:haxe)
  end

end