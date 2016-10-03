require 'rspec'

RSpec::Matchers.define :be_one_of do |expected|
  match do |actual|
    expected.include? actual
  end
end
