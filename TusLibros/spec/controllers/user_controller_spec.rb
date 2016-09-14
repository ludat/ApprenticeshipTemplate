require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'with a valid user' do
    let(:a_user) { create :lucas }
    it 'returns an empty list of pucharses' do
      get :pucharses, {id: a_user.id}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([])
    end
  end

  context 'with a valid user' do
    let(:a_user) { create :lucas }
    let(:a_credit_card) { create :credit_card, user: a_user}
    let(:a_cart) { create :cart_session, user: a_user }
    let(:a_book) { create :harry_potter }

    before do
      a_cart.add(a_book, 1)
      Cashier.new(instance_spy(MerchantProcessor)).charge a_cart, to: a_credit_card
    end

    it 'returns an empty list of pucharses' do
      get :pucharses, {id: a_user.id}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([{'isbn' => a_book.isbn, 'amount' => 1}])
    end
  end
end
