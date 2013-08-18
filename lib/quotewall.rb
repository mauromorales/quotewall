require 'rubygems'
require 'rmagick'
require 'plist'
require "quotewall/version"

module Quotewall

  def self.check_osx
    `sw_vers -productName`.include?("Mac OS X")
  end

  def self.display
    result = Plist::parse_xml(`system_profiler -xml SPDisplaysDataType`)
    width, height = result[0]["_items"][0]["spdisplays_ndrvs"][0]["spdisplays_resolution"].split("x")
    {:width  => width.to_i,
     :height => height.to_i
    }
  end

  def self.rearange(string)
    if string.size < 35
      return [string]
    else
      lines = [] 
      idx = 0
      string.split(" ").each do |word|
        lines[idx] = "" if lines[idx].nil?
        if lines[idx].size + word.size < 35
          lines[idx] = "#{lines[idx]} #{word}"
        else
          idx += 1
          lines[idx] = word
        end
      end
      return lines
    end
  end

  def self.run(args)
    img = Magick::Image.new(display[:width],display[:height]) { self.background_color = "#0d1030" }
    text = Magick::Draw.new
    args = "#{args} - Anonymous" unless args.include?("-")
    lines, who = args.split("-")
    lines = rearange(lines)
    lines.each_with_index do |line, idx|
      y = ( (idx + 1) * 76) - ((lines.size + 1) * 35) 
      text.annotate(img, 0, 0, 0, y, line.strip) {
          self.font_family = 'Geneva'
          self.gravity = Magick::CenterGravity
          self.pointsize = 64 
          self.stroke = 'transparent'
          self.fill = '#79c7e3'
          self.font_weight = Magick::BoldWeight
          }
    end

    text.annotate(img, 0, 0, 300, 100, "- #{who.strip!}") {
        self.font_family = 'Geneva'
        self.gravity = Magick::SouthEastGravity
        self.pointsize = 64 
        self.stroke = 'transparent'
        self.fill = '#f70352'
        self.font_weight = Magick::NormalWeight
        }

    pictures_path = File.expand_path("~/Pictures")
    img.write(File.join(pictures_path, "quotewall.jpg"))
    wall_path = File.join(pictures_path, "quotewall.jpg")

    `defaults write com.apple.desktop Background '{default = {ImageFilePath = "#{wall_path}"; }; }'`
    `killall Dock`

  end

=begin
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
=end
end
