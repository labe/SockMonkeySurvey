#routes need to be more RESTful.
#filename should just be survey.rb since this controller involves routes beyond just creating the survey
get '/create' do # <- which resource are you creating? (change to '/survey/create')

  erb :create_survey
end

post '/create' do #(when we want multiple questions/answers, we will need ':id/create' to get survey id)

  @survey = Survey.create( title: params[:title])
  p @survey

  redirect "/survey/#{@survey.id}/question/new"
end

get '/survey/:survey_id/question/new' do

 @survey = Survey.find_by_id(params[:survey_id])
 # Survey.find_by_id is the same as Survey.find
 p @survey

 erb :_question_form, layout: false
end

post '/question_new' do
  p "QUESTION PARAMS"
  p params
  @question = Question.create(title: params[:title], survey_id: params[:survey_id])

  redirect to("/question/#{@question.id}/answer/new")
end

get '/question/:question_id/answer/new' do

  @question= Question.find_by_id(params[:question_id])

  erb :_answer_popup, layout: false
end

post '/answer_new' do

  @question= Question.find_by_id(params[:question_id])

  redirect "/question/#{@question.id}/answer/create"
end

get '/question/:question_id/answer/create' do

  @question= Question.find_by_id(params[:question_id])

  erb :seesurvey #change to :survey
end

post '/dashboard' do #why is this posting to dashboard? change route name to match the get route from which this data is being sent

# (what is a better way to do this??? can we use nested arrays?)
# check out:
# http://stackoverflow.com/questions/4425176/in-rails-how-to-handle-multiple-checked-checkboxes-just-split-on-the-or
# http://www.skuunk.com/2008/05/checkbox-arrays-in-rails.html
answer1 = Answer.create(title: params[:answer_choice1], question_id: params[:question_id])
answer2 = Answer.create(title: params[:answer_choice2], question_id: params[:question_id])
answer3 = Answer.create(title: params[:answer_choice3], question_id: params[:question_id])

puts answer1
puts answer2
puts answer3

redirect "/dashboard"

end

get '/seesurvey/:survey_id' do #can just be '/survey/:survey_id'

  # (so hacky -- what is a better way to do this?)
  # check out http://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations -lla
  @survey= Survey.find_by_id(params[:survey_id])
  @question = Question.find_by_survey_id(params[:survey_id])
  @answer1 = Answer.find_by_question_id(@question.id)
  @answer2 = Answer.find_by_id(@answer1.id + 1)
  @answer3 = Answer.find_by_id(@answer2.id + 1)
  #alternatively, if you know you'll only have one question per survey, you can preload @answers = Answer.where(:question_id => @question.id)

  erb :seesurvey #change to :survey
end


post '/stats' do #change route name to match the get route from which this data is being sent

answer= Answer.find_by_title(params[:title])
answer_user = AnswerUser.create(user_id: session[:user_id], answer_id: answer.id)
#if your associations are set up correctly, line 89 can be answer.users << current_user

redirect '/stats'
end



get '/stats' do

@answer_user = AnswerUser.last
@answer_chosen = Answer.find_by_id(@answer_user.answer_id)

erb :stats
end
