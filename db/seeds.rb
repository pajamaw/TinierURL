require 'nokogiri'
require 'open-uri'

counter = 0
page = Nokogiri::HTML(open("https://moz.com/top500"))
page.css('#top-500 tbody tr td.url').collect do |url|
  @short = ShortLink.create(destination: url.text.squish, visited: rand(1..1000))
  if @short.save
    puts "#{@short.attributes}"
    puts "#{counter}. #{url.text} created!"
  else
    puts "error"
  end
end
