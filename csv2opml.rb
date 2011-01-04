#!/usr/bin/ruby
require 'rubygems'
require './string.rb'
require 'fastercsv'
require 'feedbag'
require 'nokogiri'


class CSV2OPML

  def initialize
    
    feeds = Array.new
    FasterCSV.foreach(ARGV[0]) do |row|
      feeds << [Feedbag.find(row.shift)[0], row]
    end
    
    p feeds

    opml = Nokogiri::XML::Builder.new do |xml|
      xml.opml {
        xml.head {
          xml.title ARGV[0]
        }
        xml.body {
          feeds.each do |feed|
            xml.outline(:text => feed[0], :url => feed[0])
          end
        }
      }
    end
    
    File.open("#{ARGV[0]}.opml", "w") do |f|
      f.write opml.to_xml
    end
    
  end
  
end

CSV2OPML.new
