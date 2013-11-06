require 'nokogiri'

class Janitor

  def clean(object)
   @object = Nokogiri::HTML(object)
   #@object.css('ol li span').text.gsub! /\d+\.\t(.*)/, '\1'
   #@object.search("//ol/li/span/text()").each do |span|
   #  span.content.sub!(/\d+\.\t(.*)/, "#{$1}")
   #end
   #for span in @object.xpath('//ol/li/span/text()')
   #  span.content = span.content.gsub(/\d+\.\t/, '')
   #end
  end
end
