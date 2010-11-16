require 'spec_helper'

describe ShippingAddress do
  it 'belongs to user' do
    should respond_to(:user)
  end

  context "is not valid" do
    [:street, :city, :zip, :state, :user].each do |attr|
      it "without #{attr}" do
        subject.should_not be_valid
        subject.errors[attr].should_not be_empty
      end
    end

    it "limits country to 2 letter when present" do
      subject.country = "USA"
      subject.should_not be_valid
      subject.errors[:country].should_not be_empty
    end
  end

  context "optional country" do
    subject do
      u = User.create(:first_name => 'Joe', :last_name => 'Smith')
      u.shipping_addresses.build(:street => "123 Main St", :city => "San Francisco", :state => "CA", :zip => "94321")
    end

    it 'is set to "US" if left blank' do
      subject.country.should be_blank
      p subject
      subject.save!
      subject.country.should == 'US'
    end

    it 'is not overridden with "US" if set' do
      subject.country = "CA"
      subject.save!
      subject.country.should == 'CA'
    end

  end

  context "Scopes" do
    before do
      u = User.create(:first_name => 'Joe', :last_name => 'Smith')
      @ca = u.shipping_addresses.create!(:street => "123 Main St", :city => "San Francisco", :state => "CA", :zip => "94321", :created_at => 1.year.ago)
      @ca_recent = u.shipping_addresses.create!(:street => "456 Broadway", :city => "Oakland", :state => "CA", :zip => "94321", :created_at => 1.month.ago)
      @ny_recent = u.shipping_addresses.create!(:street => "876 1st Street", :city => "New York", :state => "NY", :zip => "94321", :created_at => 1.week.ago)
    end

    it 'retrieves addresses in California' do
      ShippingAddress.in_california.all.should == [@ca, @ca_recent]
    end

    it 'finds recent addresses' do
      ShippingAddress.in_last_3_months.all.should == [@ca_recent, @ny_recent]
    end

    it 'finds recent addresses in California' do
      ShippingAddress.new_in_california.all.should == [@ca_recent]
    end
  end

end
