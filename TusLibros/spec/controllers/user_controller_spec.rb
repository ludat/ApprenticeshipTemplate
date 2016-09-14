require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'with a valid user and a valid credit card' do
    let(:a_user) { create :lucas }
    let(:a_book) { create :harry_potter }
    let(:another_book) { create :lotr }
    let(:a_credit_card) { create :credit_card, user: a_user }

    context 'with a cart with one book' do
      let(:a_cart) { create :cart_session, user: a_user }

      before do
        a_cart.add(a_book, 7)
      end

      it 'returns an empty list of pucharses' do
        get :pucharses, {id: a_user.id}

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq([])
      end

      context 'that was checked out' do
        before do
          Cashier.new(instance_spy(MerchantProcessor)).charge a_cart, to: a_credit_card
        end

        it 'returns an empty list of pucharses' do
          get :pucharses, {id: a_user.id}

          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to eq([{'isbn' => a_book.isbn, 'amount' => 7}])
        end
      end

      context 'with another book added twice' do
        before do
          a_cart.add(another_book, 2)
        end

        context 'that was checked out' do
          before do
            Cashier.new(instance_spy(MerchantProcessor)).charge a_cart, to: a_credit_card
          end
          it 'returns an empty list of pucharses' do
            get :pucharses, {id: a_user.id}

            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body)).to eq([
                                                        {'isbn' => a_book.isbn, 'amount' => 7},
                                                        {'isbn' => another_book.isbn, 'amount' => 2},
                                                    ])
          end
        end
      end
    end
    context 'after loading thice the same cart' do

      before do
        a_cart = create :cart_session, user: a_user
        a_cart.add(a_book, 2)
        Cashier.new(instance_spy(MerchantProcessor)).charge a_cart, to: a_credit_card
        another_cart = create :cart_session, user: a_user
        another_cart.add(a_book, 3)
        Cashier.new(instance_spy(MerchantProcessor)).charge another_cart, to: a_credit_card
      end

      it 'the sale of the book appears twice' do
        get :pucharses, {id: a_user.id}

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq([
                                                    {'isbn' => a_book.isbn, 'amount' => 2},
                                                    {'isbn' => a_book.isbn, 'amount' => 3}
                                                ])
      end
    end
  end
end
