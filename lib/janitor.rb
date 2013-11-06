require 'nokogiri'

class Janitor

  def clean(object)
   @object = Nokogiri::HTML(object)
   
   # Remove level-one ordered lists 
   @object.xpath('//ol/li/span[contains(@class, "char-style-override")]').each do |span|
     if span.content =~ /\d+\.\t/
       span.remove
     end
   end

   # Return the (nokogiri) object
   @object
  end
end
