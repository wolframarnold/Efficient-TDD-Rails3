require 'spec_helper'

describe Order do

  %w(user line_items items user).each do |assn|
    it "is associated with #{assn}" do
      should respond_to(assn.to_sym)
    end
  end

  it 'requires at least 1 line item' do
    subject.should_not be_valid
    subject.errors[:line_items].should_not be_empty
  end

  context "line_items" do
    before do
      @order = Factory.build(:order)
      @order.line_items << Factory.build(:line_item)
      @order.line_items << Factory.build(:line_item)
      @order.save!
    end

    it 'can make order with associated objects' do

      @order.line_items.count.should == 2
      # Note: the line below fails and report 4 in Rails 3.0.1 --> upgrade to 3.0.3!
      @order.line_items.should have(2).records

      # Optional, generally I wouldn't go to this length
      @order.line_items.each do |li|
        li.should be_kind_of(LineItem)
        li.item.should be_kind_of(Item)
      end
    end

    context "has_many :through" do

      it 'retrieves items' do
        @order.items.should == @order.line_items.map(&:item)
      end
    end
  end

end
