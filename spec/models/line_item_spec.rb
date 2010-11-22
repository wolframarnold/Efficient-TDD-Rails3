require 'spec_helper'

describe LineItem do

  # Can check this, but is kind of repetitive
  it 'has an order' do
    should respond_to(:order)
  end
  it 'has an item' do
    should respond_to(:item)
  end

  # Better: check for rules on associations, which will implicitly
  # check that they're defined correctly
  %w(order item).each do |assn|
    it "requires associated #{assn}" do
      should_not be_valid
      subject.errors[assn].should_not be_empty
    end
  end


end
