require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  describe '#create' do
    let(:a_user) { create :lucas }
    it 'return a cart as json' do
      post :create, {clientId: a_user.id, password: a_user.password}

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to eq({'id' => 1, 'content' => []})
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
      expect(JSON.parse(response.body)).to eq({'id' => a_cart.id, 'content' => []})
    end

    context 'with one book' do
      let(:a_book) { create :lotr }
      it 'has one book' do
        a_cart.add(a_book, 1)
        get :show, {id: a_cart.id}

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq(
                                                 {
                                                     'id' => a_cart.id,
                                                     'content' => [
                                                         {
                                                             'amount' => 1,
                                                             'book' => {
                                                                 'isbn' => a_book.isbn,
                                                                 'title' => a_book.title,
                                                                 'price' => a_book.price
                                                             }
                                                         }
                                                     ]
                                                 }
                                             )
      end
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

    it 'can not add a book that does not exist' do
      post :add_book, {id: a_cart.id, bookIsbn: a_book.isbn + 'j', bookQuantity: 1}

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({'error' => "Couldn't find Book"})
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

        expect(JSON.parse(response.body))
            .to eq([{
                        'amount' => 1,
                        'book' => {
                            'title' => 'Harry Potter',
                            'isbn' => '123456789',
                            'price' => 10
                        }
                    }])
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
        subject
      end

      it 'does not exist after checkout' do
        expect(Cart.all).not_to include a_cart
      end

      it 'responds with the right code' do
        expect(response).to have_http_status(:ok)
      end

      context 'with an invalid credit card' do
        let(:a_credit_card) { build :expired_credit_card }

        it 'returns an error' do
          expect(response).to have_http_status(:bad_request)
        end
        it 'has the right error response' do
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

  context 'when the credit card' do
    let(:a_book) { create :harry_potter }
    let(:credit_card) { create :credit_card }
    let(:number) { credit_card.number }
    let(:expiration_date) { credit_card.expiration_date }
    let(:user) { credit_card.user }

    let(:a_cart_with_things) do
      cart = create(:cart_session)
      cart.add(a_book, 1)
      cart
    end

    subject do
      post :checkout, {
          id: a_cart_with_things.id,
          ccn: number,
          cced: expiration_date,
          cco: user,
      }
    end

    context 'has an invalid number' do
      let(:number) { 'j' * 16 }
      before { subject }

      it 'the still exists' do
        expect(CartSession.all).to include a_cart_with_things
      end
      it 'the response is bad request' do
        expect(response).to have_http_status(:bad_request)
      end
      it 'the error message is the appropriate one' do
        expect(JSON.parse(response.body)).to eq({'error' => 'Validation failed: Number Invalid credit card'})
      end
    end
    context 'has an invalid expiration date' do
      let(:expiration_date) { 'jjjjjj' }
      before { subject }

      it 'the still exists' do
        expect(CartSession.all).to include a_cart_with_things
      end
      it 'the response is bad request' do
        expect(response).to have_http_status(:bad_request)
      end
      it 'the error message is the appropriate one' do
        expect(JSON.parse(response.body)).to eq({'error' => 'invalid date'})
      end
    end
    context 'has an expired credit card' do
      let(:a_date) { 7.months.ago }
      let(:expiration_date) { "#{a_date.year}/#{a_date.month}" }
      before { subject }

      it 'the still exists' do
        expect(CartSession.all).to include a_cart_with_things
      end
      it 'the response is bad request' do
        expect(response).to have_http_status(:bad_request)
      end
      it 'the error message is the appropriate one' do
        expect(JSON.parse(response.body)).to eq({'error' => 'Validation failed: Expiration date The credit card has already expired'})
      end
    end
  end

  context 'with an empty cart' do
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
