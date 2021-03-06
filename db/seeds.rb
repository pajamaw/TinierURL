require 'nokogiri'
require 'open-uri'

counter = 0
page = Nokogiri::HTML(open("https://moz.com/top500"))
page.css('#top-500 tbody tr td.url').collect do |url|
  @short = ShortLink.create(destination: url.text.squish, visited: rand(1..1000), custom_slug: false)
  if @short.save
    puts "#{@short.attributes}"
    puts "#{counter+=1}. #{url.text} created!"
  else
    puts "error"
  end
end
