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

post '/seesurvey' do

# what is a better way to do this??? can we use nested arrays?
  Answer.create(title: params[:answer_choice1], question_id: params[:question_id])
  Answer.create(title: params[:answer_choice2], question_id: params[:question_id])
  Answer.create(title: params[:answer_choice3], question_id: params[:question_id])


 redirect "/seesurvey"
end

get '/seesurvey' do

  @surveys= Survey.all
  @questions= Question.all
  @answers= Answer.all


  erb :seesurvey
end



