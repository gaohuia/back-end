ReceiveData = require "./ReceiveData"
SendData = require "./SendData"
Dispatcher = require "./Dispatcher"
Remote = require "./Remote"

dgram = require "dgram"
Buffer = require("buffer").Buffer

ServerStatus = 
	RUNNING : "running"
	STOPPED : "stopped"

ServerConfig = 
	port : 8889
	type : "udp4"

class Server
	constructor: ()->
		@status = ServerStatus.STOPPED
		@socket = null
		@dispatcher = null

	getDispatcher: ->
		@dispatcher = @dispatcher ? new Dispatcher()

	setDispatcher: (@dispatcher)->
		@dispatcher

	send: (_sendData) ->
		#@sendRaw _sendData + "", 
		buf = new Buffer _sendData.toString()
		console.log buf
		console.log _sendData.getRemote()
		console.log _sendData.getRemote().getPort()
		@socket.send buf, 0, buf.length, _sendData.getRemote().getPort(), _sendData.getRemote().getIp()
	sendRaw: (raw, port) ->
		buf = new Buffer(raw)
		@socket.send buf, 0, buf.length, 
	isStarted: ->
		@status is ServerStatus.RUNNING

	#start the service
	start: ()->
		@socket = dgram.createSocket ServerConfig.type
		
		@socket.on "message", (msg, rinfo) => 
			param = JSON.parse(msg.toString())
			recv = new ReceiveData(param)

			#address, family, port, size
			recv.setServerInfo
				"rinfo" : rinfo

			remote = new Remote rinfo.address, rinfo.port
			recv.setRemote remote

			send = new SendData(@)
			send.setRemote(remote)
			@getDispatcher().dispatch(recv, send)

		@socket.on "listening", => 
			console.log "listening"
			@status = ServerStatus.RUNNING

		@socket.on "close", => 
			console.log "stoped"
			@status = ServerStatus.STOPPED

		@socket.bind ServerConfig.port
	stop: ()->
		@socket.close()

module.exports = Server