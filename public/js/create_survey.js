$(document).ready(function(){

  $('#survey_form').on('submit', function(e){
    e.preventDefault();

    $.ajax({
      url: this.action,
      type: this.method,
      data: $(this).serialize()
    }).done(function(server_response){ 
      console.log('no errors..')
      $('#survey_title').hide();
      $('.appender').append(server_response);
    }).fail(function(){
      console.log("error yo");
    });
  });

// "input[value='add this question']"
$('.appender').on('submit', "#question_form", function(e){
  e.preventDefault();
  console.log('we made it to the second click!');
    // breaking here!
    $.ajax({
      url: this.action,
      type: this.method,
      data: $(this).serialize()
    }).done(function(server_response){
      console.log('yay! all done!');
      $('#question_form').hide();
      $('.appender').append(server_response);
    }).fail(function(){
      console.log("second ajax call; error");
    });
  });

$('.appender').on('keypress', "#number_of_answers", function(e){
  e.preventDefault();
  console.log('we made it to the second click!');
  $.ajax({
    url: this.action,
    type: this.method,
    data: $(this).serialize()
  }).done(function(server_response){
    console.log('yay! all done!');
    $('.appender').append(server_response);
  }).fail(function(){
    console.log("second ajax call; error");
  });
});
});

// is there a way to use modals to make question pop?