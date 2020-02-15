# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-octobat/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Gaultier Laperche"]
  gem.email         = ["gaultier@octobat.com"]
  gem.description   = %q{Octobat OAuth2 Strategy for OmniAuth 1.0.}
  gem.summary       = %q{
Supports the OAuth 2.0 server-side and client-side flows.
Read the Octobat Plaza docs for more details: https://www.octobat.com/developers/plaza-quickstart
}
  gem.homepage      = "https://www.octobat.com/developers/plaza-quickstart"

  gem.files         = `git ls-files | grep -v example`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "omniauth-octobat"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Octobat::VERSION
  gem.license       = "MIT"

  gem.add_dependency 'omniauth', '~> 1.3'
  gem.add_dependency 'omniauth-oauth2', '~> 1.4'
end
