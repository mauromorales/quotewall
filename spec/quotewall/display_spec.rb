require 'spec_helper'
require 'rubygems'
require 'quotewall'

describe "Display" do

  it "should detect the display size" do
    Quotewall::display[:width].should > 0
    Quotewall::display[:height].should > 0
  end
end
