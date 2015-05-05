$( document ).ready(function(){

  $("form").on("submit", function(e){
    e.preventDefault();

    response = $.ajax({
      url: '/questions',
      datatype: 'json',
      type: 'post',
      data: $(this).serialize(),
    })

    response.done(function( data ) {
      console.log(data)
      $('.question-display-container').prepend(data)
    })

  })

});
