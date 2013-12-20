--
-- Author: 吴晔
-- Date: 2013-12-20 11:07:38
--
local AirBattleScene = class("AirBattleScene", function()
    return display.newScene("AirBattleScene")
end)
local CellNodeArr = {}
function AirBattleScene:ctor()
	--local teno = require("app.view.airBattle.CellNode").new()
	--self:addChild(teno)
	self:initGrid()
end

function AirBattleScene:initGrid()
	for i=1,10 do
		for j=1,10 do
			local cellNode = require("app.view.airBattle.CellNode").new()
			cellNode.row = i
			cellNode.col = j
			cellNode:setPosition(CCPoint(cellNode.row*50,cellNode.col*50))
			self:addChild(cellNode)
		end
	end
end

function AirBattleScene:onEnter()
    --self.levelsList:setTouchEnabled(true)
end

return AirBattleScene
