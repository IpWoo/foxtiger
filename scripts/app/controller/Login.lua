if kode == nil then return end

local Event = require "app.config.events"

local LoginController = BaseController:extend{
	name = "LoginController2013-03-13";
}
local meta = LoginController

function meta:onRegister()
	-- body
end

function meta:listNotificationInterests()
	return {
		--Event.EVENT_ACTION_NAME,
		Event.EVENT_START_APP
	}
end

function meta:handleNotification(notification)
	if notification.name == Event.EVENT_ACTION_NAME then
		print("nothing")
	elseif notification.name == Event.EVENT_START_APP then
		print("=============mvc startup============")
	end
end

-- private action method

function meta:actionFunction(param)
	-- body
end

return meta
