require './config/environment'

class UserController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by(username: params[:slug].split("-").join(" "))
    erb :"users/show"
  end

end
