var http = require('http');
var host = require('os').hostname();
var redis = require('redis');
var client = redis.createClient('db');

client.on('error', function (err) {
    console.log('Error ' + err);
});

var serve = function(port) {
  http.createServer(function (req, res) {
	client.incr('counter', function(err, count) {
		var log = 'Greetings from ' + host + ':' + port + "\n";
		log += 'Access counter ' + count + "\n";
		log += 'Remote address ' + req.connection.remoteAddress + "\n";
		if (req.headers['x-forwarded-for']) {
			log += 'Remote address ' + req.headers['x-forwarded-for'] + "\n";
		}

		res.writeHead(200, {'Content-Type': 'text/plain'});
		res.write(log);
		res.end();

		console.log(log);
	});
  }).listen(port);
}

serve(80);
serve(8001);
serve(8002);
serve(8003);
