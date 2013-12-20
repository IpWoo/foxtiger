
require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")
require("gameconfig")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    display.addSpriteFramesWithFile(GAME_TEXTURE_DATA_FILENAME, GAME_TEXTURE_IMAGE_FILENAME)
    self:enterScene("MainScene")
    require "kode.init"     -- framework
	require "app.init"          -- app
	require "app.appfacade"     -- application
	require "app.register"      -- register controllers

	appFacade:startup()     -- startup
end

function MyApp:enterAirBattleScene()
    self:enterScene("AirBattleScene", nil, "fade", 0.6, display.COLOR_WHITE)
end

return MyApp
