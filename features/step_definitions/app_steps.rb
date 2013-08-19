require 'quotewall'

When(/^I successfully run `quotewall "(.*?)"$/) do |quote|
  `quotewall "#{quote}"`
end

Then(/^a file named "(.*?)" should exist in the Pictures folder$/) do |file_name|
  pictures_path = File.expand_path("~/Pictures")
  @wall_path = File.join(pictures_path, file_name)
  File.exists?(@wall_path)
end

Then(/^it should be the default wallpaper$/) do
  Quotewall.read_default_background.include?(@wall_path).should be_true
end
