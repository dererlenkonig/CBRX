--dunno if can be local
g_SaveData = Modding.OpenSaveData();
local g_Properties = {};
local h_Properties = {};
-------------------------------------------------------------- 
-- Access the modding database entries through a locally cached table
function GetPersistentProperty(name)
	if not g_Properties[name] then
		if not h_Properties[name] then
			h_Properties[name] = 1;
			g_Properties[name] = g_SaveData.GetValue(name);
		end
	end
	return g_Properties[name];
end
--------------------------------------------------------------
-- Access the modding database entries through a locally cached table
function SetPersistentProperty(name, value)
	if (g_Properties[name] ~= value) then
		g_SaveData.SetValue(name, value);
		g_Properties[name] = value;
	end
end