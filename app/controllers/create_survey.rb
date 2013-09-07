get '/create' do

  erb :create_survey
end

post '/create' do #when we want multiple questions/answers, we will need ':id/create' to get survey id

  @survey = Survey.create( title: params[:title])

  erb :_question_form, layout: false
  # redirect "/seesurvey/#{survey.id}"
end

get "/seesurvey/:survey_id" do

  @survey = Survey.find(params[:survey_id])
  @questions = @survey.questions
  @answers = @questions.first.answers

erb :seesurvey
end

