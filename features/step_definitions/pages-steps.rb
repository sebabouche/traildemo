Given(/^I'm a "(.*?)"$/) do |visitor|
end

When(/^I visit the "(.*?)"$/) do |arg1|
   get "/" 
end

Then(/^I can read the "(.*?)" and "(.*?)"$/) do |arg1, arg2|
    pending # express the regexp above with the code you wish you had
end

