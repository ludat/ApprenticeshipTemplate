require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'with a valid user' do
    let(:a_user) { create :lucas }
    skip 'returns an empty list of pucharses' do
      # TODO What format do I want for this
      # if its point is only to count inventory adding an stock to each book would suffice,
      # also should each cart be considered separately, there is clearly a difference between buying hp1, hp2 and hp3
      # and that three people buy it separately,
      # FIXME: CLIENT WHAT DO YOU WANT!!!
      get :pucharses, {id: a_user.id}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([])
    end
  end
end
