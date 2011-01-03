#!/usr/bin/ruby
require 'rubygems'
require './string.rb'
require 'fastercsv'
require 'feedbag'
require 'builder'


class CSV2OPML

  def initialize
    
    opml = Array.new
    FasterCSV.foreach(ARGV[0]) do |row|
      opml << [Feedbag.find(row.shift)[0], row]
    end
    
    p opml

    xml = Builder::XmlMarkup.new( :indent => 2 )
    xml.instruct! :xml, :encoding => "UTF-8"
    xml.opml do |o|
      o.head do |h| 
        h.title ARGV[0]
      end
      o.body do |b|
        opml.each do |feed|
          b.outline(:text => feed[0], :url => feed[0])
        end
      end
    end
    
    p xml
    
  end
  
end

CSV2OPML.new
