class GamesController < ApplicationController
  def create
    user_id = JWT.decode(
        request.headers['Authorization'].split(' ').last, nil, false).first['user']['id']
    user = User.find(user_id)
    # render json: Game.for(User.find(user_id)session[:login])
    render json: Game.for(user)
  end

  def show
    render json: Game.find(params[:id])
  end
# GET 	/photos 	photos#index 	display a list of all photos
# GET 	/photos/new 	photos#new 	return an HTML form for creating a new photo
# POST 	/photos 	photos#create 	create a new photo
# GET 	/photos/:id 	photos#show 	display a specific photo
# GET 	/photos/:id/edit 	photos#edit 	return an HTML form for editing a photo
# PATCH/PUT 	/photos/:id 	photos#update 	update a specific photo
# DELETE 	/photos/:id 	photos#destroy 	delete a specific photo
end
