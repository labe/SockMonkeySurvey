class User < ActiveRecord::Base
 
  validates :username, :presence => true, 
                    :uniqueness => true
  validates :password, :presence => true

  has_many :answers
  has_many :surveys

  include BCrypt   #the following code is copy and pasted from the bcrypt website

  def password 
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @password ||= Password.create(pass)
    self.password_hash = @password
  end

# To avoid someone trying to create a new account with an invalid submission


# from Bcrypt ==>

 def self.create(params)
  p params
    @user = User.new(:username => params[:username])

    @user.password = params[:password]
    @user
  end

# <==

    def self.authenticate(username,password)
    user = User.find_by_username(username)
    (user && user.password == password) ? user : nil
  end
  
end
