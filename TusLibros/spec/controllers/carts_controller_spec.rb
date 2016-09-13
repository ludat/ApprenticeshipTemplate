require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  describe '#create' do
    let(:a_user) { create :lucas }
    it 'return a cart as json' do
      post :create, {clientId: a_user.id, password: a_user.password}
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to eq({'id' => 1})
    end

    it 'fails when the password is wrong' do
      post :create, {clientId: a_user.id, password: a_user.password + 'j'}
      expect(response).to have_http_status(:forbidden)
      expect(JSON.parse(response.body)).to eq({'error' => 'invalid user'})
    end
  end

  describe '#show' do
    let(:a_cart) { create :cart }
    skip 'returns the cart' do
      get :show, {id: a_cart.id}
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({'id' => a_cart.id})
    end
  end

  describe '#addToCart' do
    let(:a_cart) { create :cart }
    let(:a_book) { create :harry_potter }
    it 'can hold an item' do
      post :addBook, {id: a_cart.id, bookIsbn: a_book.isbn, bookQuantity: 1}

      expect(response).to have_http_status(:success)
      expect(a_cart).not_to be_empty
    end
  end

  describe '#books' do
    let(:a_cart) { create :cart }

    context 'with an empty cart' do
      it 'has no books' do
        get :books, {id: a_cart.id}

        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context 'with a cart with one book' do
      let(:a_book) { create :harry_potter }

      before do
        a_cart.add a_book, 1
      end

      it 'has one book' do
        get :books, {id: a_cart.id}

        expect(JSON.parse(response.body)).to eq([{'isbn' => a_book.isbn, 'amount' => 1}])
      end
    end
  end
end
