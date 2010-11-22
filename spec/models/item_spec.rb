require 'spec_helper'

describe Item do
  subject { Factory.build(:item) }

  %w(name price).each do |attr|
    specify "requires #{attr}" do
      subject.send("#{attr}=",nil)
      should_not be_valid
      subject.errors[attr].should_not be_empty
    end
  end

  specify "requires price to be numerical" do
    subject.price = "ABC"
    subject.should_not be_valid
    subject.errors[:price].should_not be_empty
  end
  
end
