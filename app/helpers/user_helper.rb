
def current_user
  User.find(session[:user_id]) if session[:user_id]
end

# If a user has signed in and session[:user_id] has been set, calling 
# this method will return the relevant User object. Else, the method 
# will return nil. 


# There are other ways to write code that produces the same result. This one
# is the simplest