# heimdallr-viz

[![Gem Version](https://badge.fury.io/rb/heimdallr-viz.svg)](https://badge.fury.io/rb/heimdallr-viz)
[![Build Status](https://travis-ci.org/araneforseti/heimdallr-viz.svg?branch=master)](https://travis-ci.org/araneforseti/heimdallr-viz)

Ruby gem for aiding visual regression by taking partial screenshots of components using selenium selectors and comparing them to images of the expected look

## Requirements

* ImageMagick v6

## Usage

Create heimdallr with the selenium driver so it can "see" the page you navigate to, then pass it the information for the elements it is checking on the page.

Example:

```ruby
@heimdallr = HeimdallrViz::Viz.new driver: @browser
page_elements = [
  {
    element_name: 'chart',
    element_selector: { id: '#chart' },
    prior_image: 'images/chart.png'
  },
  {
    element_name: 'tab',
    element_selector: { xpath: '//*[@id="tab"]' },
    prior_image: 'images/ship.png'
  },
  {
    element_name: 'logo',
    element_selector: { class: '#logo' },
    prior_image: 'images/logo.png'
  }
]
result = @heimdallr.check_visuals(page_elements)
```

Heimdallr will output images used for comparison to `heimdallr-report`, which can be changed:

```ruby
@heimdallr.output_dir = 'new directory'
```

## Contributing

Contributions welcome; simply open a PR with the improvement you want to make!

Find an issue not yet logged? Raise something on the [github repo](https://github.com/araneforseti/heimdallr-viz)!

Curious about where this project is going? Check out the [backlog](https://trello.com/b/g5AbHzjh/heimdallr-viz)!
