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
        @restaurant = Restaurant.find_by(id: params[:id])
        if @restaurant && Helpers.logged_in?(session)
            erb :'/restaurants/show'
        else 
            redirect to '/'
        end 
    end 

end 