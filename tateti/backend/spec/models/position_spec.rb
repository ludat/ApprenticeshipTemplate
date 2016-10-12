require 'rails_helper'

RSpec.describe Position do
  it 'return the right position using a string' do
    expect(Position.from_s('up')).to eq Position.up
  end
end
