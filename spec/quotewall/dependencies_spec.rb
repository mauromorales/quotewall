require 'spec_helper'
require 'rubygems'
require 'quotewall'

describe "Dependencies" do

  it "should be running on OS X" do
    Quotewall::check_osx.should be_true
  end

end
