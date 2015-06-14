$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'clearbit/slack'
require 'pry'

Dir[File.expand_path('spec/support/**/*.rb')].each { |file| require file }

RSpec.configure do |config|
  include Spec::Support::Helpers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = 'random'
end
