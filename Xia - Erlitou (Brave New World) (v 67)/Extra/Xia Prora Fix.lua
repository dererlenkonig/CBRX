print ("Xia Extra")

--
local bXia = GameInfoTypes.BUILDING_XIA_DYNASTY_DUMMY;

local pTemp1 = GameInfoTypes.POLICY_SHANG_BLANK;
local pTemp2 = GameInfoTypes.POLICY_QIN_BLANK;
local pTemp3 = GameInfoTypes.POLICY_SUI_BLANK;
local pTemp4 = GameInfoTypes.POLICY_TANG_BLANK;
local pTemp5 = GameInfoTypes.POLICY_SONG_BLANK;
local pTemp6 = GameInfoTypes.POLICY_YUAN_BLANK;
local pTemp7 = GameInfoTypes.POLICY_MING_BLANK;

local CapShang = Locale.ConvertTextKey("TXT_KEY_TRAIT_DYNASTIC_CYCLE_DYNASTY_CAPITAL_1");
local CapQin = Locale.ConvertTextKey("TXT_KEY_TRAIT_DYNASTIC_CYCLE_DYNASTY_CAPITAL_3");
local CapSui = Locale.ConvertTextKey("TXT_KEY_TRAIT_DYNASTIC_CYCLE_DYNASTY_CAPITAL_5");
local CapTang = Locale.ConvertTextKey("TXT_KEY_TRAIT_DYNASTIC_CYCLE_DYNASTY_CAPITAL_6");
local CapSong = Locale.ConvertTextKey("TXT_KEY_TRAIT_DYNASTIC_CYCLE_DYNASTY_CAPITAL_7");
local CapYuan = Locale.ConvertTextKey("TXT_KEY_TRAIT_DYNASTIC_CYCLE_DYNASTY_CAPITAL_8");
local CapMing = Locale.ConvertTextKey("TXT_KEY_TRAIT_DYNASTIC_CYCLE_DYNASTY_CAPITAL_9");

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];	
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_ERLITOU_MOD"]) then
			for pCity in pPlayer:Cities() do
				if (pCity:IsHasBuilding(bXia)) then	
					if not pPlayer:HasPolicy(pTemp1) then
						if pCity:GetName() == "".. CapShang .."" then
							pPlayer:SetNumFreePolicies(1)
							pPlayer:SetNumFreePolicies(0)
							pPlayer:SetHasPolicy(pTemp1, true);
						end
					end
					if not pPlayer:HasPolicy(pTemp2) then
						if pCity:GetName() == "".. CapQin .."" then			
							pPlayer:SetNumFreePolicies(1)
							pPlayer:SetNumFreePolicies(0)
							pPlayer:SetHasPolicy(pTemp2, true);
						end	
					end
					if not pPlayer:HasPolicy(pTemp3) then		
						if pCity:GetName() == "".. CapSui .."" then				
							pPlayer:SetNumFreePolicies(1)
							pPlayer:SetNumFreePolicies(0)
							pPlayer:SetHasPolicy(pTemp3, true);
						end		
					end
					if not pPlayer:HasPolicy(pTemp4) then		
						if pCity:GetName() == "".. CapTang .."" then				
							pPlayer:SetNumFreePolicies(1)
							pPlayer:SetNumFreePolicies(0)
							pPlayer:SetHasPolicy(pTemp4, true);
						end	
					end
					if not pPlayer:HasPolicy(pTemp5) then			
						if pCity:GetName() == "".. CapSong .."" then					
							pPlayer:SetNumFreePolicies(1)
							pPlayer:SetNumFreePolicies(0)
							pPlayer:SetHasPolicy(pTemp5, true);
						end
					end		
					if not pPlayer:HasPolicy(pTemp6) then		
						if pCity:GetName() == "".. CapYuan .."" then			
							pPlayer:SetNumFreePolicies(1)
							pPlayer:SetNumFreePolicies(0)
							pPlayer:SetHasPolicy(pTemp6, true);
						end	
					end
					if not pPlayer:HasPolicy(pTemp7) then			
						if pCity:GetName() == "".. CapMing .."" then						
							pPlayer:SetNumFreePolicies(1)
							pPlayer:SetNumFreePolicies(0)
							pPlayer:SetHasPolicy(pTemp7, true);
						end
					end
				end
			end
		end
	end
end)
		
for pPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
	local pPlayer = Players[pPlayer];
	if pPlayer:IsEverAlive() then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_ERLITOU_MOD) and pPlayer:IsHuman() then
			local tquery = {"UPDATE Language_en_US SET Text = 'Requires Autocracy. In addition to the +2 [ICON_HAPPINESS_1] Happiness, the Prora Resort also provides +1 more [ICON_HAPPINESS_1] Happiness for every 2 Policies you have adopted. (If playing as Xia, each Dynasty progressed will also count towards your total Policy count). 1 Free Social Policy. Must be constructed in a coastal city.' WHERE Tag = 'TXT_KEY_WONDER_PRORA_RESORT_HELP'"}
			for i, iQuery in pairs(tquery) do
				for result in DB.Query(iQuery) do
				end
			end
			Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type )
		end
	end
end			
					


