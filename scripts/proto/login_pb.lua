--
-- Author: 吴晔
-- Date: 2013-12-18 11:30:29
--
module(...,package.seeall)


local msg_id_index = {}
msg_id_index[101] = {dealers = {},name = "login_s2c"}
msg_id_index[104] = {dealers = {},name = "test"}

regist = function(msgID,fun,key)
	if msg_id_index[msgID].dealers == nil then
		msg_id_index[msgID].dealers = {}
	end
	if key == nil then
		key = "none"
	end
	msg_id_index[msgID].dealers[key] = fun
end

deal = function(msg)
	local msgID = msg.msgID
	local dealsum = 0
	for i,fun in pairs(msg_id_index[msgID].dealers) do
		dealsum = dealsum + 1
		fun(msg)
	end
	if dealsum == 0 then
		echoError("没有注册处理消息的方法，消息无法被处理："..table.tostring(msg))
	end
end