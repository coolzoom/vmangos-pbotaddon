-- Create Date : 2020/5/12 10:00:00

-- battleground
BG_ARATHI					= "arathi";
BG_ALTERAC					= "alterac";
BG_WARSONG					= "warsong";
-- team
TEAM_HORDE					= "horde";
TEAM_ALLIANCE				= "alliance";

-- role
ROLE_HEALER					= "healer";
ROLE_DPS					= "dps";
ROLE_TANK					= "tank";

-- class
CLASS_WARRIOR = "warrior";	-- 1 => '战士',
CLASS_PALADIN = "paladin";	-- 2 => '圣骑士',
CLASS_HUNTER  = "hunter";	-- 3 => '猎人',
CLASS_ROUGE   = "rouge";	-- 4 => '潜行者',
CLASS_PRIEST  = "priest";	-- 5 => '牧师',
CLASS_SHAMAN  = "shaman";	-- 7 => '萨满',
CLASS_MAGE    = "mage";		-- 8 => '法师',
CLASS_WARLOCK = "warlock";	-- 9 => '术士',
CLASS_DRUID   = "druid";	-- 11 => '德鲁伊';

-- cmd
CMD_PARTYBOT_CLONE = ".partybot clone";
CMD_PARTYBOT_REMOVE = ".partybot remove";
CMD_PARTYBOT_ADD = ".partybot add ";
CMD_PARTYBOT_SETROLE = ".partybot setrole ";
CMD_BATTLEGROUND_GO = ".go ";
CMD_BATTLEBOT_ADD = ".battlebot add ";

CMD_PARTYBOT_GEAR = ".character premade gear ";
CMD_PARTYBOT_SPEC = ".character premade spec ";

CMD_LEVEL_DOWN = ".level ";

-- combat cmd
CMD_PARTYBOT_ATTACK = ".partybot attackstart";
CMD_COMBATSTOP = ".combatstop ";
CMD_PARTYBOT_COMETOME = ".partybot cometome";

CMD_PARTYBOT_PAUSE = ".partybot pause all 3600000";
CMD_PARTYBOT_UNPAUSE = ".partybot unpause all";

CMD_RESPAWN = ".respawn";
CMD_REVIVE = ".revive ";
CMD_REPLENISH = ".replenish ";

CMD_INSTANTKILL = ".damage 10000000";
CMD_GM_ISLE = ".go xyz 16223.1 16268.1 13.1 1";

-- command frame
function SubPartyBotClone(self)
	if (UnitName("playertarget") ~= nil) then
		SendChatMessage(CMD_PARTYBOT_CLONE);
	end
end

function SubPartyBotRemove(self)
	SendChatMessage(CMD_PARTYBOT_REMOVE);
end

function SubPartyBotSetRole(self, arg)
	SendChatMessage(CMD_PARTYBOT_SETROLE .. arg);
end

function SubPartyBotAdd(self, arg)
	SendChatMessage(CMD_PARTYBOT_ADD .. arg);
	DEFAULT_CHAT_FRAME:AddMessage("机器人已添加，可调整装备、天赋和职能。");
	-- SendChatMessage(CMD_PARTYBOT_GEAR);
	-- SendChatMessage(CMD_PARTYBOT_SPEC);
end

function SubBattleBotAdd(self, arg1, arg2, arg3)
	SendChatMessage(CMD_BATTLEBOT_ADD .. arg1 .. " " .. arg2 .. " " .. arg3);
end

function SubBattleGo(self, arg)
	SendChatMessage(CMD_BATTLEGROUND_GO .. arg);
end

function CloseFrame()
	vbotsFrame:Hide();
end

function CloseCombatFrame()
	vbotsCombatFrame:Hide();
end

function OpenFrame()
	DEFAULT_CHAT_FRAME:AddMessage("正在加载vmangos机器人UI...");
	DEFAULT_CHAT_FRAME:RegisterEvent('CHAT_MSG_SYSTEM');
	vbotsFrame:Show();
	vbotsCombatFrame:Show();
end

function SubSendGuildMessage(self, arg)
	SendChatMessage(arg);
end

-- minimap button
local vbotsFrameShown = false; -- hide frame by default
local vbotsCombatFrameShown = false; -- hide frame by default
local vbotsButtonPosition = 258;

function vbotsButtonFrame_OnClick()
	vbotsButtonFrame_Toggle();
end

function vbotsCombatFrame_OnClick()
	vbotsCombatFrame:Hide();
end

function vbotsButtonFrame_Init()
    -- show frame by default
	if(vbotsFrameShown) then
		vbotsFrame:Show();
		vbotsCombatFrame:Show();
	else
		vbotsFrame:Hide();
		vbotsCombatFrame:Hide();
	end
end

function vbotsButtonFrame_Toggle()
	if(vbotsFrame:IsVisible() and vbotsCombatFrame:IsVisible()) then
		vbotsFrame:Hide();
		vbotsCombatFrame:Hide();
		vbotsFrameShown = false;
		vbotsCombatFrameShown = false;
	else	
		vbotsFrame:Show();
		vbotsCombatFrame:Show();
		vbotsFrameShown = true;
		vbotsCombatFrameShown = true;
	end
	vbotsButtonFrame_Init();
end

function vbotsButtonFrame_OnEnter()
    GameTooltip:SetOwner(this, "ANCHOR_LEFT");
    GameTooltip:SetText("vmangos机器人控制面板\n");
	GameTooltip:AddLine("左键：显示/隐藏控制面板\n右键：移动设置按钮");
	GameTooltipTextLeft3:SetTextColor(1, 1, 1);
    GameTooltip:Show();
end

function vbotsButtonFrame_UpdatePosition()
	vbotsButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (78 * cos(vbotsButtonPosition)),
		(78 * sin(vbotsButtonPosition)) - 55
	);
	vbotsButtonFrame_Init();
end

-- Thanks to Yatlas for this code
function vbotsButtonFrame_BeingDragged()
    -- Thanks to Gello for this code
    local xpos,ypos = GetCursorPosition() 
    local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom() 

    xpos = xmin-xpos/UIParent:GetScale()+70 
    ypos = ypos/UIParent:GetScale()-ymin-70 

    vbotsButtonFrame_SetPosition(math.deg(math.atan2(ypos,xpos)));
end

function vbotsButtonFrame_SetPosition(v)
    if(v < 0) then
        v = v + 360;
    end

    vbotsButtonPosition = v;
    vbotsButtonFrame_UpdatePosition();
end

-- COMBAT CMD
function AllPartyBotAttack(self)
	SendChatMessage(CMD_PARTYBOT_ATTACK);
end

function AllPartyBotCombatStop(self)
	if (UnitInRaid("player")) then
		for i = 1, 40, 1 do
			if (UnitExists("raid" .. i) and not UnitIsUnit("raid" .. i, "player")) then
				SendChatMessage(CMD_COMBATSTOP .. UnitName("raid" .. i));
			end
		end
		SendChatMessage(CMD_PARTYBOT_COMETOME);

	elseif (UnitExists("party1")) then
		for i = 1, 4, 1 do
			if (UnitExists("party" .. i)) then
				SendChatMessage(CMD_COMBATSTOP .. UnitName("party" .. i));
			end
		end
		SendChatMessage(CMD_PARTYBOT_COMETOME);
	end
	SendChatMessage(CMD_COMBATSTOP .. UnitName("player"));
	ClearTarget();
end

function AllPartyBotPause(self)
	SendChatMessage(CMD_PARTYBOT_PAUSE);
end

function AllPartyBotUnPause(self)
	SendChatMessage(CMD_PARTYBOT_UNPAUSE);
end

function RespawnNPC(self)
	SendChatMessage(CMD_RESPAWN);
end

function MassResurrection(self)
	if (UnitIsDeadOrGhost("player")) then
		SendChatMessage(CMD_REVIVE .. UnitName("player"), "GUILD");
	end
	SendChatMessage(CMD_REPLENISH .. UnitName("player"), "GUILD");
	if (UnitInRaid("player")) then
		for i = 1, 40, 1 do
			if (UnitExists("raid" .. i)) then
				if (UnitIsDeadOrGhost("raid" .. i) and not UnitIsUnit("raid" .. i, "player")) then
					SendChatMessage(CMD_REVIVE .. UnitName("raid" .. i), "GUILD");
				end
				SendChatMessage(CMD_REPLENISH .. UnitName("raid" .. i), "GUILD");
			end
		end

	elseif (UnitExists("party1")) then
		for i = 1, 4, 1 do
			if (UnitExists("party" .. i)) then
				if (UnitIsDeadOrGhost("party" .. i)) then
					SendChatMessage(CMD_REVIVE .. UnitName("party" .. i), "GUILD");
				end
				SendChatMessage(CMD_REPLENISH .. UnitName("party" .. i), "GUILD");
			end
		end
	end
end

function InstantKill(self)
	SendChatMessage(CMD_INSTANTKILL);
	SendChatMessage(CMD_COMBATSTOP .. UnitName("player"));
end

function GMIsle(self)
	SendChatMessage(CMD_GM_ISLE);
end

-- PREMADE GEAR
function SubPreMadeGearSearch(self)
	SendChatMessage(CMD_PARTYBOT_GEAR);
end

function SubPreMadeGearSet(self, arg)
	if (not UnitIsUnit("playertarget", "player") and (UnitName("playertarget") ~= nil)) then
		SendChatMessage(CMD_PARTYBOT_GEAR .. arg);
	end
end

-- PREMADE SPEC
function SubPreMadeSPECSearch(self)
	SendChatMessage(CMD_PARTYBOT_SPEC);
end
function SubPreMadeSPECSet(self, arg)
	if (not UnitIsUnit("playertarget", "player") and (UnitName("playertarget") ~= nil)) then
		SendChatMessage(CMD_PARTYBOT_SPEC .. arg);
	end
end

-- LEVEL DOWN
function SubLevelDown(self, arg)
	SendChatMessage(CMD_LEVEL_DOWN .. arg);
end