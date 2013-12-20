--
-- Author: 吴晔
-- Date: 2013-12-06 15:23:20
--
require("pack")
require("bit")
local ByteArray = require("network.utils.ByteArray")
local SocketTCP = require("network.net.SocketTCP")
local login_pb = require("proto.login_pb")

local NetworkMgr = class("NetworkMgr")

function NetworkMgr:ctor(ServerIp,ServerPort)
	self.socketObj = SocketTCP.new(ServerIp, ServerPort, false)
end

-----------------------------------------------------------------------------------------
--网络API
--网络连接
function NetworkMgr:connect_server()
    self.socketObj:addEventListener(SocketTCP.EVENT_CONNECTED, self.onSocketConnect)
    self.socketObj:addEventListener(SocketTCP.EVENT_CLOSE, handler(self,self.onStatus))
    self.socketObj:addEventListener(SocketTCP.EVENT_CLOSED, handler(self,self.onStatus))
    self.socketObj:addEventListener(SocketTCP.EVENT_CONNECT_FAILURE, handler(self,self.onStatus))
    self.socketObj:addEventListener(SocketTCP.EVENT_DATA, handler(self,self.onData))
    self.socketObj:connect()
end

--网络发送数据
function NetworkMgr:send_message(msg)
    local __pack = self:getDataByLpack(msg)
	self.socketObj:send(__pack)
end

--打包消息
function NetworkMgr:getDataByLpack(msg)
    local __data = json.encode(msg)
    --将消息与通信协议头打包
    local __pack = string.pack(">AAAAAiiiA",string.char(78),string.char(37),string.char(38),string.char(48),string.char(9), 0,string.len(__data)+4,msg.msgID,__data)
    return __pack
end

--关闭网络
function NetworkMgr:close()
	self.socketObj:disconnect()
end

-----------------------------------------------------------------------------------------
--网络事件处理函数
function NetworkMgr:onSocketConnect(event)
    print("================与服务端连接成功================")
end

function NetworkMgr:onStatus(__event)
    --echoInfo("socket status: %s", __event.name)
    print(__event.data)
end

function NetworkMgr:onData(__event)
    local __ba = ByteArray.new()
    __ba:writeBuf(__event.data)
    -- 能猜出来就行
    __ba:setPos(17)
    --print("====================您有1条新消息 请注意查收====================")
    local msg = {msgID,data}
    msg.msgID = __ba:readByte()
    local strLen = __ba:getAvailable()
    msg.data =  json.decode(__ba:readString(strLen))
    login_pb.deal(msg)

    --print("消息内容:",msg.data)
    --print("消息ID:", msg.msgID)
end

return NetworkMgr