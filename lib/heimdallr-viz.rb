require 'pry'
require 'rmagick'
# Framework for visual regression
module HeimdallrViz
  # Class for creating the visual shots
  class Viz
    attr_accessor :driver

    def initialize(driver:)
      self.driver = driver
    end

    def check_visual(element_selector:, prior_image:)
      Dir.mkdir 'viz_temp' unless File.exist? 'viz_temp'
      driver.save_screenshot('viz_temp/screen.png')
      image = Magick::Image.read('viz_temp/screen.png')[0]
      element = driver.find_element(element_selector)
      new_image = try_element(element, image)
      unless same_image(new_image, prior_image).zero?
        create_comparison_map(new_image, prior_image)
        return false
      end
      true
    end

    def try_element(element, image)
      width = element.size.width * 2
      height = element.size.height * 2
      location = element.location
      x = location.x * 2
      y = location.y * 2

      highlight(image: image, x: x, y: y, width: width, height: height)
      crop_image(image: image, x: x, y: y, width: width, height: height)
      'viz_temp/cropped.png'
    end

    def crop_image(image:, x:, y:, width:, height:)
      cropped = image.crop(x, y, width, height)
      cropped.write('viz_temp/cropped.png')
    end

    def highlight(image:, x:, y:, width:, height:)
      area = Magick::Image.new(width, height) do
        self.background_color = 'black'
      end
      highlighted = image.composite(area, x, y, Magick::SoftLightCompositeOp)
      highlighted.write('viz_temp/areas_of_interest.png')
    end

    def same_image(new_image_file, prior_image_file)
      new_image = Magick::Image.read(new_image_file)
      prior_image = Magick::Image.read(prior_image_file)
      new_image <=> prior_image
    end

    def create_comparison_map(new_image_file, prior_image_file)
      new_image = Magick::Image.read(new_image_file)[0]
      prior_image = Magick::Image.read(prior_image_file)[0]
      difference = prior_image.composite(new_image,
                                         0,
                                         0,
                                         Magick::DifferenceCompositeOp)
      difference.write('viz_temp/difference.png')
    end
  end
end
