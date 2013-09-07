
get '/' do
  # Look in app/views/index.erb
  erb :login
end

post '/login' do
  @user = User.find_by_username(params[:username])
  redirect "/dashboard"
end

get '/signup' do
  erb :signup
end

post '/signup' do  

  @user = User.new(params)
  p @user
  # user.username = params[:username]
  # user.password = params[:password]
  if @user.save
    redirect "/dashboard"
  else
    "errors"
  end
end

get '/dashboard' do
  erb :dashboard
end


