$(function(){
  // var $ppc = $('.progress-pie-chart'),
  //   percent = parseInt($ppc.data('percent')),
  //   deg = 360*percent/100;
  // if (percent > 50) {
  //   $ppc.addClass('gt-50');
  // }
  // $('.ppc-progress-fill').css('transform','rotate('+ deg +'deg)');
  // $('.ppc-percents span').html(percent+'%');

  $('[data-skill]').each(function(){
  var item = $(this),
    skill = item.data('skill'),
    size = item.data('skill-size'),
    border = 5,
    radius = 50,
    circumference = 2 * Math.PI * radius,
    progress = circumference - ((circumference / 100) * skill),
    speed = 1000;
  item.append('<h3>0</h3><svg><circle class="back" /><circle class="front" /></svg>');
  $({Counter: 0}).animate({
      Counter: skill
    }, {
      duration: speed,
      easing: 'swing',
      step: function () {
      item.find('h3').text(Math.ceil(this.Counter) + '%');
    }
  });
  item.find('svg').width(200).height(200);
  item.find('circle').attr({
    'r' : radius,
    'cy' : radius + border,
    'cx' : radius + border
  });
  item.find('.front').css({
    'stroke-dasharray' : circumference,
    'stroke-dashoffset' : circumference
  }).animate({
    'stroke-dashoffset' : progress
  }, speed);
  });
});
