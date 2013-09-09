get '/create' do

  erb :create_survey
end

post '/create' do #when we want multiple questions/answers, we will need ':id/create' to get survey id

  @survey = Survey.create( title: params[:title])
  p @survey

  redirect "/survey/#{@survey.id}/question/new"
end

get '/survey/:survey_id/question/new' do

 @survey = Survey.find_by_id(params[:survey_id])
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

  erb :seesurvey
end

post '/dashboard' do

# what is a better way to do this??? can we use nested arrays?
answer1 = Answer.create(title: params[:answer_choice1], question_id: params[:question_id])
answer2 = Answer.create(title: params[:answer_choice2], question_id: params[:question_id])
answer3 = Answer.create(title: params[:answer_choice3], question_id: params[:question_id])

puts answer1
puts answer2
puts answer3

redirect "/dashboard"

end

get '/seesurvey/:survey_id' do

  # so hacky -- what is a better way to do this?
  @survey= Survey.find_by_id(params[:survey_id])
  @question = Question.find_by_survey_id(params[:survey_id])
  @answer1 = Answer.find_by_question_id(@question.id)
  @answer2 = Answer.find_by_id(@answer1.id + 1)
  @answer3 = Answer.find_by_id(@answer2.id + 1)

  erb :seesurvey
end


post '/stats' do

answer= Answer.find_by_title(params[:title])
answer_user = AnswerUser.create(user_id: session[:user_id], answer_id: answer.id)

# answer_user = AnswerUser.create
# answer = Answer.find_by_title(params[:title])
# user=  User.find_by_id(session[:user_id])

# user.answer_users<<answer_user
# answer.answer_users<<answer_user

redirect '/stats'
end



get '/stats' do

@answer_user = AnswerUser.last
@answer_chosen = Answer.find_by_id(@answer_user.answer_id)

erb :stats
end
