Factory.define(:user) do |u|
  u.first_name "Jona"
  u.last_name "Smith"
end

Factory.define(:shipping_address) do |s|
  s.street "123 Main"
  s.city "San Francisco"
  s.state "CA"
  s.zip "94321"
  s.association :user
end

Factory.define :order, :class => Order do |o|
  o.association :user
  # Cannot add line_items association here, as line item fails to validate order's presence. Rails or factory girl bug?
end

Factory.define :line_item do |li|
  li.association :item
end

Factory.define(:item) do |i|
  i.sequence(:name) {|n| "Product ##{n}"}
  i.sequence(:price) {|n| 399.00 + n}
end
