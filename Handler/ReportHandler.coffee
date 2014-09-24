class ReportHandler
	handler: (recvData, sendData) ->
		console.log recvData.getServerInfoVar("rinfo")

module.exports = ReportHandler