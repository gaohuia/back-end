dgram = require "dgram"
Buffer = require("buffer").Buffer

test = 
	"action" : "test",
	"param"  : "Hello World"

report = 
	"action" : "report"

reply = 
	"action" : "reply",
	"data" : "123123123123123123123123"

s = dgram.createSocket "udp4"
buf = new Buffer(JSON.stringify(test))
s.send buf, 0, buf.length, 8889, "127.0.0.1", -> 
	console.log "send ok"
	#s.close()

setInterval( ->
	buf = new Buffer(JSON.stringify(report))
	s.send buf, 0, buf.length, 8889, "127.0.0.1"
, 1000
)

s.on "message", (buf, rinfo)->
	str = buf.toString()
	obj = JSON.parse str
	console.log obj
	reply.R = obj.R
	buf = new Buffer(JSON.stringify(reply))
	#s.send buf, 0, buf.length, 8889, "127.0.0.1"