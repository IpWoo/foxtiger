--
-- Author: 吴晔
-- Date: 2013-12-06 15:23:20
--
require("pack")
require("bit")
local SocketTCP = require("network.net.SocketTCP")

local NetworkMgr = class("NetworkMgr")

function NetworkMgr:new(o)  
    o = o or {}  
    setmetatable(o,self)  
    self.__index = self  
    
    return o  
end  

function NetworkMgr:Instance()  
    if self.instance == nil then  
        self.instance = self:new()  
        self.socketObj = nil
    end  
    return self.instance  
end 

--function NetworkMgr:ctor()
	--self.socketObj = nil
--end

-----------------------------------------------------------------------------------------
--网络API
--网络连接
function NetworkMgr:connect_server(ServerIp,ServerPort)
	if not self.socketObj then
        self.socketObj = SocketTCP.new(ServerIp, ServerPort, false)
        self.socketObj:addEventListener(SocketTCP.EVENT_CONNECTED, self.onSocketConnect)
        self.socketObj:addEventListener(SocketTCP.EVENT_CLOSE, handler(self,self.onStatus))
        self.socketObj:addEventListener(SocketTCP.EVENT_CLOSED, handler(self,self.onStatus))
        self.socketObj:addEventListener(SocketTCP.EVENT_CONNECT_FAILURE, handler(self,self.onStatus))
        self.socketObj:addEventListener(SocketTCP.EVENT_DATA, handler(self,self.onData))
    end
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
    print("连接成功")
end

function NetworkMgr:onStatus(__event)
    --echoInfo("socket status: %s", __event.name)
    print(__event)
end

function NetworkMgr:onData(__event)
    --echoInfo("socket status: %s, partial:%s", __event.name)
    print(__event)
end

return NetworkMgr