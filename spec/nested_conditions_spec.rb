require "spec_helper"

describe ActiveRecord::Array::Base, "#Nested" do
  #Example
  ##
  ##Client.joins(:account).where(:account => {:name => "Account1"})

  let(:brian) { OpenStruct.new :name => "Brian" }
  let(:doggy) { OpenStruct.new :name => "Doggy" }
  let(:bruno) { OpenStruct.new :name => "Bruno", :age => 18, :pet => brian }
  let(:james) { OpenStruct.new :name => "James", :age => 20, :pet => doggy }
  let(:petless) { OpenStruct.new :name => "Jones", :age => 999 }

  describe "nested attributes" do

    it "must accept nested hash" do
      ar = ActiveRecord::Array::Base.new [bruno, james]
      result = ar.where(:pet => {:name => "Brian"})
      result[0].name.must_equal "Bruno"
    end

    it "must ignore nill values for nested" do
      ar = ActiveRecord::Array::Base.new [bruno, james, petless]
      result = ar.where(:pet => {:name => "Brian"})
      result.length.must_equal 1
    end

  end

end
