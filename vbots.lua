-- Create Date : 2020/5/12 10:00:00

-- battleground
BG_ARATHI					= "arathi";
BG_ALTERAC					= "alterac";
BG_WARSONG					= "warsong";
-- team
TEAM_HORDE					= "horde";
TEAM_ALLIANCE				= "alliance";

-- role
ROLE_HEALER					= "healer"
ROLE_DPS					= "dps"
ROLE_TANK					= "tank"

-- class

CLASS_WARRIOR = "warrior"  -- 1 => '战士',
CLASS_PALADIN = "paladin"  -- 2 => '圣骑士',
CLASS_HUNTER  = "hunter"   -- 3 => '猎人',
CLASS_ROUGE   = "rouge"  -- 4 => '潜行者',
CLASS_PRIEST  = "priest"  -- 5 => '牧师',
CLASS_SHAMAN  = "shaman" -- 7 => '萨满',
CLASS_MAGE    = "mage"  -- 8 => '法师',
CLASS_WARLOCK = "warlock"  -- 9 => '术士',
CLASS_DRUID   = "druid"  -- 11 => '德鲁伊');

-- cmd
CMD_PARTYBOT_CLONE = ".partybot clone";
CMD_PARTYBOT_REMOVE = ".partybot remove";
CMD_PARTYBOT_ADD = ".partybot add ";
CMD_PARTYBOT_SETROLE = ".partybot setrole ";
CMD_BATTLEGROUND_GO = ".go ";
CMD_BATTLEBOT_ADD = ".battlebot add ";

CMD_PARTYBOT_GEAR = ".character premade gear ";
CMD_PARTYBOT_SPEC = ".character premade spec ";

function SubPartyBotClone(self)
	SendChatMessage(CMD_PARTYBOT_CLONE);
end

function SubPartyBotRemove(self)
	SendChatMessage(CMD_PARTYBOT_REMOVE);
end

function SubPartyBotSetRole(self, arg)
	SendChatMessage(CMD_PARTYBOT_SETROLE .. arg);
end

function SubPartyBotAdd(self, arg)
	SendChatMessage(CMD_PARTYBOT_ADD .. arg);
	DEFAULT_CHAT_FRAME:AddMessage("请选中机器人使用 .character premade gear +数字 设置装备 .character premade spec + 数字 设置天赋");
	SendChatMessage(CMD_PARTYBOT_GEAR);
	SendChatMessage(CMD_PARTYBOT_SPEC);
end

function SubBattleBotAdd(self, arg1, arg2)
	SendChatMessage(CMD_BATTLEBOT_ADD .. arg1 .. " " .. arg2);
end

function SubBattleGo(self, arg)
	SendChatMessage(CMD_BATTLEGROUND_GO .. arg);
end

function CloseFrame()
	vbotsFrame:Hide();
end

function OpenFrame()

	DEFAULT_CHAT_FRAME:AddMessage("Loading vmangos bot ui...");
	DEFAULT_CHAT_FRAME:RegisterEvent('CHAT_MSG_SYSTEM')
	vbotsFrame:Show();
end

