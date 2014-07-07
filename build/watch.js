require('shelljs/global');

var watch = require('node-watch');

watch(__dirname+'/../src/', function(filename) {
  console.log('building');
//  var res = exec('haxe build/build.hxml');
//  var res = exec('sudo killall -9 openfl.xml');
  var res = exec('lime test openfl.xml html5');
  if (res.code === 0) console.log('success');
});
