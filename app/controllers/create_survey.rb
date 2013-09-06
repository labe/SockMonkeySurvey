get '/create' do

  erb :create_survey
end

post '/create' do #when we want multiple questions/answers, we will need ':id/create' to get survey id


  survey = Survey.create( title: params[:title])

  # Survey.create_with_questions params[:survey]
    
  question = survey.questions.create( title: params[:question])

  #refactor this!! look up passing arrays thru forms (name='answers[]')
  question.answers.create(title: params[:answer1])
  question.answers.create(title: params[:answer2])
  question.answers.create(title: params[:answer3])
  question.answers.create(title: params[:answer4])

  redirect "/seesurvey/#{survey.id}"
end

get "/seesurvey/:survey_id" do

  @survey = Survey.find(params[:survey_id])
  @questions = @survey.questions
  @answers = @questions.first.answers

erb :seesurvey
end

