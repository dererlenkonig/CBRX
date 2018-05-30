-------------------------------------------------
-- Great Person Popup (copied from Leugi's Muisca mod)
-------------------------------------------------

include( "IconSupport" );
local m_PopupInfo = nil;

-------------------------------------------------
-------------------------------------------------
function OnPopup( popupInfo )
	if( popupInfo.Type ~= ButtonPopupTypes.BUTTONPOPUP_GREAT_PERSON_REWARD ) then
		return;
	end

	m_PopupInfo = popupInfo;

    iUnitType = popupInfo.Data1;
    pGreatPersonInfo = GameInfo.Units[iUnitType];
    pGreatPersonInfoID = GameInfo.Units[iUnitType].ID;

	prophet = false   
	special = true

-- Changed for Great Prophet overrides
-------------------------------------------	
	local iProphetID = GameInfo.Units.UNIT_PROPHET.ID
	local iProphetClass = GameInfo.UnitClasses.UNITCLASS_PROPHET.ID

	if pGreatPersonInfoID == iProphetID then
		local CivType = Game.GetActiveCivilizationType()
		for row in GameInfo.Civilization_UnitClassOverrides() do
			iCiv = GameInfo.Civilizations[row.CivilizationType].ID
			if iCiv == CivType then
				iClass = GameInfo.UnitClasses[row.UnitClassType].ID
				if iClass == iProphetClass then
					print ("The civilization overrides a prophet!")
					pGreatPersonInfo = GameInfo.Units[row.UnitType]
					iUnitType = GameInfo.Units[row.UnitType].ID
					pGreatPersonInfoID = iUnitType;
					print (pGreatPersonInfo)
					prophet = true
				end
			end
		end
	end

-- Changed for Great Prophet overrides /end
-------------------------------------------
-- Changed so normal units won't show the popup

	for u_row in GameInfo.Units() do
		iSpecial = u_row.Special
		rowUnit = GameInfo.Units[u_row.Type]
		if pGreatPersonInfo == rowUnit then
			if iSpecial == nil then
				special = false
				--print ("Not Special Unit")
				OnCloseButtonClicked();
           			return true;
			end
		end
	end

----------------------------------------------

    local iPlayer = Game.GetActivePlayer();
    local iCityID = popupInfo.Data2;
    local pCity = Players[iPlayer]:GetCityByID(iCityID);
	
	Controls.DescriptionLabel:SetText(Locale.ConvertTextKey("TXT_KEY_GREAT_PERSON_REWARD", pGreatPersonInfo.Description, pCity:GetNameKey()));
	
	local portraitOffset, portraitAtlas = UI.GetUnitPortraitIcon(iUnitType, iPlayer);
	if IconHookup( portraitOffset, 256, portraitAtlas, Controls.Portrait ) then
		Controls.Portrait:SetHide( false );
	else
		Controls.Portrait:SetHide( true );
	end

	UIManager:QueuePopup( ContextPtr, PopupPriority.GreatPersonReward );

-- Changed so normal units won't show the popup /end

-----------------------------------------------
-- The following was added so the notification would also change

	function ChangeNotification(Id, type, toolTip, strSummary, iGameValue, iExtraGameData)
		local iPlayer = Game.GetActivePlayer();
		local pPlayer = Players[iPlayer]
		if type == NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER then
			if prophet == true then
				Events.NotificationRemoved(Id)
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER, Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER"), Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_SUMMARY_GREAT_PERSON"), pCity:GetX(), pCity:GetY(), pGreatPersonInfoID, pGreatPersonInfoID)
			elseif special == false then
				Events.NotificationRemoved(Id)
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER, ("A new unit was created on your empire!"), ("New Unit!"), pCity:GetX(), pCity:GetY(), pGreatPersonInfoID, pGreatPersonInfoID)
			end
		end
		Events.NotificationAdded.Remove( ChangeNotification )
	end
Events.NotificationAdded.Add( ChangeNotification )
-----
end
Events.SerialEventGameMessagePopup.Add( OnPopup );
-----------------------------------------------
function OnCloseButtonClicked ()
	Controls.Portrait:UnloadTexture();
    UIManager:DequeuePopup( ContextPtr );
end
Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnCloseButtonClicked );
-----------------------------------------------
function InputHandler( uiMsg, wParam, lParam )
    if uiMsg == KeyEvents.KeyDown then
        if wParam == Keys.VK_ESCAPE or wParam == Keys.VK_RETURN then
            OnCloseButtonClicked();
            return true;
        end
    end
end
ContextPtr:SetInputHandler( InputHandler );
-----------------------------------------------
function ShowHideHandler( bIsHide, bInitState )

    if( not bInitState ) then
        if( not bIsHide ) then
        	UI.incTurnTimerSemaphore();
        	Events.SerialEventGameMessagePopupShown(m_PopupInfo);
        else
            UI.decTurnTimerSemaphore();
            Events.SerialEventGameMessagePopupProcessed.CallImmediate(ButtonPopupTypes.BUTTONPOPUP_GREAT_PERSON_REWARD, 0);
        end
    end
end
ContextPtr:SetShowHideHandler( ShowHideHandler );
----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
Events.GameplaySetActivePlayer.Add(OnCloseButtonClicked);