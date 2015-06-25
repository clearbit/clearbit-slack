# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clearbit/slack/version'

Gem::Specification.new do |spec|
  spec.name          = "clearbit-slack"
  spec.version       = Clearbit::Slack::VERSION
  spec.authors       = ["Harlow Ward"]
  spec.email         = ["harlow@clearbit.com"]

  spec.summary       = %q{Push Clearbit data into Slack channel}
  spec.description   = %q{Push Clearbit data into Slack channel}
  spec.homepage      = "https://github.com/clearbit/clearbit-slack"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'maccman-mash', '~> 0.0.2'
  spec.add_dependency 'slack-notifier', '~> 1.2.1'
  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'pry', '~> 0.10.1'
  spec.add_development_dependency 'rake', '~> 10.0'
end
