if kode == nil then return end

local Event = require "app.config.events"
local login_pb = require("proto.login_pb")
local LoginData = require("app.model.data.LoginData")

local LoginController = BaseController:extend{
	name = "LoginController2013-03-13";
}
local meta = LoginController

Event.RE_LOGIN = "re_login"

function meta:onRegister()

end

function meta:listNotificationInterests()
	return {
		Event.EVENT_START_APP,
		Event.RE_LOGIN
	}
end

function meta:handleNotification(notification)
	if notification.name == Event.EVENT_START_APP then
		print("=============mvc startup============")
	elseif notification.name ==  Event.RE_LOGIN then
		meta:onRecieveLoginFunc(notification.body.notice.data)
	end
end

-- private action method

function meta:onRecieveLoginFunc(param)
	LoginData.characterId = param.data.characterId
	LoginData.hasRole = param.data.hasRole
	LoginData.userId = param.data.userId
	LoginData.result = param.result
	self.viewComponent:onLoginSuccess()
end

function meta:actionFunction(param)
	-- body
end


return meta
