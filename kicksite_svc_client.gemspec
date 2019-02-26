lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kicksite_svc_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'kicksite_svc_client'
  spec.version       = KicksiteSvcClient::VERSION
  spec.authors       = ['Lee DeBoom']
  spec.email         = ['lee@kicksite.net']

  spec.summary       = 'REST endpoint definitions to kicksite backend'
  spec.description   = 'Utilize for gaining access to kicksite backend/database'
  spec.homepage      = 'https://github.com/jneef/kicksite_svc_client'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activeresource', '>= 5.0.1'
  spec.add_runtime_dependency 'activeresource-response'
  spec.add_runtime_dependency 'kaminari'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
end
