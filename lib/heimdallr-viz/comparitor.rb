require 'rmagick'

module HeimdallrViz
  class Comparitor
    def compare(expected:, actual:)
      expected_image = read_image expected
      actual_image = read_image actual
      (expected_image <=> actual_image).zero?
    end

    def compare_with_pixel_threshold(expected:,
                                     actual:,
                                     threshold:)
      result = difference(expected, actual)
      result < threshold
    end

    def compare_with_percent_threshold(expected:,
                                     actual:,
                                     threshold:)
      result = percent_diff(expected, actual)
      result < threshold
    end

    def difference(expected, actual)
      expected_image = read_image expected
      actual_image = read_image actual
      expected_pixels = compute_pixels expected_image
      actual_pixels = compute_pixels actual_image
      result = calculate_difference(expected_pixels, actual_pixels)
      result.size
    end

    def percent_diff(expected_file, actual_file)
      diff = difference(expected_file, actual_file)
      expected_pixels = (read_image expected_file).export_pixels.size
      ((100.0 * diff) / expected_pixels).round
    end

    def read_image(file)
      Magick::Image.read(file)[0]
    end

    def compute_pixels(image)
      result = {}
      pixels = image.export_pixels
      pixels.each_with_index do |p, index|
        result[index] = p
      end
      result
    end

    def calculate_difference(expected, actual)
      diff = {}
      expected.each do |index, pixel|
        diff[index] = pixel unless actual[index] == pixel
      end
      diff
    end
  end
end
