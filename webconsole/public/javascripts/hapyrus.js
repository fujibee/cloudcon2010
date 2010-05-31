var log = function() {
  if(window.console) {
    var msgs = "";
    for(var i=0; i<arguments.length; i++) msgs += arguments[i].toString();
    console.debug(msgs);
  }
}

var src = "/images/elephants.png";

var count = 0;
var row = 0;
var col = 0;
var numOfRows = 10;
var totalElephants;

var createElephant = function() {
var img = $('<img>');
  img.attr("src", src).attr("width", 90).attr("height", 60);
  img.css("position", "absolute");
  img.css("left", 88 * (row % numOfRows));
  img.css("top", "-200px");
  img.addClass('elephant');
  return img;
}

var dropElephant = function() {
  var img = createElephant();
  $('#world').append(img);
  var top = 550 - 58 * col;
  img.animate({top: top + "px"}, 1000, "easeOutBounce");
  row++;
  col = Math.floor(row / numOfRows);
}

var throwElephant = function(n) {
  var img = $('.elephant:eq(' + n + ')');
  if(!img) {
    log(n, "not found");
    return;
  }
  img.animate({opacity: 0}, 1000, "easeInQuart", function(){ log("done"); $(this).remove() });
  row--;
  col = Math.floor(row / numOfRows);
}

var showElephants = function(num) {
  for(var i=0; i<num; i++) {
    var img = createElephant();
    $('#world').append(img);
    var top = 550 - 58 * col;
    img.css("top", top);
    row++;
    col = Math.floor(row / numOfRows);
  }
}

var run = function() {
  var elephantTimerId;
  $.getJSON('/console/slaves.json', function(data) {
    elephantTimerId = setInterval(function() {
      if(count == data.length) {
        clearInterval(elephantTimerId);
      } else if(count < data.length) {
        ++count;
        $('#counter').text(count);
        dropElephant();
      } else if(count > data.length) {
        --count;
        $('#counter').text(count);
        throwElephant(count);
      }
    }, 1000);
  });
}

var runForJob = function() {
  $.getJSON('/console/hadoop.json', function(data) {
    animateMapBar(data.map);
  })
}

var showMapBar = function(per) {
  var h = 400 * per / 100;
  var t = 400 - h;
  $('#mapRect').css({height: h, top: t});
}

var animateMapBar = function(per) {
  var h = 400 * per / 100;
  var t = 400 - h;
  $('#mapRect').animate({height: h, top: t}, 1000);
}