class UsersController < ApplicationController

    get '/signup' do 
        if Helpers.logged_in?(session)
            user = Helpers.current_user(session)
            redirect to "/users/#{user.id}"
        else 
            erb :'/users/signup'
        end 
    end 

    post '/signup' do 
        user = User.create(params)
        if user.valid?
            session[:user_id] = user.id
            redirect to "/users/#{user.id}" 
        else 
            redirect to '/signup'
        end 
    end
    
    get '/login' do 
        erb :/users/login
    end 

    post '/login' do 
    end 

    get '/users/:id' do 
        erb :'/users/show'
    end 

end 