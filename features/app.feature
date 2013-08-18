Feature: CLI functionality

Scenario: Get the quotewall help text when no arguments are passed
   When I run `quotewall`
   Then the stdout should contain "help"

Scenario: Get the quotewall help text when requested
   When I successfully run `quotewall -h`
   Then the stdout should contain "help"

Scenario: Generate a wallpaper from a quote
   When I successfully run `quotewall "The way to get started is to quit talking and begin doing - Walt Disney"
   Then an file named "quotewall.jpg" should exist in the Pictures folder
    And it should be the default wallpaper
