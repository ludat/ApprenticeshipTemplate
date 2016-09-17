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

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq({'error' => 'Invalid credentials'})
    end

    it 'returns bad request when password is not set' do
      post :create, {clientId: a_user.id}

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq({'error' => 'param is missing or the value is empty: password'})
    end

    it 'returns bad request when password is not set' do
      post :create, {password: a_user.password}

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq({'error' => 'param is missing or the value is empty: clientId'})
    end
  end

  describe '#show' do
    let(:a_cart) { create :cart_session }
    it 'returns the cart' do
      get :show, {id: a_cart.id}
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to eq({'id' => a_cart.id})
    end
  end

  describe '#addToCart' do
    let(:a_cart) { create :cart_session }
    let(:a_book) { create :harry_potter }
    it 'can hold an item' do
      post :add_book, {id: a_cart.id, bookIsbn: a_book.isbn, bookQuantity: 1}

      expect(response).to have_http_status(:success)
      expect(a_cart).not_to be_empty
    end

    it 'can not add zero books to a cart' do
      post :add_book, {id: a_cart.id, bookIsbn: a_book.isbn, bookQuantity: 0}

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq({'error' => 'Validation failed: Amount must be greater than 0'})
    end

    it 'can not add a negative number of books' do
      post :add_book, {id: a_cart.id, bookIsbn: a_book.isbn, bookQuantity: -20}

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq({'error' => 'Validation failed: Amount must be greater than 0'})
    end

    it 'can not add a j number of books' do
      post :add_book, {id: a_cart.id, bookIsbn: a_book.isbn, bookQuantity: 'j'}

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).to eq({'error' => 'Validation failed: Amount must be greater than 0'})
    end
  end

  describe '#books' do
    let(:a_cart) { create :cart_session }

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

  describe '#checkout' do
    let(:a_book) { create :harry_potter }
    let(:a_cart) { create :cart_session }
    let(:a_credit_card) { create :credit_card }

    subject do
      post :checkout, {
          id: a_cart.id,
          ccn: a_credit_card.number,
          cced: a_credit_card.expiration_date,
          cco: a_credit_card.user,
      }
    end

    context 'with a cart with things' do
      before do
        a_cart.add(a_book, 1)
      end

      it 'does not exist after checkout' do
        subject

        expect(response).to have_http_status(:ok)
        expect(Cart.all).not_to include a_cart
      end

      context 'with an invalid credit card' do
        let(:a_credit_card) { build :expired_credit_card }

        it 'returns an error' do
          subject

          expect(response).to have_http_status(:bad_request)
          expect(JSON.parse(response.body)).to eq({'error' => 'Validation failed: Expiration date The credit card has already expired'})
        end
      end
    end

    context 'with a cart with no books' do
      it 'return a bad request error' do
        subject

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({'error' => Cashier.empty_cart_error_message})
      end
    end
  end

  context 'with a valid cart' do
    let!(:a_cart) { create :cart_session }
    context 'after 30 minutes' do
      before do
        Timecop.travel(30.minutes.from_now)
      end
      it 'I can not do anything to it' do
        get :books, {id: a_cart.id}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({'error' => CartSession.expired_cart_error_message})
      end
    end
  end
end
