require 'nokogiri'

class Janitor

  def clean(object)
   @object = Nokogiri::HTML(object)
   
   # Remove redundant numbering on level-one ordered lists 
   @object.xpath('//ol/li/span[contains(@class, "char-style-override")]').each do |span|
     if span.content =~ /\d+\.\t/
       span.remove
     end
   end

   # Remove redundant bullets on level-one unordered lists
   @object.xpath('//ul/li/span[contains(@class, "char-style-override")]').each do |span|
     if span.content =~ /\t/
       span.remove
     end
   end
   
   # Remove .paragraph on <p>
   @object.css('p.Paragraph').remove_class('Paragraph')
  # @object.css('p').remove_class(nil) # removed. This _apparently_ gets rid
   # of _all_ classes on <p>. I'd like to figure out a way to remove the class 
   # attribute from elements when the class attribute is empty.

   # Remove p.graphic-holder placeholders
   @object.css('p.graphic-holder').remove

   # Add .book-image to <img> figures
   @object.css('div.Figure--no-border- img').add_class('book-image')

   # Convert ol li.figure to p.figure
   @object.css('ol>li.figure')).each do |ol|
     figure_text = ol.at_css('li.figure')
     ol.remove
     p_wrapper = figure_text.wrap('<p class="figure"></p>')
   
   # Return the (nokogiri) object
   @object
  end
end
