Given(/^I'm a "(.*?)"$/) do |visitor|
end

When(/^I visit the "(.*?)"$/) do |place|
  place == "home" ? path = "/" : path = "/#{place}"
  visit path
end

Then(/^The "(.*?)" is displayed$/) do |place|
  place == "home" ? path = "/" : path = "/#{place}"
  visit path
  expect(current_path).to eq(path)
end
