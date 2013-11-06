require 'janitor'

describe Janitor do

  describe '#clean' do
   
    before do
      html_doc = '
        <html>
          <body>
            <h1>Best Pubs in Portland</h1>
            <p class="Paragraph">The following is a list of the best places to drink in PDX.</p>
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
                <p class="location Paragraph">Located in the Hollywood district</p>
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

    describe 'in paragraphs' do
      
      it 'removes the unnecessary .paragraph class on <p> tags' do
        expect(@clean_html.css('p.Paragraph')).to be_empty
      end
    end
  end
end
