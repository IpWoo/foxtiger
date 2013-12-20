--
-- Author: 吴晔
-- Date: 2013-12-20 14:35:22
--
local CellNode = class("CellNode",function()
	return display.newNode()
end)

local _spriteNormalFrame = display.newSpriteFrame("animationbuttonnormal.png")
local _spritePressedFrame = display.newSpriteFrame("animationbuttonpressed.png")

function CellNode:ctor()
	local _sprite = display.newSprite("animationbuttonnormal.png")
	_sprite:setTouchEnabled(true)
	_sprite:addTouchEventListener(function(event,x,y)
		local touchInSprite = _sprite:getCascadeBoundingBox():containsPoint(CCPoint(x, y))
		if event == "began" then
			_sprite:setDisplayFrame(_spritePressedFrame)
		elseif event == "ended" then
			if touchInSprite then
				print("{"..self.row..","..self.col.."}")
			end
			_sprite:setDisplayFrame(_spriteNormalFrame)
		end
		return cc.TOUCH_BEGAN_NO_SWALLOWS
	end)
	self:addChild(_sprite)
end

return CellNode
