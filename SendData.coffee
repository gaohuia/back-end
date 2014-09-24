Param = require "./Param"
ReplyManager = require "./ReplyManager"

class SendData extends Param
	constructor: (@server)->
		super()
	# 设置了callback 意味着这个请求将会有返回数据
	flush: (callback = null)->
		if callback isnt null
			ReplyManager.getInstance().registerSend(@, callback)
		@server.send(@)
	setRemote: (@remote)->
	getRemote: ->
		@remote

	getServer: ->
		@server

module.exports = SendData