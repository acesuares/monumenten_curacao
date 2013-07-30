# encoding: UTF-8

require 'faraday'
require 'nokogiri'
require 'json'
require 'geocoder'

BASE_URL = "http://www.curacaomonuments.org"

INFO_BASE_URL = "#{BASE_URL}/%s-information.php?geo_code=%s"
INFO_TYPES = %w(DROV PROMO MFC SMZ)

features = []

('A'..'Z').each { |sa|
  puts "#{sa}."
    
  response_all = nil
  attempts = 0
  begin
    response_all = Faraday.get "#{BASE_URL}/search-results.php",
      { :sa => sa }, 
      { :Referer => "#{BASE_URL}/search.php" }
  rescue Exception
    attempts += 1
    puts "\t Retry ##{attempts}"
    sleep(5)
    retry
  end  
    
  page_all = response_all.body
  npage_all = Nokogiri::HTML(page_all, nil, 'UTF-8')

  urls = []
  rows_all = npage_all.css('table tr')
  rows_all.each do |row|
    hrefs = row.css('td b font a').map {|p| p['href'] }
    url = hrefs[0] if hrefs.length
    if url and not urls.include? url
      geocode = url.match(/geo_code=([\d\w\.-]+)/).captures.first
      puts "\t#{geocode}"
      
      response_single = nil
      attempts = 0
      begin
        response_single = Faraday.get "#{BASE_URL}/#{url}"
      rescue Exception
        attempts += 1
        puts "\t Retry ##{attempts}"
        sleep(5)
        retry
      end
      
      page_single = response_single.body
      npage_single = Nokogiri::HTML(page_single)

      rows_single = npage_single.css('table[width="675"] tr td:nth-child(3)').css('p font, font')

      properties = {
        "geocode" => geocode
      }
      
      photo_id = npage_single.css('a[target="_blank"] img')
          .map{ |e| e["src"] }
          .first.match(/photo_id=(\d+)/)
          .captures.first rescue nil
      if photo_id
        properties["photo_url"] = "#{BASE_URL}/getphoto.php?photo_id=#{photo_id}"
      end
      
      rows_single.each { |row|
        key, value = row.text.gsub(/\s+/, ' ').split(':', 2).map{ |s| s.strip } 
        key = key.gsub(' ', '_').downcase
        if key == 'more_information_by'
          new_value = {}
          INFO_TYPES.each do |info_type|
            if value.include? info_type
              new_value[info_type.downcase] = INFO_BASE_URL % [info_type.downcase, geocode]
            end
          end
          value = new_value
        end
        properties[key] = value unless value == 'None' 
      }
      
      feature = {
        "type" => "Feature",
        "properties" => properties
      }

      sleep(1)

      address = properties["address"] + ", Curaçao"
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
    urls << url
  end
}


geojson = {
  "type" => "FeatureCollection",
  "features" => features
}

File.open("monuments.json", 'w') { |file| file.write(JSON.pretty_generate(geojson)) }
puts "Done..."
