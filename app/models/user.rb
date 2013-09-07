class User < ActiveRecord::Base
 
 #on create: That will check the format every time the object gets saved.  If you want to be more specific about when to check you can add
 # validates :password, :presence => true, :confirmation => true,:length => {:within => 6..40},:on => :create

  has_many :answers
  has_many :surveys
  
end
