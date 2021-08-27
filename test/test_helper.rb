ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
require 'simplecov-lcov'
SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
SimpleCov.start 'rails'

require_relative '../config/environment'
require_relative 'sign_in_helper'
require 'rails/test_help'
require 'minitest/mock'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)
  # parallelize(workers: 1)

  # Add more helper methods to be used by all tests here...
end
