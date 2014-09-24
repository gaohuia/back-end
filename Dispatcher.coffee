Router = require "./Router"

class Dispatcher
	constructor: ->
		@handlerMap = {}

	dispatch: (recv, send) ->
		@getRouter().setRequest(recv);
		#@getRouter().handler(recv, send)
		@getHandlerByName(@getRouter().getHandlerName()).handler(recv, send)
		
	setRouter: (@router)->
	getRouter: ->
		@router = @router ? new Router()

	setMap: (handlerName, handler) ->
		@handlerMap[handlerName] = handler

	getHandlerByName: (handlerName)->
		@handlerMap[handlerName]

module.exports = Dispatcher