require './config/environment'

class TweetController < ApplicationController

  get '/tweets' do
    if !session[:user_id].nil?
      @tweets = Tweet.all
      erb :"tweets/index"
    else
      redirect to "/login"
    end
  end

  get '/tweets/new' do
    if !session[:user_id].nil?
      @user = User.find(session[:user_id])
      erb :"tweets/new"
    else
      redirect to "/login"
    end
  end

  post '/tweets' do
    if !params[:content].empty?
      @tweet = Tweet.create(params)
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if !session[:user_id].nil?
      erb :"tweets/show"
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if !session[:user_id].nil?
      @tweet = Tweet.find(params[:id]) #why does test in line 370 fail if this is out of if statement?
      @user = User.find(session[:user_id])
      erb :"tweets/edit"
    else
      redirect to '/login'
    end
  end

  post '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @user = User.find(session[:user_id])
    if !params[:content].empty? && @user.tweets.include?(@tweet)
      @tweet.update(params)
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    @user = User.find(session[:user_id]) #don't need to check if they're logged in b/c this is located on show page and the route to that page checks already
    if @user.tweets.include?(@tweet)
      @tweet.destroy
    end
  end

end
