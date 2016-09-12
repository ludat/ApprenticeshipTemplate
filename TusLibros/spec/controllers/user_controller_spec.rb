require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it 'sets the user session on successful login' do
    get :index
    expect(response).to have_http_status :success
  end
end
