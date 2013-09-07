$(document).ready(function(){

  $('#survey_form').on('submit', function(e){
    e.preventDefault();

    $.ajax({
      url: this.action,
      type: this.method,
      data: $(this).serialize()
    }).done(function(server_response){ //server_response returns whatever the view is from my route (in this case, at least); whatever the route returns gets put into this variable
      console.log('no errors..')
      $('#survey_title').hide();
      $('#survey_form').append(server_response);
    }).fail(function(){
      console.log("error yo");
    });
  });
});

// is there a way to use modals to make question pop?