require 'nokogiri'
require 'open-uri'
namespace :cass do
  desc "TODO"
  task seed: :environment do
    counter = 0
    page = Nokogiri::HTML(open("https://moz.com/top500"))
    page.css('#top-500 tbody tr td.url').collect do |url|
      slug = ShortLink.base_conversion_to_slug(ShortLink.current_id)
      ShortLink.create(slug: slug, destination: url.text, visited: rand(1..1000), id: ShortLink.current_id)
      puts "#{counter}. #{url.text} created!"
      ShortLink.increment
      counter+=1
    end
  end

end
