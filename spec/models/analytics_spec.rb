require 'spec_helper'

describe "Analytics" do
  def create_order(opts={})
    order = Factory.build(:order)
    opts = opts.dup
    opts[:items_count] ||= 1
    opts[:items_count].times do
      if opts[:item].present?
        order.line_items.build(:item => opts[:item])
      else
        order.line_items << Factory.build(:line_item, :order => order)
      end
    end
    order.attributes = opts.except(:items_count, :item)
    order.save!
    order
  end

  describe "Popularity ranking" do
    before do
      @items = 3.times.inject([]) { |res,i| res << Factory(:item) }
      # create order items records with 2 * Item0, 5 * Item1, 1 * Item2
      @orders = []
      @orders << create_order(:items_count => 2, :item => @items[0])
      @orders << create_order(:items_count => 5, :item => @items[1])
      @orders << create_order(:items_count => 1, :item => @items[2])

      Item.count.should == 3
      LineItem.count.should == 8
      Order.count.should == 3
    end

    it 'returns items ranked by frequency of appearance in orders' do
      Item.by_popularity.should == [@items[1], @items[0], @items[2]]
    end
  end

  describe "Loyalty search" do
    before do
      Order.delete_all
      LineItem.delete_all
      Item.delete_all
      @joe   = Factory(:user, :first_name => "Joe")
      @sally = Factory(:user, :first_name => "Sally")
      @anna = Factory(:user, :first_name => "Anna")

      @order_joe_new = create_order(:items_count => 1, :created_at => Time.now, :user => @joe)
      @order_joe_old = create_order(:items_count => 1, :created_at => 91.days.ago, :user => @joe)
      @order_sally_new = create_order(:items_count => 1, :created_at => Time.now, :user => @sally)
      @order_anna_old = create_order(:items_count => 1, :created_at => 91.days.ago, :user => @anna)
    end

    it 'finds users with recent orders in last 90 days' do
      User.loyal_last_90_days.all.should == [@joe, @sally]
    end

    it 'finds users with orders for >= 2 items' do
      User.min_2_items.all.should == [@joe]
    end

    it 'finds users with orders for >= 2 items in the last 90 days' do
      User.min_2_items.loyal_last_90_days.all.should be_empty
      @order_joe_new.line_items.create!(:item => Factory(:item))
      User.min_2_items.loyal_last_90_days.all.should == [@joe]
      User.loyal_last_90_days.min_2_items.all.should == [@joe]
    end

  end
end