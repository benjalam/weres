$(document).ready(function() {

  $(".tabs").removeClass("active");
  $(".tab-content").addClass("hidden");
  id = window.location.hash ;
  if ( id ) {
    $( "a[data-target='" + id + "']" ).addClass("active") ;
    $(id).removeClass("hidden");
  }


  $(function(){

    $(".tabs").on("click", function(e){
      $(".tabs").removeClass("active");
      $(this).addClass("active");

      $(".tab-content").addClass("hidden");

      id = $(this).data("target");
      $(id).removeClass("hidden");

      });


    $('#sidebar .tabs').click(function (e) {
      id = $(this).data("target") ;
      window.location.hash = id

    });

  });


})

