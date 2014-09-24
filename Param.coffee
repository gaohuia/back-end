class Param
	constructor: (@param = {})->
	setParam: (key, value) ->
		@param[key] = value
	getParam: (key, def) ->
		return @param[key] ? def ? null
	toString: ->
		JSON.stringify(@param)

module.exports = Param