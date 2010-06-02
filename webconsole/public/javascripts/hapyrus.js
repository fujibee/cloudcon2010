/* Utils */

var log = function() {
  if(window.console) {
    var msgs = "";
    for(var i=0; i<arguments.length; i++) msgs += arguments[i].toString();
    console.debug(msgs);
  }
}

function fillZero( number, size ) {
  if ( number < 0 ) throw "illegal argument.";
  var s = number != 0 ? Math.log( number ) * Math.LOG10E : 0;
  for( i=1,n=size-s,str="";i<n;i++ ) str += "0";
  return str+number;
}

/* Hapyrus */

var src = "/images/elephant_slim.png";
var srcWidth = 51;
var srcHeight = 34;


var count = 0;
var row = 0;
var col = 0;
var numOfRows = 10;
var totalElephants;

var createElephant = function() {
var img = $('<img>');
  img.attr("src", src).attr("width", srcWidth).attr("height", srcHeight);
  img.css("position", "absolute");
  img.css("left", (srcWidth - 2) * (row % numOfRows));
  img.css("top", (- $('#top').height()) + "px");
  img.addClass('elephant');
  return img;
}

var dropElephant = function() {
  var img = createElephant();
  $('#world').append(img);
  var top = ($('#world').height() - srcHeight) - (srcHeight - 2) * col;
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
    var top = ($('#world').height() - srcHeight) - (srcHeight - 2) * col;
    img.css("top", top);
    row++;
    col = Math.floor(row / numOfRows);
  }
}

var JOB_STATUS = {
  1: 'running',
  2: 'succeeded',
  3: 'failed',
  4: 'prep',
  5: 'killed'
}


var isJobFinished = function(state) {
  return state == '2' || state == '3' || state == '5';
}

var formatSec = function(sec) {
  var h = 0, m = 0, s = 0;
  if(sec > 3600) {
    h = Math.floor(sec / 3600);
    m = Math.floor((sec - h * 3600) / 60);
    s = sec - h * 3600 - m * 60;
  } else if(sec > 60) {
    m = Math.floor((sec - h * 3600) / 60);
    s = sec - h * 3600 - m * 60;
  } else {
    s = sec;
  }
  return fillZero(h, 2) + ':' + fillZero(m, 2) + ':' + fillZero(s, 2);
}

var formatDate = function(date) {
  return date.getFullYear() + "/" + fillZero(date.getMonth() + 1, 2) + "/" + fillZero(date.getDate(), 2) + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
}

var animateBar = function(elmId, ratio) {
  var h = 400 * ratio;
  var t = 400 - h;
  $(elmId).animate({height: h, top: t}, 1000);
}

var drawBar = function(elmId, ratio) {
  var h = 400 * ratio;
  var t = 400 - h;
  $(elmId).css({opacity: "0.4", height: h, top: t});
}
