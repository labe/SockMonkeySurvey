get '/create' do

  erb :create_survey
end

post '/create' do #when we want multiple questions/answers, we will need ':id/create' to get survey id

  @survey = Survey.create( title: params[:title])

  erb :_question_form, layout: false
  # redirect "/seesurvey/#{survey.id}"
end

post '/question_new' do
  
  @question = Question.create( title: params[:title])
  # need to relate to survey_id

  erb :_answer_form, layout: false
end

post '/answer_new' do

  @answer_count = params[:quantity].to_i
  

  erb :_answer_popup, layout: false
end

get '/seesurvey' do


  erb :seesurvey
end

post '/seesurvey' do
#store answers here!!

 redirect '/seesurvey'
end

