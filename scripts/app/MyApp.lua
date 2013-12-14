
require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    self:enterScene("MainScene")
    require "kode.init"     -- framework
	require "app.init"          -- app
	require "app.appfacade"     -- application
	require "app.register"      -- register controllers

	appFacade:startup()     -- startup
end

return MyApp
