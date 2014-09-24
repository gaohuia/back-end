Handler = require "../Handler"
SendData = require "../SendData"

class TestHandler extends Handler
	handler: (recv, send)->
		console.log "test ok, recv data: " + recv.getParam "param"
		rinfo = recv.getServerInfoVar "rinfo"
		console.log rinfo

		setTimeout ->
			sendData = new SendData(send.getServer())
			sendData.setRemote(send.getRemote())
			sendData.setParam "action", "ask"
			sendData.flush (recv, send)->
				data = recv.getParam "data"
				console.log "get data: " + data
		, 2000

module.exports = TestHandler