#!/usr/bin/env ruby
# 2015-07-31
# Gismeteo API parser
# intended for the i3status bar
#
# donat@opmbx.org

require 'xmlsimple'
require 'open-uri'
require 'ap'

city =
  [ 4368, # Moscow
    4445, # Penza
  ]
URL = "http://d6a5c954.services.gismeteo.ru/inform-service/0f14315098daad405ded9270d1500bcb/forecast/?city=#{city[1].to_s}&lang=en"
CACHE_FILE = '/tmp/gismeteo.tmp'

xml = IO.read CACHE_FILE rescue nil

# save cache
if Time.now.min % 30 == 0 and Time.now.sec < 5
  xml = open(URL) {|f| f.read }
  File.open(CACHE_FILE, "wb") { |file| file.write(xml) }
end

hash = XmlSimple.xml_in(xml)

tvalid = Time.parse(hash['location'][0]['fact'][0]['valid'])
fact = hash["location"][0]["fact"][0]['values'][0]

# how many hours ago the data was actual
h_ago = ((Time.now - tvalid)/60/60).round(1)

# cache age
#h_ago_cache = ((Time.now - File.mtime(CACHE_FILE))/60/60).round(1)
#print fact['values'][0]['descr'] + ', ' + fact['values'][0]['t'] + ' °C [' + h_ago.to_s + '/' + h_ago_cache.to_s + ' h]'

print '☀ ' if fact['icon'].include? 'sun'
print "#{fact['descr']} / T: #{fact['t']} (#{fact['hi']}) / H: #{fact['hum']} / P: #{fact['p']}"
# print age if older than 1.5 hours
if h_ago > 1.5
  print " [ #{h_ago.to_s} h ago]"
end
