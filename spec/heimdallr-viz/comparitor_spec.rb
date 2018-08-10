require 'spec_helper'

describe 'HeimdallrViz::Comparitor' do
  let(:compare) { HeimdallrViz::Comparitor.new }
  let(:base_file) { 'spec/resources/base_image.png' }
  let(:modified_file) { 'spec/resources/modified_base_image.png' }
  let(:half_file) { 'spec/resources/modified_half_image.png' }

  context 'default compare' do
    it 'should pass if images are identical' do
      expect(compare.compare(expected: base_file,
                             actual: base_file)).to be true
    end

    it 'should fail if images are different' do
      expect(compare.compare(expected: base_file,
                             actual: modified_file)).to be false
    end
  end

  context 'compare with pixel threshold' do
    it 'should pass if threshold is set above change' do
      expect(compare.compare_with_pixel_threshold(expected: base_file,
                                                  actual: half_file,
                                                  threshold: 20000)).to be true
    end

    it 'should pass if threshold is set to all pixels' do
      expect(compare.compare_with_pixel_threshold(expected: base_file,
                                                  actual: half_file,
                                                  threshold: 35250)).to be true
    end

    it 'should fail if threshold is set to 0 and there are changes' do
      expect(compare.compare_with_pixel_threshold(expected: base_file,
                                                  actual: half_file,
                                                  threshold: 0)).to be false
    end

    it 'should fail if threshold is set below change' do
      expect(compare.compare_with_pixel_threshold(expected: base_file,
                                                  actual: half_file,
                                                  threshold: 10)).to be false
    end
  end

  context 'compare with percent threshold' do
    it 'should pass if threshold is set above change' do
      expect(compare.compare_with_percent_threshold(expected: base_file,
                                                    actual: half_file,
                                                    threshold: 80)).to be true
    end

    it 'should pass if threshold is set to 100 percent' do
      expect(compare.compare_with_percent_threshold(expected: base_file,
                                                    actual: half_file,
                                                    threshold: 100)).to be true
    end

    it 'should fail if threshold is set to 0 and there are changes' do
      expect(compare.compare_with_percent_threshold(expected: base_file,
                                                    actual: half_file,
                                                    threshold: 0)).to be false
    end

    it 'should fail if threshold is set below change' do
      expect(compare.compare_with_percent_threshold(expected: base_file,
                                                    actual: half_file,
                                                    threshold: 10)).to be false
    end
  end

  context 'default difference' do
    it 'should return 0 if images are identical' do
      expect(compare.difference(base_file, base_file)).to eq 0
    end

    it 'should return pixel difference if images are not identical' do
      expect(compare.difference(base_file, modified_file)).to eq 35250
    end
  end

  context 'percent difference' do
    it 'should return 0 if images are identical' do
      expect(compare.percent_diff(base_file, base_file)).to eq 0
    end

    it 'should return 100 if images are completely difference' do
      expect(compare.percent_diff(base_file, modified_file)).to eq 100
    end

    it 'should return partial based on image difference' do
      expect(compare.percent_diff(base_file, half_file)).to eq 49
    end
  end
end
