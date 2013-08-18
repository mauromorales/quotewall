require 'rmagick'

require "quotewall/version"

module Quotewall

  img = Magick::Image::read("darkblue.jpg")[0]
  text = Magick::Draw.new

  lines = ["The way to get started is to quit", "talking and begin doing."]
  lines.each_with_index do |line, idx|
    x = (idx * 76) - ((lines.size + 1) * 35) 
    text.annotate(img, 0, 0, 0, x, line) {
        self.font_family = 'Geneva'
        self.gravity = Magick::CenterGravity
        self.pointsize = 64 
        self.stroke = 'transparent'
        self.fill = '#79c7e3'
        self.font_weight = Magick::BoldWeight
        }
  end

  who = "Walt Disney"

  text.annotate(img, 0, 0, 300, 100, "- #{who}") {
      self.font_family = 'Geneva'
      self.gravity = Magick::SouthEastGravity
      self.pointsize = 64 
      self.stroke = 'transparent'
      self.fill = '#f70352'
      self.font_weight = Magick::NormalWeight
      }

  img.write("wallpaper.jpg")

  wall = File.expand_path("wallpaper.jpg")
  `defaults write com.apple.desktop Background '{default = {ImageFilePath = "#{wall}"; }; }'`
  `killall Dock`
end
