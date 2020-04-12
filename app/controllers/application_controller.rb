class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "its_a_secret"
  end

  get "/" do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
    end
    erb :welcome
  end

end
