# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "twitter_profile_image/version"

Gem::Specification.new do |spec|
  spec.name          = "twitter_profile_image"
  spec.version       = TwitterProfileImage::VERSION
  spec.authors       = ["Mayoto Yoshida"]
  spec.email         = ["2getjp@gmail.com"]

  spec.summary       = "Get twitter user profile image"
  spec.description   = "Get twitter user profile image"
  spec.homepage      = "https://2get.jp"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "twitter_api"
end
