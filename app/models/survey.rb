class Survey < ActiveRecord::Base
  belongs_to :user	#use :creator alias
  has_many :questions

  #need join associations for survey_user
end
