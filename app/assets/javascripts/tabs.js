$(function(){

  $(".tabs").on("click", function(e){
    $(".tabs").removeClass("active");
    $(this).addClass("active");

    $(".tab-content").addClass("hidden");

    id = $(this).data("target");
    $(id).removeClass("hidden");


    $(function(){
      var hash = window.location.hash;
      hash && $('ul.nav a[data-target="' + hash + '"]').tab('show');

      $('.tabs a').click(function (e) {
        $(this).tab('show');
        window.location.hash = this.hash;
      });

    });
});
});

