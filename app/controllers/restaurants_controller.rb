class RestaurantsController < ApplicationController

    get '/restaurants' do 
        if Helpers.logged_in?(session)
            @restaurants = Restaurant.all 
            erb :'/restaurants/index'
        else 
            redirect to '/'
        end 
    end 

    post '/restaurants' do 
        restaurant = Restaurant.create(params)
        user = Helpers.current_user(session)
        restaurant.user = user 
        restaurant.save 
        redirect to "/users/#{user.id}"
    end 

    get '/restaurants/new' do 
        if Helpers.logged_in?(session)
            erb :'/restaurants/new'
        else 
            redirect to '/'
        end 
    end 

    get '/restaurants/:id' do 
        if !Helpers.logged_in?(session)
            redirect to '/'
        end 
        @restaurant = Restaurant.find_by(id: params[:id])
        if @restaurant
            erb :'/restaurants/show'
        else 
            redirect to '/restaurants'
        end 
    end 

    get '/restaurants/:id/edit' do 
        if !Helpers.logged_in?(session)
            redirect to '/'
        end 
        @restaurant = Restaurant.find_by(id: params[:id])
        if !@restaurant || Helpers.current_user(session) != @restaurant.user
            redirect to '/restaurants'
        end 
        erb :'/restaurants/edit'
    end 

    patch '/restaurants/:id' do 
        restaurant = Restaurant.find_by(id: params[:id])
        restaurant.update(params[:restaurant])
        redirect to "/restaurants/#{restaurant.id}"
    end 

end 