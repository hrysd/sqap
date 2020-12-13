require_relative 'lib/sqap/version'

Gem::Specification.new do |spec|
  spec.name          = 'sqap'
  spec.version       = Sqap::VERSION
  spec.authors       = ['Hiroshi Yoshida']
  spec.email         = ['hrysd22@gmail.com']

  spec.summary       = %q{TBD}
  spec.description   = %q{TBD}
  spec.homepage      = 'https://github.com/hrysd/sqap'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata = {
    'homepage_uri' => 'https://github.com/hrysd/sqap',
    'source_code_uri' => 'https://github.com/hrysd/sqap',
    'changelog_uri' => 'https://github.com/hrysd/sqap'
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activerecord', '>= 5'
  spec.add_runtime_dependency 'minitest-around'
end
