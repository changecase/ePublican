require 'janitor'
require 'helpers/janitor_spec_helper'

describe Janitor do

  describe '#clean' do
   
    before do
      @html_doc = Nokogiri::HTML('
        <html>
          <body>
            <h1>Best Pubs in Portland</h1>
            <ol>
              <li>
                <span class="char-style-override-17">1.&#9;</span>The Horse Brass
              </li>
              <li>
                <span class="char-style-override-17">2.&#9;</span>The Moon and Sixpence
              </li>
            </ol>
          </body>
        </html>')
      @xml_doc =  Nokogiri::XML('<root><pubs><pub><name>The Horse Brass</name></pub></pubs></root>')
      @janitor = Janitor.new
    end

    it 'selects the proper document to clean' do
      expect(@janitor.clean(@html_doc)).to eq(@html_doc)
      expect(@janitor.clean(@xml_doc)).not_to eq(@html_doc)
    end

    describe 'selects the proper element to clean when' do
      before do
        @cleaned_html = @janitor.clean(@html_doc)
      end

      it 'the element to clean is a list item in an ordered list' do
        expect(@cleaned_html.css('ol li').text).not_to match(/\d+.\t.*/)
      end
    end
  end
end
