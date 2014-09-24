class ReplyManager
	constructor: ->
		@sendMap = {}
		setInterval =>
			console.log "clear"
			now = Date.now()
			console.log @sendMap
			@sendMap[key] = null for key, data of @sendMap when data isnt null and now - data.time > 3000
			console.log @sendMap
			1
		,10000

	registerSend: (sendData, callback)->
		key = @generateKey()
		sendData.setParam "R", key
		@sendMap[key] = 
			sendData : sendData
			callback : callback
			time: Date.now()
		key

	# 如果是一个回复请求，将请求送到这里处理
	handler: (recvData, sendData)->
		R = recvData.getParam("R")
		if R 
			callback = @sendMap[R]
			if callback 
				callback.callback(recvData, sendData)
				@sendMap[recvData.getParam] = null


	# 产生一个没有使用过的key
	generateKey: ->
		while true
			key = Math.random() * 999999999 // 1
			if !@sendMap[key]
				break
		key

ins = null
module.exports.getInstance = ->
	ins = ins ? new ReplyManager()