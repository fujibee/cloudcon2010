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
  return img;
}

var animateElephant = function() {
  var img = createElephant();
  $('#world').append(img);
  var top = 400 - 58 * col;
  img.animate({top: top + "px"}, 1000, "easeOutBounce");
  row++;
  col = Math.floor(row / numOfRows);
}

var run = function() {
  var elephantTimerId;
  $.getJSON('/console/slaves.json', function(data) {
    elephantTimerId = setInterval(function() {
      if(++count <= data.length) {
        $('#counter').text(count);
        animateElephant();
      } else {
        clearInterval(elephantTimerId);
      }
    }, 1000);
  })
}

$(function(){
  setInterval(run, 1000);
});