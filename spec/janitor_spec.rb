require 'janitor'

describe Janitor do

  describe '#clean' do
   
    before do
      @html_doc = Nokogiri::HTML('<html><body><h1>Best Pubs in Portland</h1></body></html>')
      @xml_doc =  Nokogiri::XML('<root><pubs><pub><name>The Horse Brass</name></pub></pubs></root>')
      @janitor = Janitor.new
    end

    it 'selects the proper document to clean' do
      expect(@janitor.clean(@html_doc)).to eq(@html_doc)
      expect(@janitor.clean(@xml_doc)).not_to eq(@html_doc)
    end
  end
end
