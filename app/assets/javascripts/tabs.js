$(function(){

  $(".tabs").on("click", function(e){
    $(".tabs").removeClass("active");
    $(this).addClass("active");

    $(".tab-content").addClass("hidden");

    id = $(this).data("target");
    $(id).removeClass("hidden");
});
});

