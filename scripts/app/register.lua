if kode == nil then return end

local controllers = {
	{--[[ctrl=require "app.controller.Login"; view=require "app.view.Login.Loginpane"--]]};
	{ctrl=require "app.controller.Login"; view=require "app.scenes.MainScene"};
	{nil};
}

for i,v in ipairs(controllers) do
	if v and v.ctrl and v.view then
		appFacade:register(v.ctrl, v.view)
	end
	-- appFacade:RemoveController(v.ctrl.name)
end
