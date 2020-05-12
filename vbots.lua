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
CLASS_DRUID   = "driod"  -- 11 => '德鲁伊');

-- cmd
CMD_PARTYBOT_CLONE = ".partybot clone";
CMD_PARTYBOT_REMOVE = ".partybot remove";
CMD_PARTYBOT_ADD = ".partybot add ";
CMD_PARTYBOT_SETROLE = ".partybot setrole ";
CMD_BATTLEGROUND_GO = ".go ";
CMD_BATTLEBOT_ADD = ".battlebot add ";

function SubPartyBotClone(self)
	SendChatMessage(CMD_PARTYBOT_CLONE);
end

function SubPartyBotRemove(self)
	SendChatMessage(CMD_PARTYBOT_REMOVE);
end

function SubPartyBotAdd(self, arg)
	SendChatMessage(CMD_PARTYBOT_ADD .. arg);
end

function SubPartyBot2(self)
	SendChatMessage(CMD_PARTYBOT_ADD .. self..text);
end

function CloseFrame()
	vbotsFrame:Hide();
end

function OpenFrame()

	DEFAULT_CHAT_FRAME:AddMessage("Loading vmangos bot ui...");
	DEFAULT_CHAT_FRAME:RegisterEvent('CHAT_MSG_SYSTEM')
	vbotsFrame:Show();
end

