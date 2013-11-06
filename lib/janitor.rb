require 'nokogiri'

class Janitor

  def clean(object)
   @object = Nokogiri::HTML(object)
   #@object.xpath('//ol/li/span[starts-with(@class, "char-style-override")]').each do |span|
   #  if span.content == /\d+\.\t/
   #    span.remove
   #  end
   #end
   @object.xpath('//ol/li/span[contains(@class, "char-style-override")]').each do |span|
     if span.content =~ /\d+\.\t/
       span.remove
     end
   end
   @object
  end
end
