require 'pry'
require 'rmagick'
# Framework for visual regression
module HeimdallrViz
  # Class for creating the visual shots
  class Viz
    attr_accessor :driver
    attr_accessor :output_dir
    attr_accessor :working_dir

    def initialize(driver:)
      self.driver = driver
      self.output_dir = 'heimdallr-report'
      Dir.mkdir output_dir unless File.exist? output_dir
    end

    def check_visuals(elements)
      all_same = true
      elements.each do |element|
        all_same = false unless check_visual(element)
      end
      all_same
    end

    def check_visual(element_name:, element_selector:, prior_image:)
      self.working_dir = "#{output_dir}/#{element_name}"
      Dir.mkdir working_dir unless File.exist? working_dir
      element = driver.find_element(element_selector)
      screenshot = take_screenshot
      new_image = component_image(element, screenshot)
      unless same_image(new_image, prior_image).zero?
        create_comparison_map(new_image, prior_image)
        return false
      end
      true
    end

    def take_screenshot
      screenshot_file = "#{working_dir}/screen.png"
      driver.save_screenshot(screenshot_file)
      Magick::Image.read(screenshot_file)[0]
    end

    def component_image(element, image)
      width = element.size.width * 2
      height = element.size.height * 2
      location = element.location
      x = location.x * 2
      y = location.y * 2

      highlight(image: image, x: x, y: y, width: width, height: height)
      crop_image(image: image, x: x, y: y, width: width, height: height)
    end

    def crop_image(image:, x:, y:, width:, height:)
      cropped = image.crop(x, y, width, height)
      cropped.write("#{working_dir}/actual.png")
      "#{working_dir}/actual.png"
    end

    def highlight(image:, x:, y:, width:, height:)
      area = Magick::Image.new(width, height) do
        self.background_color = 'yellow'
      end
      # area.alpha(Magick::ActivateAlphaChannel)
      area.opacity = 0.7 * Magick::QuantumRange
      # highlighted = image.composite(area, x, y, Magick::SoftLightCompositeOp)
      highlighted = image.dissolve(area, 0.9, 1.0, x, y)
      highlighted.write("#{working_dir}/areas_of_interest.png")
    end

    def same_image(new_image_file, prior_image_file)
      new_image = Magick::Image.read(new_image_file)
      prior_image = Magick::Image.read(prior_image_file)
      prior_image[0].write("#{working_dir}/expected.png")
      new_image <=> prior_image
    end

    def create_comparison_map(new_image_file, prior_image_file)
      new_image = Magick::Image.read(new_image_file)[0]
      prior_image = Magick::Image.read(prior_image_file)[0]
      difference = prior_image.composite(new_image,
                                         0,
                                         0,
                                         Magick::DifferenceCompositeOp)
      difference.write("#{working_dir}/difference.png")
    end
  end
end
