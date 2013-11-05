describe Janitor do
  describe 'clean' do
    it 'selects the proper document to clean' do
      before do
        html_doc = Nokogiri::HTML('<html><body><h1>Best Pubs in Portland</h1></body></html>')
        xml_doc =  Nokogiri::XML('<root><pubs><pub><name>The Horse Brass</name></pub></pubs></root>')
        @janitor = Janitor.new
      end

      expect(@janitor.clean(html_doc)).to eq ('<html><body><h1>Best Pubs in Portland</h1></body></html>')
    end
  end
end
