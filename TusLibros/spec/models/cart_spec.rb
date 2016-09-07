require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:a_cart) { Cart.create! }
  let(:a_book) { Book.create!(icbn: '123456789', title: 'The alchemist', price: 10) }

  it 'a new cart is empty' do
    expect(a_cart).to be_empty
  end

  it 'does not contain a book' do
    expect(a_cart.include?(a_book)).to be false
  end

  it 'has one of those books' do
    expect(a_cart.occurrences_of(a_book)).to be 0
  end

  context 'with a book' do

    before do
      a_cart.add(a_book, 1)
    end

    it 'a new cart with a book is not empty' do
      expect(a_cart).not_to be_empty
    end

    it 'contains a book that was added to it' do
      expect(a_cart).to include a_book
    end

    it 'has one of those books' do
      expect(a_cart.occurrences_of(a_book)).to be 1
    end

    context 'added twice' do

      before do
        a_cart.add(a_book, 1)
      end

      it 'has two of those books' do
        expect(a_cart.occurrences_of(a_book)).to be 2
      end

    end
  end
end
