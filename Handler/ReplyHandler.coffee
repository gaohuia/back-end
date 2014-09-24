ReplyManager = require "../ReplyManager"

class ReplyHandler
	handler: (recvData, sendData)->
		ReplyManager.getInstance().handler(recvData, sendData)

module.exports = ReplyHandler