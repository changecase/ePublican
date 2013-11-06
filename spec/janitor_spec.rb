require 'janitor'

describe Janitor do

  describe '#clean' do
   
    before do
      html_doc = '
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
              <li>
                <span class="char-style-override-17">3.&#9;</span>
                <span class="modern char-style-override-18">Columbia Brewing</span>
              </li>
            </ol>
          </body>
        </html>'
      xml_doc = '<root><pubs><pub><name>The Horse Brass</name></pub></pubs></root>'
      @janitor = Janitor.new
      @clean_html = @janitor.clean(html_doc)
      @clean_xml = @janitor.clean(xml_doc)
    end

    it 'selects the proper document to clean' do
      expect(@clean_html.css('h1').text).to eq('Best Pubs in Portland')
      expect(@clean_xml).not_to eq(@clean_html)
    end
    
    describe 'in ordered lists' do

      it 'removes the static numbering' do
        expect(@clean_html.css('ol li').text).not_to match(/\d+\.\t.*/)
      end

      it 'does not remove spans willy-nilly' do
        expect(@clean_html.css('span.modern').text).not_to eq('')
      end
    end
  end
end
