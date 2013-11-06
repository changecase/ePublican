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
   
   # Remove .paragraph on <p>
   @object.css('p.Paragraph').remove_class('Paragraph')
   @object.css('p').remove_class(nil)

   # Return the (nokogiri) object
   @object
  end
end
