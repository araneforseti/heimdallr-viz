require 'spec_helper'

describe 'HeimdallrViz::Comparitor' do
  let(:compare) { HeimdallrViz::Comparitor.new }
  let(:base_file) { 'spec/resources/base_image.png' }

  context 'default compare' do
    it 'should pass if images are identical' do
      expect(compare.compare(base_file, base_file)).to be true
    end
  end
end
