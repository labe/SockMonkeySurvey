class Answer < ActiveRecord::Base
  belongs_to :question

  #need join associations for answer_user
end
