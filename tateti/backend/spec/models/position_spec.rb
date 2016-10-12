require 'rails_helper'

RSpec.describe Position do
  it 'returns the right position' do
    [:center, :up, :down, :left, :right, :upLeft, :upRight, :downLeft, :downRight].each { |position|
      expect(Position.from_s(position.to_s)).to eq Position.send(position)
    }
  end
end
