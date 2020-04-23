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
        @restaurant = Restaurant.create(params[:restaurant])
        menu_items = params[:menu_items]
        menu_items.each do |item|
            menu_item = MenuItem.create(item)
            menu_item.restaurant = @restaurant
            menu_item.save
        end 
        user = Helpers.current_user(session)
        @restaurant.user = user 
        if @restaurant.save 
            redirect to "/restaurants/#{@restaurant.id}"
        else 
            erb :'/restaurants/new'
        end 
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
        @menu_items = @restaurant.menu_items
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
        @menu_items = @restaurant.menu_items
        if !@restaurant || Helpers.current_user(session) != @restaurant.user
            redirect to '/restaurants'
        end 
        erb :'/restaurants/edit'
    end 

    patch '/restaurants/:id' do 
        restaurant = Restaurant.find_by(id: params[:id])
        if restaurant && restaurant.user == Helpers.current_user(session)
            params[:menu_items].each do |item|
                i = MenuItem.find_by(id: item["id"])
                if i 
                    i.update(name: item["name"], description: item["description"])
                else 
                    i = MenuItem.create(name: item["name"], description: item["description"])
                    i.restaurant = restaurant
                    i.save
                end 
            end 
            restaurant.update(params[:restaurant])
            redirect to "/restaurants/#{restaurant.id}"
        else 
            redirect to '/restaurants'
        end 
    end 

    delete '/restaurants/:id/delete' do 
        if !Helpers.logged_in?(session)
            redirect to '/'
        end 
        restaurant = Restaurant.find_by(id: params[:id])
        if restaurant && restaurant.user == Helpers.current_user(session)
            restaurant.destroy
        end 
        redirect to '/restaurants'
    end 

end 