$(document).ready(function() {

  $(".menu-tab").removeClass("active");
  $(".menu-tab-content").addClass("hidden");
  id = window.location.hash ;
  if ( id ) {
    $( "a[data-target='" + id + "']" ).addClass("active") ;
    $(id).removeClass("hidden");
  }


  $(function(){

    $(".menu-tab").on("click", function(e){
      $(".menu-tab").removeClass("active");
      $(this).addClass("active");

      $(".menu-tab-content").addClass("hidden");

      id = $(this).data("target");
      $(id).removeClass("hidden");

      });


    $('.menu-tabs .menu-tab').click(function (e) {
      id = $(this).data("target") ;
      window.location.hash = id

    });

  });


})

