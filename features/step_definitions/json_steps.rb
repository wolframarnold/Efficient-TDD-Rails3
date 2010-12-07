
Given /^that it is (.*)$/ do |time_string|
  Time.stub!(:now).and_return(Time.parse(time_string))
end

When /^I make a (\w+) request to (.+)$/ do |verb, url|
  request_page(url, verb.downcase.to_sym, nil)
end

Then /^I should get a (\d+) response code$/ do |status_code|
  response.status.to_i.should == status_code.to_i
end

And /^I should get a content\-type of "([^"]*)"$/ do |content_type|
  response.content_type.should match(/#{content_type}/)
end

And /^the response body should contain the JSON hash:$/ do |string|
  expected_json_in_ruby = ActiveSupport::JSON.decode(string)
  ActiveSupport::JSON.decode(response.body).should == expected_json_in_ruby
end
