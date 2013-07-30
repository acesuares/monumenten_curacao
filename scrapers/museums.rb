#!/home/ace/.rvm/rubies/ruby-1.9.3-p194/bin/ruby
# -*- encoding : utf-8 -*-

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'geocoder'

features = []

npage = Nokogiri::HTML(open('http://www.curacao.com/The-Curacao-Difference/Our-People-and-Culture/Museums'))
rows = npage.css('h2 a')

rows.each do |row|
  row.map do |x|
    mpage = Nokogiri::HTML(open("http://www.curacao.com/#{x.last}"))
    feature = {
      "type" => "Feature",
      "properties" => {
        "name" => mpage.css('h1').text,
        "photo_url" => "http://www.curacao.com" + mpage.css('.attribute-image img').first['src'],
        "address" => mpage.css('.attribute-datablock ul li').first.text.gsub(/\n/,' '),
        "description" => mpage.css('.attribute-description').first.text
      }
    }
    address = feature["properties"]["address"] + ", Curaçao"
    g = Geocoder.search(address)
    unless g.empty?
      feature["geometry"] = {
        "type" => "Point",
        "coordinates" => [g[0].longitude, g[0].latitude]
      }
      puts "\t\t #{address} > #{feature["geometry"]["coordinates"].inspect}"
    else
      puts "\t\t #{address} > :("
    end
    features << feature
	end	  
end

geojson = {
  "type" => "FeatureCollection",
  "features" => features
}

File.open("museums.json", 'w') { |file| file.write(JSON.pretty_generate(geojson)) }
puts "Done..."