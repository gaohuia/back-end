class Router
	constructor: ->
		@request = null
	setRequest: (@request)->

	getRequest: ->
		@request

	getHandlerName: ->
		return @request.getParam "action"

module.exports = Router