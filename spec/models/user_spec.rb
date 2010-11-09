require 'spec_helper'

describe User do
  it 'can be created' do
    lambda {
      User.create(:first_name => "Joe", :last_name => "Smith")
    }.should change(User, :count).by(1)
  end

  context "is not valid" do
    subject { User.new }

    [:first_name, :last_name].each do |attr|
      it "without #{attr}" do
        subject.should_not be_valid
        subject.errors.on(attr).should_not be_nil
      end
    end
  end
end
