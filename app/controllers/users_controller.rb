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
        if Helpers.logged_in?(session)
            user = Helpers.current_user(session)
            redirect to "/users/#{user.id}"
        else 
            erb :'/users/login'
        end 
    end 

    post '/login' do 
        user = Helpers.current_user(session)
        if user && user.authenticate(params: [:password])
            session[:user_id] = user.id 
            redirect to "/users/#{user.id}"
        else 
            redirect to '/'
        end 
    end 

    get '/users/:id' do 
        erb :'/users/show'
    end 

    get '/logout' do 
        session.clear 
        redirect to '/'
    end 

end 