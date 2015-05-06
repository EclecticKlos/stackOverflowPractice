$( document ).ready(function(){

  $(".new_answer").on("submit", function(e){
    e.preventDefault();

    response = $.ajax({
      url: $('.new_answer').attr('action'),
      datatype: 'json',
      type: 'post',
      data: $(this).serialize(),
    })

    response.done(function( data ) {
      console.log(data)
      $('.answer-display-container').prepend(data)
    })

  })

});
