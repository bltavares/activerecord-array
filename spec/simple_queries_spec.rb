require "spec_helper"

describe ActiveRecord::Array, "#simple" do

  #Example
  ##
  ##Client.where(:orders_count => 1)
  ##SELECT * FROM clients WHERE (clients.orders_count = 1)

  let(:bruno) { OpenStruct.new :name => "Bruno", :age => 18, :email => "email@email.com" }
  let(:james) { OpenStruct.new :name => "James", :age => 20, :email => "james@email.com" }

  describe "acts as an array" do
    it "should push items" do
      ar = ActiveRecord::Array::Base.new [bruno]
      ar << james
      ar.length.must_equal 2
    end

    it 'should be empty' do
      ar = ActiveRecord::Array::Base.new
      ar.must_be :empty?
    end

  end

  describe "simple query" do
    let(:ar) { ActiveRecord::Array::Base.new [bruno, james] }
    [
      {:query => "Bruno", :key => :name },
      {:query => "James", :key => :name },
      {:query => 18, :key => :age },
    ].each do |test|
      it "query by one parameter" do
        result = ar.where(test[:key] => test[:query])
        result[0].send(test[:key]).must_equal test[:query]
      end
    end
  end

  describe "nil values" do
    let(:nil_man) { OpenStruct.new :name => nil }
    it "should query nil values" do
      ar = ActiveRecord::Array::Base.new [nil_man]
      result = ar.where :name => nil
      result.length.must_equal 1
    end
  end

  describe "connected queries" do
    let(:younger_bruno) { young = bruno.dup; young.age = 17; young; }
    let(:ar) { ActiveRecord::Array::Base.new [bruno, james, younger_bruno] }

    it 'should combine queries' do
      result = ar.where(:name => "Bruno", :age => 18)
      result.length.must_equal 1 
    end
  end
end
