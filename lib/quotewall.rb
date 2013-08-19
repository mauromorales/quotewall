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
    who = args.size == 2 ? args[1] : "Anonymous"
    lines = rearange(args[0])
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

    text.annotate(img, 0, 0, 300, 100, "- #{who}") {
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
    set_default_background(wall_path)
    refresh_background

  end

  def self.set_default_background(wall_path)
    `defaults write com.apple.desktop Background '{default = {ImageFilePath = "#{wall_path}"; }; }'`
  end

  def self.read_default_background
    `defaults read com.apple.desktop Background`
  end

  def self.refresh_background
    `killall Dock`
  end
end
