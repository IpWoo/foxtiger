if kode == nil then return end

local Event = require "app.config.events"
local login_pb = require("proto.login_pb")

local LoginService = BaseService:extend()
local meta = LoginService

function meta:reqFunction()
	-- body
end

function meta:onFunction(param)
	if param.msgID == 101 then
		self:notify(Event.RE_LOGIN, {notice = param})
    end
end

function meta:registLogin_pb()
	login_pb.regist(101,handler(meta,meta.onFunction))
	login_pb.regist(104,handler(meta,meta.onFunction))
end

meta:registLogin_pb()

return meta
