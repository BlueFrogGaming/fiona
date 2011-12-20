require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TemplateSpec" do
  context 'serialization' do
    it 'should encode' do
      TemplateBase.serialize_attribute({'foo' => 555}).should == "{\"json\":{\"foo\":555}}"
    end

    it 'should decode' do
      result = TemplateBase.deserialize_attribute("{\"json\":{\"foo\":555}}")
    end
  end
end
