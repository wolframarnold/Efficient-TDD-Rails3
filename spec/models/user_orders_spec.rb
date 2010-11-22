require 'spec_helper'

describe User do
  %w(orders items).each do |assn|
    it "is associated with #{assn}" do
      subject.should respond_to(assn)
    end
  end

  describe "orders" do
    before do
      @user = Factory(:user)
      @order1 = Factory.build(:order, :user => @user)
      @order2 = Factory.build(:order, :user => @user)
      @tv    = Factory(:item, :name => "TV")
      @radio = Factory(:item, :name => "Radio")

      @order1.line_items << Factory.build(:line_item, :item => @tv)
      @order1.line_items << Factory.build(:line_item, :item => @radio)
      @order2.line_items << Factory.build(:line_item, :item => @tv)

      @order1.save!
      @order2.save!

      @order1.line_items.should have(2).records
      @order2.line_items.should have(1).records
    end

    it 'returns all orders' do
      @user.orders.should == [@order1, @order2]
    end

    it 'returns all items purchased across orders' do
      @user.items.should == [@tv, @radio]
    end
  end
end