require "spec_helper"

describe ActiveRecord::Array::Base, "#Arrays" do
  #Example
  ##
  ##Client.where(:orders_count => [1,2,5])
  ##SELECT * FROM clients WHERE (clients.orders_count IN (1,2,5))

  let (:client_one) { OpenStruct.new :orders_count => 1 }
  let (:client_two) { OpenStruct.new :orders_count => 2 }
  let (:client_five) { OpenStruct.new :orders_count => 5 }
  let (:client_six) { OpenStruct.new :orders_count => 6 }
  let (:ar) { ActiveRecord::Array::Base.new [client_one, client_two, client_five, client_six] }

  it "must accept array condition as an contains" do
    result = ar.where(:orders_count => [1,2,5])
    result.length.must_equal 3
  end

end
