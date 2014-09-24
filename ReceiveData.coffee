Param = require "./Param"
Remote = require "./Remote"

class ReceiveData extends Param
	setServerInfo: (@serverInfo)->
	
	# 获取一些服务器获取到的信息，如远程ip, 远程端口等
	getServerInfoVar: (key, def)->
		@serverInfo[key] ? def ? null

	setRemote: (@remote)->

	getRemote: ->
		@remote

module.exports = ReceiveData