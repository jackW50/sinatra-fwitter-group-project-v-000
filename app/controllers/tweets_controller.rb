class TweetsController < ApplicationController
  
  get '/tweets' do
    #binding.pry
    if logged_in?
      @tweets = Tweet.all
      @user = current_user 
      erb :"/tweets/tweets"
    else 
      redirect "/login"
    end 
  end 
  
  get '/tweets/new' do
    #binding.pry 
    if logged_in? 
      erb :"/tweets/new"
    else 
      redirect "/login"
    end 
  end 
  
  post '/tweets' do
    #binding.pry 
    tweet = Tweet.new(params)
    tweet.user = current_user 
    if tweet.save
      redirect "/tweets/#{tweet.id}"
    else 
      redirect "/tweets/new"
    end 
  end 
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/show_tweet"
    else 
      redirect :"/login"
    end 
  end 
  
  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id && logged_in?
      erb :"/tweets/edit_tweet"
    else 
      redirect "/login"
    end 
  end 
  
  patch '/tweets/:id' do
    #binding.pry 
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id 
      tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    else 
      redirect "/login"
    end 
  end 
  
  delete '/tweets/:id/delete' do 
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id && logged_in?
      tweet.destroy 
      redirect "/tweets"
    else 
      redirect "/login"
    end 
  end 

end
