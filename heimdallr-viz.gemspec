lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heimdallr-viz/version'

Gem::Specification.new do |spec|
  spec.name          = 'heimdallr-viz'
  spec.version       = HeimdallrViz::VERSION
  spec.authors       = ['arane']
  spec.email         = ['arane9@gmail.com']

  spec.summary       = 'Tool to help visual regression'
  spec.description   = 'Visual regression framework enabling ruby-selenium based projects to use their page objects to capture visual regression'
  spec.homepage      = 'https://github.com/araneforseti/heimdallr-viz'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org/'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'bundler-audit', '~>0.7.0'
  spec.add_development_dependency 'guard-rspec', '~> 4.7', '>= 4.7.3'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'require_all', '>= 2.0.0', '~> 3.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.6.0'
  spec.add_development_dependency 'terminal-notifier', '~> 2.0', '>= 2.0.0'
  spec.add_development_dependency 'terminal-notifier-guard', '~> 1.6', '>= 1.6.0'

  spec.add_runtime_dependency 'rmagick', '~> 2.16.0', '>= 2.16.0'
end
