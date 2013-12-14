if kode == nil then return end

local Event = require "app.config.events"

local LoginModel = BaseModel:extend{
	-- member
}
local meta = LoginModel

-- events
Event.EVENT_MODULE_ACTION_NAME = "EVENT_MODULE_ACTION_NAME";

function meta:getData()
	-- body
end
function meta:setData(param)
	-- body
end

return meta
