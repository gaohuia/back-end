class Remote
	constructor : (@ip, @port)->
	getIp: ->
		@ip
	getPort: ->
		@port

module.exports = Remote