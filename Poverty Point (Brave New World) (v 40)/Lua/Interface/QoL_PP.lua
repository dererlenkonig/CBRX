include("IconSupport")

local activePlayerID = Game.GetActivePlayer()
local activePlayer	 = Players[activePlayerID]

local iCiv = GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD;

local pCount1 = GameInfoTypes.POLICY_POVERTY_COUNT_1;
local pCount2 = GameInfoTypes.POLICY_POVERTY_COUNT_2;
local pCount3 = GameInfoTypes.POLICY_POVERTY_COUNT_3;
local pCount4 = GameInfoTypes.POLICY_POVERTY_COUNT_4;
local pCount5 = GameInfoTypes.POLICY_POVERTY_COUNT_5;
local pCount6 = GameInfoTypes.POLICY_POVERTY_COUNT_6;
local pCount7 = GameInfoTypes.POLICY_POVERTY_COUNT_7;
local pCount8 = GameInfoTypes.POLICY_POVERTY_COUNT_8;
local pCount9 = GameInfoTypes.POLICY_POVERTY_COUNT_9;

function JFD_ActivePlayerTurnStart()

	if (activePlayer:GetCivilizationType() ~= iCiv) then return end	
	if not (activePlayer:IsHuman()) then return end	

	IconHookup(4, 80, "POVERTY_POINT_ATLAS", Controls.IconImage) 
	Controls.IconFrame:SetHide(true)

	local UITitle = ""
	local UIList = ""
	local UIPre = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_TOOLTIP_PRE");
	local UIBar = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_TOOLTIP_BAR");
		
	if activePlayer:HasPolicy(pCount1) then
		UITitle = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_TITLE_1");
		UIList = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_BODY_1");
	elseif activePlayer:HasPolicy(pCount2) then
		UITitle = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_TITLE_2");
		UIList = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_BODY_2");
	elseif activePlayer:HasPolicy(pCount3) then
		UITitle = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_TITLE_3");
		UIList = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_BODY_3");
	elseif activePlayer:HasPolicy(pCount4) then
		UITitle = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_TITLE_4");
		UIList = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_BODY_4");
	elseif activePlayer:HasPolicy(pCount5) then
		UITitle = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_TITLE_5");
		UIList = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_BODY_5");
	elseif activePlayer:HasPolicy(pCount6) then
		UITitle = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_TITLE_6");
		UIList = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_BODY_6");
	elseif activePlayer:HasPolicy(pCount7) then
		UITitle = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_TITLE_7");
		UIList = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_BODY_7");
	elseif activePlayer:HasPolicy(pCount8) then
		UITitle = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_TITLE_8");
		UIList = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_BODY_8");
	elseif activePlayer:HasPolicy(pCount9) then
		UITitle = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_TITLE_9");
		UIList = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_BODY_9");
	else
		UITitle = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_TITLE_10");
		UIList = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_BODY_10");
	end

	text = UIPre .. UITitle .. UIBar .. UIList .. "[ENDCOLOR]"

	Controls.IconImage:LocalizeAndSetToolTip(text, activePlayer:GetName(), activePlayer:GetCivilizationShortDescription())
	Controls.IconFrame:SetHide(false)

end
Events.ActivePlayerTurnStart.Add(JFD_ActivePlayerTurnStart)

--City Screen stuff
function JFD_OnEnterCityScreen()
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventEnterCityScreen.Add(JFD_OnEnterCityScreen)

function JFD_OnExitCityScreen()
	JFD_ActivePlayerTurnStart()
end
Events.SerialEventExitCityScreen.Add(JFD_OnExitCityScreen)