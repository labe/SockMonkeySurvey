class User < ActiveRecord::Base


  validate :username_valid?, :password_valid?
  #AR has a built in validation option to customize the :message (and check for presence_of). use those instead of creating validation methods.
  
  has_many :answers #has this through the answer_user join-- need to establish the join association
  has_many :surveys #these are the surveys a user is the creator for. look into the :source option and alias this to :created_surveys

  #missing join associations for having many surveys taken. use a :taken_surveys alias

  include BCrypt

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
  
#==> custom error methods>

  def username_valid?
    if username == ""
      errors.add(:username, " can't be empty! ")
    end
  end

def password_valid?
  if password == ""
    errors.add(:password, " can't be empty! ")
  end

end

end
