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

  redirect '/question/#{@question.id}/answer/new'
end

get '/question/:question_id/answer/new' do

  @question= Question.find_by_id(params[:question_id])

  erb :_answer_form, layout: false
end

post '/answer_new' do

  @question= Question.find_by_id(params[:question_id])

  @answer_count = params[:quantity].to_i

  redirect '/question/#{@question.id}/answer/create'
end

get '/question/:question_id/answer/create' do
  
  @question= Question.find_by_id(params[:question_id])

  erb :_answer_popup, layout: false
end

post '/seesurvey' do

  @answer_choices = params[:answer_choices]
  p "*" * 60
  p @answer_choices

  @answer_choices.each do |answer|
    p "EACH ANSWER OMG IT WORKED"
    p Answer.create(title: params[:answer_choice], question_id: params[:question_id])
  end

 redirect '/seesurvey/#{@answers}'
end

get '/seesurvey' do


  erb :seesurvey
end



