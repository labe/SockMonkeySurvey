get '/' do
  erb :login
end

get '/login' do #redundant route, this does exactly the same thing as '/'
  erb :login
end

post '/login' do
  if user = User.authenticate(params[:username], params[:password])
    session[:user_id] = user.id
    redirect '/dashboard'
  else
    @errors = user.errors.messages
    erb :login
  end
end

get '/new_account' do
  erb :new_account
end

post '/new_account' do  

  user = User.create(params)
  p user.valid?
  p "*" * 99
  p "Gaby here the user is just created but not saved!"

   if user.valid? # user.save (both will work)
    p user
    p user.valid?
    user.save
    p "Gaby, here the user is saved!"
    #refactor 30-34 to: if user.save
    session[:user_id] = user.id
    redirect '/dashboard'
  else
    # p user.valid?

    @errors = user.errors.full_messages
    # @bad_errors = user.errors #this can also work 
    # p @bad_errors
    # p "Gaby!!!!!!!!!!!"
    # p @bad_errors.full_messages #this can also work 
    # p "Y" * 60
    # p @errors
    erb :new_account
  end


end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/dashboard' do # "dashboard" is usually a thing that's personalized for/unique to a user, like a profile. This is a page that displays all the available surveys and should be renamed appropriately, e.g. '/surveys/all', and moved into the survey controller
  @surveys = Survey.all
  if current_user
    erb :dashboard
  else
    redirect '/login'
  end

end





