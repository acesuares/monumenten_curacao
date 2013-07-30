require 'faraday'
require 'nokogiri'

BASE_URL = "http://www.curacao.com/"

museums = []

response_all = Faraday.get "#{BASE_URL}The-Curacao-Difference/Our-People-and-Culture/Museums"
