$(document).ready(function() {
  $(".all-tabs .tabs, .all-tabs-profile .tabs").removeClass("active");
  $(".tab-content").addClass("hidden");
  id = window.location.hash ;
  if ( id ) {
    $( "a[data-target='" + id + "']" ).addClass("active") ;
    $(id).removeClass("hidden");
  }


  $(function(){

    $(".all-tabs .tabs, .all-tabs-profile .tabs").on("click", function(e){
      $(".all-tabs .tabs, .all-tabs-profile .tabs").removeClass("active");
      $(this).addClass("active");

      $(".tab-content").addClass("hidden");

      id = $(this).data("target");
      $(id).removeClass("hidden");


      // make the first tab active buy clicking on it
      if (id.startsWith("#job_offer_")) {
        var candidate_list_id = id.replace("job_offer", "candidates-list");
        var candidate_lib_tab = $("a[data-target='" + candidate_list_id + "']");
        $("a[data-target='" + candidate_list_id + "']").trigger("click");
      }
    });

    $('#sidebar .tabs').click(function (e) {
      id = $(this).data("target") ;
      window.location.hash = id

    });

  });

})
