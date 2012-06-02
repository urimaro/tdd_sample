# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Juice do

  it "名前がある" do
    juice = Juice.new("orange", 100)
    juice.name.should == "orange"
  end

  it "値段がある" do
    juice = Juice.new("orange", 100)
    juice.price.should == 100
  end

end
