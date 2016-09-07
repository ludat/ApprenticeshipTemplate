require 'rails_helper'

RSpec.describe Book, type: :model do
  subject do
    Book.create!(icbn: '123456789', title: 'The alchemist', price: 10)
  end

  it { is_expected.to have_attributes(title: 'The alchemist', icbn: '123456789', price: 10) }
end
