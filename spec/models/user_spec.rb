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
        subject.errors[attr].should_not be_empty
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

  context "associations --" do
    it 'has many shipping addresses' do
      subject.should respond_to(:shipping_addresses)
    end

    it 'can create a shipping address' do
      subject.attributes = {:first_name => "Joe", :last_name => "Smith"}
      subject.save!
      lambda {
        addr = subject.shipping_addresses.create(:street => "123 Main St", :city => "San Francisco", :state => "CA", :zip => "94321")
      }.should change(ShippingAddress,:count).by(1)
    end

    it 'is valid with in-memory shipping address' do
      subject.attributes = {:first_name => "Joe", :last_name => "Smith"}
      subject.shipping_addresses.build(:street => "123 Main St", :city => "San Francisco", :state => "CA", :zip => "94321")
      subject.valid?
      subject.should be_valid
    end

    context "nested attributes" do
      subject { Factory(:user) }

      it 'can be updated via nested attributes' do
        lambda {
          subject.attributes = {:shipping_addresses_attributes => [Factory.attributes_for(:shipping_address)]}
          subject.save!
        }.should change {subject.shipping_addresses.count}.by(1)
      end

      it "won't add a shipping address if all fields are blank" do
        lambda {
          subject.attributes = {:shipping_addresses_attributes => [:street => '', :city => '', :state => '', :zip =>'']}
          subject.save!
        }.should_not change {subject.shipping_addresses.count}
      end
    end

  end

  describe "Custom Finders" do

    before do
      User.delete_all
      @anna = Factory(:user, :first_name => "Anna",  :last_name => "Jones")
      @peter= Factory(:user, :first_name => "Peter", :last_name => "Miller")
      @jona = Factory(:user, :first_name => "Jona",  :last_name => "Smith")
    end

    it 'has a method find_by_beginning_of_name' do
      User.should respond_to(:by_names_starting_with)
    end

    it 'finds all records whose first or last name starts with the given letters' do
      User.by_names_starting_with("Jon").all.should == [@anna, @jona]
    end

  end
end
