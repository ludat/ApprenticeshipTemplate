require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  context 'with no books in the catalog' do
    it 'returns a list of all books' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([])
    end

  end

  context 'with some books in the catalog' do
    let!(:a_book) { create :harry_potter }
    let!(:another_book) { create :lotr }

    it 'returns a list of all books' do
      get :index

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([
                                                  {'isbn' => a_book.isbn},
                                                  {'isbn' => another_book.isbn}
                                              ])
    end
  end
end
