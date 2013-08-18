When(/^I successfully run `quotewall "(.*?)"$/) do |quote|
  `quotewall "#{quote}"`
end

Then(/^an file named "(.*?)" should exist in the Pictures folder$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^it should be the default wallpaper$/) do
  pending # express the regexp above with the code you wish you had
end
