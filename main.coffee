Server = require "./Server"
Dispatcher = require "./Dispatcher"
Router = require "./Router"
SendData = require "./SendData"

TestHandler = require "./Handler/TestHandler"
ReplyHandler = require "./Handler/ReplyHandler"
ReportHandler = require "./Handler/ReportHandler"

disp = new Dispatcher()

disp.setRouter(new Router())

# test请求的处理类
disp.setMap "test", new TestHandler()
disp.setMap "reply", new ReplyHandler()
disp.setMap "report", new ReportHandler()

s = new Server()
s.setDispatcher(disp)
s.start()