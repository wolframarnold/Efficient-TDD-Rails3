require 'spec_helper'

describe User do
  it 'can be created' do
    lambda {
      User.create(:first_name => "Joe", :last_name => "Smith")
    }.should change(User, :count).by(1)
  end

  context "is not valid" do
    #  subject { User.new }  -- not strictly necessary so long we have describe User up top

    [:first_name, :last_name].each do |attr|
      it "without #{attr}" do
        subject.should_not be_valid
        subject.errors[attr].should_not be_nil
      end
    end
  end

  context "full_name" do

    it 'has the method' do
      User.new.should respond_to(:full_name)
    end

    it 'returns first_name + last_name as middle name' do
      u = User.new(:first_name => "Joe", :last_name => "Smith")
      u.full_name.should == 'Joe Smith'
    end

    it 'includes middle name when present' do
      u = User.new(:first_name => "Joe", :middle_name => "M", :last_name => "Smith")
      u.full_name.should == "Joe M Smith"
    end

  end

end
