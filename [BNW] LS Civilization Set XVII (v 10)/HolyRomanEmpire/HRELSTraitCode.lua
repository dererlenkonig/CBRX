print ("Legacy Grabbers - HRE UA code ")

-- The Code related to Leaderscene placing is based/copied from:
-- VVLeaderHeadImageOverride
-- Author: Vicevirtuoso/bc1
-- DateCreated: 3/23/2015 3:24:03 PM
-- Check it out!
--------------------------------------------------------------
include( "IconSupport" );
include( "InstanceManager" );
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "LS17HRE";
local ValidPlayerTable = {};
local eAncient = GameInfoTypes.ERA_ANCIENT;
local eClassical = GameInfoTypes.ERA_CLASSICAL;
local eMedieval = GameInfoTypes.ERA_MEDIEVAL;
local eRenaissance = GameInfoTypes.ERA_RENAISSANCE;
local repTable = {}
local ValidUnitTable = {[eMedieval] = {GameInfoTypes.UNIT_LS_HRE_LONGS, GameInfoTypes.UNIT_LS_HRE_KNIGHT, GameInfoTypes.UNIT_LS_HRE_LANDSKNECHT}, [eRenaissance] = {GameInfoTypes.UNIT_LS_HRE_REITER}}
local FirstInit = {}
local alreadyUsed = {}
local iTsx = {}
local tempOptions;
local globalChoose;
local relDummy = GameInfoTypes.BUILDING_DUMMY_LS_HRE_REL_HAP;
local LastEraT = {}
local PlayerFakeDiplo = {}
local CurrentYieldTrait = {}
local CurrentTraitID = {}
local CurrentRelTrait = {}
local tempGlobalData;
local ValidLeaders = {
{ID = 1, Leader = GameInfoTypes.LEADER_ASKIA, Diplo = "Askia.dds"},
{ID = 2, Leader = GameInfoTypes.LEADER_RAMESSES, Diplo = "Ramesses.dds"},
{ID = 3, Leader = GameInfoTypes.LEADER_NAPOLEON, Diplo = "Napoleon.dds"},
{ID = 4, Leader = GameInfoTypes.LEADER_AUGUSTUS, Diplo = "Augustus.dds"},
{ID = 5, Leader = GameInfoTypes.LEADER_DARIUS, Diplo = "Darius.dds"},
{ID = 6, Leader = GameInfoTypes.LEADER_MONTEZUMA, Diplo = "Montezuma.dds"},
{ID = 7, Leader = GameInfoTypes.LEADER_ALEXANDER, Diplo = "Alexander.dds"},
{ID = 8, Leader = GameInfoTypes.LEADER_GENGHIS_KHAN, Diplo = "Genghis.dds"},
{ID = 9, Leader = GameInfoTypes.LEADER_CATHERINE, Diplo = "Catherine.dds"},
{ID = 10, Leader = GameInfoTypes.LEADER_BISMARCK, Diplo = "Bismark.dds"},
{ID = 11, Leader = GameInfoTypes.LEADER_HARUN_AL_RASHID, Diplo = "AlRashid.dds"},
{ID = 12, Leader = GameInfoTypes.LEADER_WASHINGTON, Diplo = "Washington.dds"},
{ID = 13, Leader = GameInfoTypes.LEADER_ODA_NOBUNAGA, Diplo = "Oda.dds"},
{ID = 14, Leader = GameInfoTypes.LEADER_ELIZABETH, Diplo = "Elizabeth.dds"},
{ID = 15, Leader = GameInfoTypes.LEADER_RAMKHAMHAENG, Diplo = "Ramkhamaeng.dds"},
{ID = 16, Leader = GameInfoTypes.LEADER_HIAWATHA, Diplo = "Hiawatha.dds"},
{ID = 17, Leader = GameInfoTypes.LEADER_SULEIMAN, Diplo = "Sulieman.dds"},
{ID = 18, Leader = GameInfoTypes.LEADER_GANDHI, Diplo = "Ghandi.dds"},
{ID = 19, Leader = GameInfoTypes.LEADER_WU_ZETIAN, Diplo = "Wu.dds"},
{ID = 20, Leader = GameInfoTypes.LEADER_ISABELLA, Diplo = "Isabella.dds"},
{ID = 21, Leader = GameInfoTypes.LEADER_PACAL, Diplo = "Pacal_the_Great.dds"},
{ID = 22, Leader = GameInfoTypes.LEADER_WILLIAM, Diplo = "William_of_Orange.dds"},
{ID = 23, Leader = GameInfoTypes.LEADER_GUSTAVUS_ADOLPHUS, Diplo = "Gustavus Adolphus.dds"},
{ID = 24, Leader = GameInfoTypes.LEADER_ATTILA, Diplo = "Attila.dds"},
{ID = 25, Leader = GameInfoTypes.LEADER_SELASSIE, Diplo = "Haile_Selassie.dds"},
{ID = 26, Leader = GameInfoTypes.LEADER_BOUDICCA, Diplo = "Boudicca.dds"},
{ID = 27, Leader = GameInfoTypes.LEADER_DIDO, Diplo = "Dido.dds"},
{ID = 28, Leader = GameInfoTypes.LEADER_THEODORA, Diplo = "Theodora.dds"},
{ID = 29, Leader = GameInfoTypes.LEADER_MARIA, Diplo = "MariaTheresa.dds"},
{ID = 30, Leader = GameInfoTypes.LEADER_ASHURBANIPAL, Diplo = "Ashurbanipal.dds"},
{ID = 31, Leader = GameInfoTypes.LEADER_GAJAH_MADA, Diplo = "Gajah.dds"},
{ID = 32, Leader = GameInfoTypes.LEADER_AHMAD_ALMANSUR, Diplo = "Almansur.dds"},
{ID = 33, Leader = GameInfoTypes.LEADER_CASIMIR, Diplo = "Casimir.dds"},
{ID = 34, Leader = GameInfoTypes.LEADER_MARIA_I, Diplo = "Maria_I.dds"},
{ID = 35, Leader = GameInfoTypes.LEADER_ENRICO_DANDOLO, Diplo = "Dandolo.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_SHAKA, Diplo = "Shaka.dds"},
--Hoop
{ID = 37, Leader = GameInfoTypes.LEADER_CHILEKINGDOM_HOOP_MOD_MENDOZA, Diplo = "DiploCHILEKINGDOM_HOOPMod.dds"},
{ID = 38, Leader = GameInfoTypes.LEADER_NUEVA_EXTREMADURA_HOOP_MOD_PEDRO_DE_VALDIVIA, Diplo = "DiploNUEVA_EXTREMADURA_HOOPMod.dds"},
{ID = 39, Leader = GameInfoTypes.LEADER_CHILECONSERVATIVE_HOOP_MOD_PORTALES, Diplo = "DiploCHILECONSERVATIVE_HOOPMod.dds"},
{ID = 40, Leader = GameInfoTypes.LEADER_CHILEPACIFIC_HOOP_MOD_BALMACEDA, Diplo = "DiploCHILEPACIFIC_HOOPMod.dds"},
{ID = 41, Leader = GameInfoTypes.LEADER_CHILEWELFARE_HOOP_MOD_ALESSANDRI, Diplo = "DiploCHILEWELFARE_HOOPMod.dds"},
{ID = 42, Leader = GameInfoTypes.LEADER_CHILESOCIALIST_HOOP_MOD_ALLENDE, Diplo = "DiploCHILESOCIALIST_HOOPMod.dds"},
{ID = 43, Leader = GameInfoTypes.LEADER_CHILEDICTATOR_HOOP_MOD_PINOCHET, Diplo = "DiploCHILEDICTATOR_HOOPMod.dds"},
{ID = 44, Leader = GameInfoTypes.LEADER_CHILENOW_HOOP_MOD_BACHELET, Diplo = "DiploCHILENOW_HOOPMod.dds"},
--/Hoop
{ID = 45, Leader = GameInfoTypes.LEADER_ATHENS_LS_PERICLES, Diplo = "DiploAthensLSMod.dds"},
{ID = 46, Leader = GameInfoTypes.LEADER_PRUSSIA_LS_FREDERICK, Diplo = "DiploPrussiaLSMod.dds"},
{ID = 47, Leader = GameInfoTypes.LEADER_LS_KOYAH, Diplo = "DiploHaidaLSMod.dds"},
{ID = 48, Leader = GameInfoTypes.LEADER_UKRAINE_LS_MOD_BOHDAN_KHMELNYTSKY, Diplo = "DiploHetmanLSMod.dds"},
{ID = 49, Leader = GameInfoTypes.LEADER_KHMER_LS_MOD_SURYAVARMAN_II, Diplo = "DiploKhmerLSMod.dds"},
{ID = 50, Leader = GameInfoTypes.LEADER_PAPAL_STATES_LS_MOD_GREGORY_XIII, Diplo = "DiploPapalStatesLSMod.dds"},
{ID = 51, Leader = GameInfoTypes.LEADER_SIOUX_LS_MOD_SITTING_BULL, Diplo = "DiploSiouxLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_KINGDOM_OF_JERUSALEM_LS_MOD_BALDWIN_IV, Diplo = "DiploKoJLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_MALI_LS_MOD_MANSA_MUSA, Diplo = "DiploMaliLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_TIMURIDS_MOD_LS_TIMUR, Diplo = "DiploTimuridLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_NEPAL_LS_MOD_PRITHVI_NARAYAN, Diplo = "DiploNepalLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_DURRANI_LS_MOD_AHMAD_ABDALI, Diplo = "DiploDurraniLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_ASHANTI_LS_MOD_OSEI_TUTU, Diplo = "DiploAshantiLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_QIN_LS_MOD_QIN_SHI_HUANG, Diplo = "DiploQinLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_TAHITI_LS_MOD_PUREA, Diplo = "DiploTahitiLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_GALLIA_LS_MOD_VERCINGETORIX, Diplo = "DiploGalliaLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_SCOTLAND_LS_MOD_JAMES_VI, Diplo = "DiploScotlandLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_ZIMBABWE_LS_MOD_NYATSIMBA_MUTOTA, Diplo = "DiploZimbabweLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_OLMEC_LS_MOD_PO_NGBE, Diplo = "DiploOlmecLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_LITHUANIA_LS_MOD_MINDAUGAS, Diplo = "DiploLithuaniaLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_TATAR_LS_MOD_TOGAY, Diplo = "DiploTatarLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_BULGARIA_LS_MOD_SIMEON_I, Diplo = "DiploBulgariaLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_HITTITE_LS_MOD_MURSILI_II, Diplo = "DiploHittiteLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_NUMIDIA_LS_MOD_MASSINISSA, Diplo = "DiploNumidiaLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_CHEROKEE_LS_MOD_EDOHI, Diplo = "DoMCherokeeLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_ROMANIA_LS_MOD_VLAD_III, Diplo = "DiploRomaniaLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_SCYTHIA_LS_MOD_ATHEAS, Diplo = "DiploScythiaLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_TIBET_LS_MOD_GAMPO, Diplo = "DiploTibetLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_SPARTA_LS_MOD_LEONIDAS, Diplo = "DiploSpartaLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_MUGHAL_LS_MOD_JAHAN, Diplo = "DiploMughalLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_VIETNAM_LS_MOD_LELOI, Diplo = "DiploVietnamLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_ISRAEL_MOD_LS_SOLOMON, Diplo = "DiploIsraelLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_VIKING_LS_MOD_CNUT, Diplo = "DiploVikingLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_HUNGARY_LS_MOD_STEPHEN_HUN, Diplo = "DiploScreenLSHungary.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_GENOA_LS_MOD_SIMONE_B, Diplo = "DiploGenoaLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_MINOAN_LS_MOD_MINOS, Diplo = "DiploMinoanLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_CARIBBEAN_LS_MOD_HENRY_MORGAN, Diplo = "DiploCaribbeanLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_FLANDERS_LS_MOD_ROBERTIII, Diplo = "DiploFlandersLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_GOTHS_LS_MOD_ALARIC, Diplo = "DiploGothsLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_SWISS_LS_MOD_DUFOUR, Diplo = "DiploSwissLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_FRANKS_LS_MOD_CHARLEMAGNE, Diplo = "DiploFranksLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_SUMER_LS_MOD_GILGAMESH, Diplo = "DiploSumerLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_MAURYAN_LS_MOD_ASHOKA, Diplo = "DiploMauryanLSMod.dds"},
{ID = 56, Leader = GameInfoTypes.LEADER_HRE_LS_NO_DG, Diplo = "DLShdge.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_NIIT_LS_MOD_RUNNINGEAGLE, Diplo = "DiploNiitLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_NDONGO_LS_MOD_NJINGA, Diplo = "DiploNdongoLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_MAPUCHE_LS_MOD_JANEQUEO, Diplo = "DiploMapucheLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_AYYUBIDS_LS_MOD_PIYE, Diplo = "DiploSaladinLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_NUBIA_LS_MOD_PIYE, Diplo = "DiploNubiaLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_TEO_LS_MOD_OWL, Diplo = "DiploTeoLSMod.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_FRANCE_MOD_LS_LUDWIK, Diplo = "JanBoruta_LudwikLeaderscene.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_LS_JJ_JAPAN_JIMMU, Diplo = "DiploJapanLSJimmu.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_LS_HJ_JAPAN_KANMU, Diplo = "DiploJapanLSKanmu.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_LS_MJ_JAPAN_MEIJI, Diplo = "DiploJapanLSMeiji.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_LS_AJ_JAPAN_SHOTOKU, Diplo = "DiploJapanLSShotoku.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_LS_ASJ_JAPAN_TAKAUJI, Diplo = "DiploJapanLSTakauji.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_LS_TJ_JAPAN_TOKUGAWA, Diplo = "DiploJapanLSTokugawa.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_LS_IR_RUSSIA_IVAN, Diplo = "DiploRussiaLSIvan.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_LS_PR_RUSSIA_PETER, Diplo = "DiploRussiaLSPeter.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_POLAND_LS_PE_STEPHEN, Diplo = "DiploLSPEStephenBat.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_POLAND_LS_PJ_CASIMIR, Diplo = "DiploLSPECasimir.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_POLAND_LS_PP_CHROBRY, Diplo = "DiploLSPEChrobry.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_POLAND_LS_RKP_JAGIELLO, Diplo = "DiploLSPEJagiello.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_POLAND_LS_PC_SOBIESKI, Diplo = "DiploLSPESobieski.dds"},
{ID = 36, Leader = GameInfoTypes.LEADER_POLAND_LS_PV_ZYGMUNT, Diplo = "DiploLSPEZygmuntIII.dds"},
{ID = 56, Leader = GameInfoTypes.LEADER_HRE_LS_NO_FRANCIS, Diplo = "DiploLSHREfrancis.dds"},
{ID = 56, Leader = GameInfoTypes.LEADER_HRE_LS_NO_BARB, Diplo = "DiploLSHREbarbara.dds"},
{ID = 56, Leader = GameInfoTypes.LEADER_HRE_LS_NO_CHARLES, Diplo = "DiploLSHREcharles.dds"}
}

local TraitYieldM = {
{GameInfoTypes.BUILDING_DUMMY_LS_HRE_PRODUCTION, "+2 [ICON_PRODUCTION] Production in all cities.", "Charismatic ", "+2[ICON_PRODUCTION]"},
{GameInfoTypes.BUILDING_DUMMY_LS_HRE_FAITH, "+2 [ICON_PEACE] Faith in all cities.", "Pious ", "+2[ICON_PEACE]"},
{GameInfoTypes.BUILDING_DUMMY_LS_HRE_CULTURE, "+2 [ICON_CULTURE] Culture in all cities.", "Serene ", "+2[ICON_CULTURE]"},
{GameInfoTypes.BUILDING_DUMMY_LS_HRE_GOLD, "+2 [ICON_GOLD] Gold in all cities.", "Supreme ", "+2[ICON_GOLD]"},
{GameInfoTypes.BUILDING_DUMMY_LS_HRE_SCIENCE, "+2 [ICON_RESEARCH] Science in all cities.", "Enlightened ", "+2[ICON_RESEARCH]"},
{GameInfoTypes.BUILDING_DUMMY_LS_HRE_FOOD, "+2 [ICON_FOOD] Food in all cities.", "Magnanimous ", "+2[ICON_FOOD]"}
}

local bd = GameInfoTypes.LEADER_HRE_LS_NO_DG;
local policybase = GameInfoTypes.POLICY_HRE_DUMMY_1
local PolicyLikeTraitT = {
{GameInfoTypes.POLICY_HRE_DUMMY_2, "Tile improvement construction rate increased by 25%", "Sovereign"},
{GameInfoTypes.POLICY_HRE_DUMMY_3, "+10% [ICON_PRODUCTION] Production in cities when constructing Buildings.", "Baron"},
{GameInfoTypes.POLICY_HRE_DUMMY_4, "+1 [ICON_HAPPINESS] Happiness for every 4 [ICON_CITIZEN] Citizens in a City.", "Prince"},
{GameInfoTypes.POLICY_HRE_DUMMY_5, "+10% [ICON_FOOD] Growth in the [ICON_CAPITAL] Capital.", "Magnate"},
{GameInfoTypes.POLICY_HRE_DUMMY_6, "Pay 25% less for land unit maintenance. +33% Combat Bonus vs Barbarians.", "Lion"},
{GameInfoTypes.POLICY_HRE_DUMMY_7, "Great Generals are earned 50% faster.", "General"},
{GameInfoTypes.POLICY_HRE_DUMMY_8, "Military Units gain 33% more Experience from combat.", "Commander"},
{GameInfoTypes.POLICY_HRE_DUMMY_9, "[ICON_INFLUENCE] Influence with City-States degrade 25% slower than normal.", "Lord"},
{GameInfoTypes.POLICY_HRE_DUMMY_10, "+2 [ICON_GOLD] Gold for trade routes.", "Sultan"},
{GameInfoTypes.POLICY_HRE_DUMMY_11, "Maintenance paid on Roads and Railroads reduced by 50%.", "Rajah", eClassical},
{GameInfoTypes.POLICY_HRE_DUMMY_12, "+10% [ICON_RESEARCH] Science while the empire is Happy.", "Duke", eMedieval},
{GameInfoTypes.POLICY_HRE_DUMMY_13, "[ICON_GOLD] Gold for each enemy unit killed.", "Maharajah"},
{GameInfoTypes.POLICY_HRE_DUMMY_14, "Combat Strength of Cities increased by 33%.", "Protector"},
{GameInfoTypes.POLICY_HRE_DUMMY_15, "+15% [ICON_PRODUCTION] Production when building Wonders.", "Shah"},
{GameInfoTypes.POLICY_HRE_DUMMY_16, "+1 [ICON_PRODUCTION] Production per Pasture.", "Khan"},
{GameInfoTypes.POLICY_HRE_DUMMY_17, "[ICON_CULTURE] Culture for each enemy unit killed.", "Warrior"},
{GameInfoTypes.POLICY_HRE_DUMMY_18, "Great Artists are earned 50% faster.", "Blind Man", eRenaissance},
{GameInfoTypes.POLICY_HRE_DUMMY_19, "Great Writers are earned 50% faster.", "Writer", eRenaissance},
{GameInfoTypes.POLICY_HRE_DUMMY_20, "Great Musicians are earned 50% faster.", "Deaf Man", eRenaissance},
{GameInfoTypes.POLICY_HRE_DUMMY_21, "Great Scientists are earned 50% faster.", "Scientist", eRenaissance},
{GameInfoTypes.POLICY_HRE_DUMMY_22, "+25% [ICON_GREAT_PEOPLE] Great Person generation.", "Absolutist", eRenaissance},
{GameInfoTypes.POLICY_HRE_DUMMY_23, "Spies have double the chance to capture an enemy spy attempting to steal a technology.", "Judge", eRenaissance},
{GameInfoTypes.POLICY_HRE_DUMMY_24, "Spies steal technologies 50% faster.", "Agent", eRenaissance}
}

local TraitCoreT = {
{ID = 1, Text = "+33% [ICON_STRENGTH] Combat Bonus vs Barbarians.", Policy = GameInfoTypes.POLICY_HRE_DUMMY_TRAIT_1},
{ID = 2, Text = "+1 [ICON_PRODUCTION] Production per city.", Building = GameInfoTypes.BUILDING_DUMMY_LS_HRE_TRAIT_2},
{ID = 3, Text = "Free Scout."},
{ID = 4, Text = "+1 [ICON_PEACE] Faith per city.", Building = GameInfoTypes.BUILDING_DUMMY_LS_HRE_TRAIT_4},
{ID = 5, Text = "+20% [ICON_PRODUCTION] Production towards Wonders.", Policy = GameInfoTypes.POLICY_HRE_DUMMY_TRAIT_5},
{ID = 6, Text = "Free Settler."},
{ID = 7, Text = "+33% [ICON_GOLD] Gold from city connections.", Policy = GameInfoTypes.POLICY_HRE_DUMMY_TRAIT_7},
{ID = 8, Text = "Tile improvement construction rate increased by 33%.", Policy = GameInfoTypes.POLICY_HRE_DUMMY_TRAIT_8},
{ID = 9, Text = "Free Great Writer."},
{ID = 10, Text = "+2 [ICON_CULTURE] Culture per city.", Building = GameInfoTypes.BUILDING_DUMMY_LS_HRE_TRAIT_10},
{ID = 11, Text = "+25% [ICON_GREAT_PEOPLE] Great Person generation.", Policy = GameInfoTypes.POLICY_HRE_DUMMY_TRAIT_11},
{ID = 12, Text = "Free Great General."},
{ID = 13, Text = "+2 [ICON_RESEARCH] Science per city.", Building = GameInfoTypes.BUILDING_DUMMY_LS_HRE_TRAIT_13},
{ID = 14, Text = "+1 [ICON_PRODUCTION] Production per strategic resource.", Building = GameInfoTypes.BUILDING_DUMMY_LS_HRE_TRAIT_14},
{ID = 15, Text = "+5 [ICON_RES_COAL] Coal."},
{ID = 16, Text = "Spies steal technologies twice as fast.", Policy = GameInfoTypes.POLICY_HRE_DUMMY_TRAIT_16},
{ID = 17, Text = "[ICON_GOLD] Gold cost of upgrading Military Units reduced by 33%.", Policy = GameInfoTypes.POLICY_HRE_DUMMY_TRAIT_17},
{ID = 18, Text = "Free Technology."},
{ID = 19, Text = "Free Social Policy."},
{ID = 21, Text = "Free Great Engineer."},
{ID = 22, Text = "Free Great Scientist."}
}

local screenX, screenY = UIManager:GetScreenSizeVal()
local contexts = {}
local leaderInstance = InstanceManager:new( "LeaderInstance", "Root", Controls.LeaderStack );
local CivAttachedLeaders = {[GameInfoTypes.LEADER_HRE_LS_NO_FRANCIS] = 1, [GameInfoTypes.LEADER_HRE_LS_NO_BARB] = 1, [GameInfoTypes.LEADER_HRE_LS_NO_CHARLES] = 1, [GameInfoTypes.LEADER_HRE_LS_NO_DG] = 1}
for row in GameInfo.Civilization_Leaders() do
	CivAttachedLeaders[GameInfoTypes[row.LeaderheadType]] = 1;
end
local LeadersInGame = {}
for i,v in pairs(Players) do
	if v:IsEverAlive() then
		LeadersInGame[v:GetLeaderType()] = 1;
	end
end
local PostValidLeaders = {}

function Shuffle(iTable)
	local n, order, oTable = #iTable, {}, {}
	for i=1,n do order[i] = { rnd = math.random(), idx = i } end
	table.sort(order, function(a,b) return a.rnd < b.rnd end)
	for i=1,n do oTable[i] = iTable[order[i].idx] end
	return oTable;
end

function GetDiploTexture(leaderType)
	for i, data in pairs(ValidLeaders) do
		if data.Leader == leaderType then
			return data.Diplo;
		end
	end
	return nil;
end

for row in GameInfo.Civilization_UnitClassOverrides() do
	if row.UnitType then
		if GameInfo.Units[row.UnitType] then
			local prereq = GameInfo.Units[row.UnitType].PrereqTech;
			if prereq then
				if GameInfo.Units[row.UnitType].Cost > 0 then
					local eraKind = GameInfo.Technologies[prereq].Era;
					if eraKind then
						local eraType = GameInfoTypes[eraKind];
						if eraType == eMedieval or eraType == eRenaissance then
							if row.UnitClassType then
								if GameInfo.UnitClasses[row.UnitClassType] then
									local defUnit = GameInfo.UnitClasses[row.UnitClassType].DefaultUnit;
									if defUnit then
										if GameInfo.Units[row.UnitType].Cost == GameInfo.Units[defUnit].Cost then
											table.insert(ValidUnitTable[eraType], GameInfoTypes[row.UnitType])
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function GiveTableOfValidTraitPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = Players[player]:GetTeam();
		local MedRep = load(Players[player], "LS17HRErep" .. eMedieval);
		local RenRep = load(Players[player], "LS17HRErep" .. eRenaissance);
		repTable[player] = {}
		if MedRep then
			repTable[player][GameInfoTypes[GameInfo.Units[MedRep].Class]] = MedRep;
		end
		LastEraT[player] = load(Players[player], "LS17HREle") or -1;
		if RenRep then
			repTable[player][GameInfoTypes[GameInfo.Units[RenRep].Class]] = RenRep;
		end
		local cRleader = load(Players[player], "LS17HRErl");
		if cRleader then
			PlayerFakeDiplo[player] = GetDiploTexture(cRleader)
		else
			Players[player]:SetNumFreePolicies(1);
			Players[player]:SetNumFreePolicies(0);
			Players[player]:SetHasPolicy(policybase, true);
			Players[player]:ChangeScoreFromFutureTech(-4);
			table.insert(FirstInit, player)
		end
		CurrentYieldTrait[player] = load(Players[player], "LS17HREcyb")
		CurrentRelTrait[player] = load(Players[player], "LS17HRErel")
		CurrentTraitID[player] = load(Players[player], "LS17HREctid")
	end
	for i, data in pairs(ValidLeaders) do
		if data.Leader then
			if CivAttachedLeaders[data.Leader] then
				if not LeadersInGame[data.Leader] then
					if not load(Players[63], "LS17HREused" .. data.Leader) then
						table.insert(PostValidLeaders, {data.Leader, data.Diplo})
					end
				end
			end
		end
	end
	PostValidLeaders = Shuffle(PostValidLeaders)
end

function SetUniqueUnit(iPlayer, type, era)
	repTable[iPlayer][GameInfoTypes[GameInfo.Units[type].Class]] = type;
	save(Players[iPlayer], "LS17HRErep" .. era, type);
end

GameEvents.CityTrained.Add(function(ownerId, cityId, unitId, bGold, bFaithOrCulture)
	if repTable[ownerId] then
		local iUnit = Players[ownerId]:GetUnitByID(unitId);
		if repTable[ownerId][iUnit:GetUnitClassType()] then
			local jUnit = Players[ownerId]:InitUnit(repTable[ownerId][iUnit:GetUnitClassType()], iUnit:GetX(), iUnit:GetY());
			jUnit:SetLevel(iUnit:GetLevel())
			jUnit:SetExperience(iUnit:GetExperience())
			for row in GameInfo.UnitPromotions() do
				if iUnit:IsHasPromotion(row.ID) then
					if not row.LostWithUpgrade then
						jUnit:SetHasPromotion(row.ID, true)
					end
				end
			end
			jUnit:Convert(iUnit)
		end
	end
end)

GameEvents.UnitUpgraded.Add(function(playerId, unitId, newUnitId)
	if repTable[playerId] then
		local oldUnit = Players[playerId]:GetUnitByID(unitId);
		local iUnit = Players[playerId]:GetUnitByID(newUnitId);
		if repTable[playerId][iUnit:GetUnitClassType()] then
			local jUnit = Players[playerId]:InitUnit(repTable[playerId][iUnit:GetUnitClassType()], iUnit:GetX(), iUnit:GetY());
			jUnit:Convert(iUnit)
			jUnit:SetMoves(0)
			jUnit:SetLevel(oldUnit:GetLevel())
			jUnit:SetExperience(oldUnit:GetExperience())
			for row in GameInfo.UnitPromotions() do
				if oldUnit:IsHasPromotion(row.ID) then
					if not row.LostWithUpgrade then
						jUnit:SetHasPromotion(row.ID, true)
					end
				end
			end
		end
	end 
end)

function SetNewDummyLeader(iPlayer, leaderType)
	PreGame.SetLeaderName(iPlayer, Locale.Lookup(GameInfo.Leaders[leaderType].Description))
	Events.SerialEventScoreDirty()
	PlayerFakeDiplo[iPlayer] = GetDiploTexture(leaderType)
	save(Players[iPlayer], "LS17HRErl", leaderType)
	save(Players[63], "LS17HREused" .. leaderType, 1)
end

Events.SequenceGameInitComplete.Add(function()
	for _, context in pairs{ LookUpControl( "/LeaderHeadRoot" ), LookUpControl( "/LeaderHeadRoot/DiploTrade" ), LookUpControl( "/LeaderHeadRoot/DiscussionDialog" ) } do
		if context then
			local instance = {}
			ContextPtr:BuildInstanceForControlAtIndex( "Instance", instance, context, 0 )
			table.insert( contexts, {context, instance} )
		end
	end
	for it, iPlayer in pairs(FirstInit) do
		PostValidLeaders = Shuffle(PostValidLeaders)
		SetNewDummyLeader(iPlayer, PostValidLeaders[1][1])
		table.remove(PostValidLeaders, 1)
	end
	local iPlayer = Game.GetActivePlayer();
	if load(Players[iPlayer], "LS17HREon") then
		local hTab = {}
		for i = 1, load(Players[iPlayer], "LS17HREon") do
			table.insert(hTab, {load(Players[iPlayer], "LS17HREonl" .. i), load(Players[iPlayer], "LS17HREonu" .. i), load(Players[iPlayer], "LS17HREony" .. i), load(Players[iPlayer], "LS17HREoncs" .. i), load(Players[iPlayer], "LS17HREonpt" .. i), load(Players[iPlayer], "LS17HREonrl" .. i), load(Players[iPlayer], "LS17HREontr" .. i)})
		end
		tempGlobalData = hTab;
		OnPopup()
	end
	local bHuman = false;
	for player, sth in pairs(ValidPlayerTable) do
		if Players[player]:IsHuman() then
			bHuman = true;
		end
	end	
	if bHuman then
		Events.GameplaySetActivePlayer.Add(UpdateIndicatorOnPlayerChange)
		if ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack") then
			Controls.IconBox:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"));
			Controls.IconBox:SetOffsetVal(0,-4)
			Controls.IconBox:SetHide(true)
		end
		if ValidPlayerTable[Game.GetActivePlayer()] then
			UpdateIconInTopPanel();
			Controls.IconBox:SetHide(false)
		end
	end
end)

function UpdateIndicatorOnPlayerChange()
	Controls.IconBox:SetHide(true)
	if ValidPlayerTable[Game.GetActivePlayer()] then
		UpdateIconInTopPanel();
		Controls.IconBox:SetHide(false)
	end
end

Events.AILeaderMessage.Add(function( iPlayer, iDiploUIState, szLeaderMessage, iAnimationAction, iData1 )
	if Game.IsNetworkMultiPlayer() then
		ContextPtr:SetHide(true)
	else
		if ValidPlayerTable[iPlayer] then
			local IsDone = false;
			for _, context in pairs( contexts ) do
				if (not IsDone) or context[1]:IsHidden() then
					if not context[1]:IsHidden() then
						IsDone = true;
					end
--						image = context[2].DiploScene
					context[2].DiploScene:SetTextureAndResize( PlayerFakeDiplo[iPlayer] )
					local x, y = context[2].DiploScene:GetSizeVal()
					x, y = math.min(screenX, screenY*x/y), math.min(screenY, screenX*y/x)
					context[2].DiploScene:SetSizeVal( x, y )
					context[2].DiploScene:SetHide( false )
					context[2].Box:SetHide( false )
				else
					context[2].DiploScene:SetHide( true )
					context[2].Box:SetHide( true )
				end
			end
		else
			for _, context in pairs( contexts ) do
				context[2].Box:SetHide(true)
			end
		end
	end
end)

function GetTableHelp()
	return contexts;
end


GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		if not Players[iPlayer]:IsHuman() then
			if Players[iPlayer]:GetCurrentEra() ~= LastEraT[iPlayer] then
				if Game.GetElapsedGameTurns() > 0 then
					if Players[iPlayer]:GetNumCities() > 0 then
						DoAIChooseNewLeader(iPlayer)
					end
				end
			end
		end
	end
end)

function DoAIChooseNewLeader(iPlayer)
	if #PostValidLeaders > 0 then
		local cEra = Players[iPlayer]:GetCurrentEra()
		local bStartEra = cEra == Game.GetStartEra();
		LastEraT[iPlayer] = cEra;
		save(Players[iPlayer], "LS17HREle", cEra)
		local getData = PrepareOptionsForHumanPlayer(iPlayer)
		if #getData > 0 then
			local luckyID = math.random(1, #getData);
			SetNewDummyLeader(iPlayer, getData[luckyID][1])
			if getData[luckyID][2] then
				SetUniqueUnit(iPlayer, getData[luckyID][2], cEra)
			end
			SetTraitData(iPlayer, getData[luckyID][3], getData[luckyID][4], getData[luckyID][5], getData[luckyID][6], getData[luckyID][7])
		end
	end
end

--Human Choosing new leader

function HumanPlayerChooseAnAbility(iPlayer)
	tempGlobalData = nil;
	local cEra = Players[iPlayer]:GetCurrentEra()
	save(Players[iPlayer], "LS17HREle", cEra)
	save(Players[iPlayer], "LS17HREon", nil)
	LastEraT[iPlayer] = cEra;
	if globalChoose ~= -1 then
		SetNewDummyLeader(iPlayer, tempOptions[globalChoose][1])
		if tempOptions[globalChoose][2] then
			SetUniqueUnit(iPlayer, tempOptions[globalChoose][2], cEra)
		end
		SetTraitData(iPlayer, tempOptions[globalChoose][3], tempOptions[globalChoose][4], tempOptions[globalChoose][5], tempOptions[globalChoose][6], tempOptions[globalChoose][7])
	else
		DoAnarchy(iPlayer)
	end
end

function PrepareOptionsForHumanPlayer(iPlayer)
	local hTab = {}
	if #PostValidLeaders > 0 then
		local iPlayer = Game.GetActivePlayer();
		local cEra = Players[iPlayer]:GetCurrentEra();
		local bStartEra = cEra == Game.GetStartEra();
		local bUnique = (cEra == eMedieval or cEra == eRenaissance);
		if bUnique then
			ValidUnitTable[cEra] = Shuffle(ValidUnitTable[cEra])
		end
		PostValidLeaders = Shuffle(PostValidLeaders)
		for i = 1, 3 do
			if PostValidLeaders[1] then
				if PostValidLeaders[1][1] == bd then
					table.remove(PostValidLeaders, 1)
					if not PostValidLeaders[1] then
						break;
					end
				end
				local unique;
				if bUnique then
					if ValidUnitTable[cEra][i] then
						unique = ValidUnitTable[cEra][i];
					end
				end
				table.insert(hTab, {PostValidLeaders[1][1], unique})
				table.remove(PostValidLeaders, 1)
			end
		end
--[[		if not bStartEra then
			local yTab = {}
			local cYieldBuilding = load(Players[iPlayer], "LS17HREcyb");
			for i, ydata in pairs(TraitYieldM) do
				if ydata[1] ~= cYieldBuilding then
					table.insert(yTab, i)
				end
			end
			yTab = Shuffle(yTab);
			for i, sth in pairs(hTab) do
				hTab[i][3] = yTab[i];
			end
		end]]
		--[[
		if cEra > eClassical then
			local hRelT = {}
			local bMajor = false;
			for iCity in Players[iPlayer]:Cities() do
				local mRel = iCity:GetReligiousMajority();
				if mRel > -1 then
					if mRel > 0 then
						bMajor = true;
					end
					table.insert(hRelT, mRel)
				end
			end
			if bMajor then
				for i, sth in pairs(hTab) do
					hTab[i][6] = hRelT[math.random(1,#hRelT)];
				end
			end
		end]]
--[[		local policyT = {}
		for i, data in pairs(PolicyLikeTraitT) do
			if not load(Players[iPlayer], "LS17HREhpt" .. data[1]) then
				if (not data[4]) or (cEra > data[4]) then
					table.insert(policyT, i)
				end
			end
		end
		policyT = Shuffle(policyT);
		for i, sth in pairs(hTab) do
			hTab[i][5] = policyT[i];
		end]]
		if cEra == GameInfoTypes.ERA_ANCIENT then
			for i = 1, 3 do
				hTab[i][7] = i;
			end
		elseif cEra == GameInfoTypes.ERA_CLASSICAL then
			for i = 1, 3 do
				hTab[i][7] = i + 3;
			end
		elseif cEra == GameInfoTypes.ERA_MEDIEVAL then
			for i = 1, 3 do
				hTab[i][7] = i + 6;
			end	
		elseif cEra == GameInfoTypes.ERA_RENAISSANCE then
			for i = 1, 3 do
				hTab[i][7] = i + 9;
			end
		elseif cEra == GameInfoTypes.ERA_INDUSTRIAL then
			for i = 1, 3 do
				hTab[i][7] = i + 12;
			end
		elseif cEra == GameInfoTypes.ERA_MODERN then
			for i = 1, 3 do
				hTab[i][7] = i + 15;
			end
		elseif cEra == GameInfoTypes.ERA_FUTURE then
			for i = 1, 3 do
				hTab[i][7] = i + 18;
			end
		else
			local minorT = {}
			local pTeam = Teams[Players[iPlayer]:GetTeam()];
			for i,v in pairs(Players) do
				if v:IsMinorCiv() then
					if v:IsAlive() then
						if pTeam:IsHasMet(v:GetTeam()) then
							if not pTeam:IsAtWar(v:GetTeam()) then
								table.insert(minorT, i)
							end
						end
					end
				end
			end
			if #minorT > 2 then
				minorT = Shuffle(minorT)
				for i, sth in pairs(hTab) do
					hTab[i][4] = minorT[i] or minorT[math.random(1,#minorT)];
				end
			else
				--yield bonus
				local yTab = {}
				local cYieldBuilding = load(Players[iPlayer], "LS17HREcyb");	
				for i, ydata in pairs(TraitYieldM) do
					if ydata[1] ~= cYieldBuilding then
						table.insert(yTab, i)
					end
				end
				yTab = Shuffle(yTab);
				for i, sth in pairs(hTab) do
					hTab[i][3] = yTab[i];
				end
			end
		end
	end
	return hTab;
end

Events.ActivePlayerTurnStart.Add(function()
	local iPlayer = Game.GetActivePlayer();
	if ValidPlayerTable[iPlayer] then
		if Game.GetElapsedGameTurns() > 0 then
			if Players[iPlayer]:GetCurrentEra() ~= LastEraT[iPlayer] then
				if Players[iPlayer]:GetNumCities() > 0 then
					OnPopup( )
				end
			end
		end
	end
end)

function OnPopup( )
	RefreshAll()
	UIManager:QueuePopup( ContextPtr, PopupPriority.InGameUtmost );
end

function OnClose()
    UIManager:DequeuePopup( ContextPtr );
end

function RefreshAll()
	Controls.Pomponada:SetText("It is time to elect a new emperor who will lead us to glory and prosperity in the next era of our ageless civilization. Choose wisely and carefully.")
	local iPlayer = Game.GetActivePlayer();
	local getData = tempGlobalData or PrepareOptionsForHumanPlayer(iPlayer)
	if #getData > 0 then
		save(Players[iPlayer], "LS17HREon", #getData)
		tempOptions = getData;
		leaderInstance:ResetInstances();
		iTsx = {}
		local cMinor = load(Players[iPlayer], "LS17HREccs")
		for i, data in pairs(getData) do
			save(Players[iPlayer], "LS17HREonl" .. i, data[1])
			save(Players[iPlayer], "LS17HREonu" .. i, data[2])
			save(Players[iPlayer], "LS17HREony" .. i, data[3])
			save(Players[iPlayer], "LS17HREoncs" .. i, data[4])
			save(Players[iPlayer], "LS17HREonpt" .. i, data[5])
			save(Players[iPlayer], "LS17HREonrl" .. i, data[6])
			save(Players[iPlayer], "LS17HREontr" .. i, data[7])
			local instance = leaderInstance:GetInstance()
			instance.Button:SetVoid1(i)
			instance.LabelName:SetText("[COLOR_BLACK]" .. Locale.Lookup(GameInfo.Leaders[data[1]].Description))
			local traitstr = "";
			local traittooltip = "";
			local title = ""
			if data[7] then
				traitstr = traitstr .. TraitCoreT[data[7]].Text;
			end
			instance.LabelYieldBonus:SetHide(true)
			if data[3] then
	--			instance.LabelYieldBonus:SetHide(false)
	--			instance.LabelYieldBonus:SetToolTipString(TraitYieldM[data[3]][2]);
	--			instance.LabelYieldBonus:SetText("[COLOR_BLACK]" .. TraitYieldM[data[3]][4])
				title = title .. TraitYieldM[data[3]][3];
				traitstr = traitstr .. TraitYieldM[data[3]][2];
			end
			instance.WorldReligionIcon:SetHide(true)
--			if data[6] then
--				instance.WorldReligionIcon:SetHide(false)
--				IconHookup(GameInfo.Religions[data[6]].PortraitIndex, 48, GameInfo.Religions[data[6]].IconAtlas, instance.WorldReligionIcon);
--				instance.WorldReligionIcon:SetToolTipString(GetTooltipForReligion(iPlayer,data[6]))
--			end
--			traitstr = traitstr .. "[NEWLINE][ICON_BULLET]" .. PolicyLikeTraitT[data[5]][2];
			title = title .. PolicyLikeTraitT[math.random(1,#PolicyLikeTraitT)][3];
			if data[4] then
				local csname = Players[data[4]]:GetName();
				local cFriendship = Players[data[4]]:GetMinorCivFriendshipWithMajor(iPlayer);
				if data[4] == cMinor then
					cFriendship = cFriendship - 50;
				end
				traitstr = traitstr .. "[NEWLINE][ICON_BULLET]+70 [ICON_INFLUENCE] Influence with [ICON_CITY_STATE] " .. csname .. ".";
			--	traittooltip = traittooltip .. "Once this leader is gone [ICON_INFLUENCE] Influence with " .. csname .. " will drop by 50."
				traittooltip = traittooltip .. "[NEWLINE]" .. csname .. " is [COLOR_POSITIVE_TEXT]" .. GetCityStateTraitText(data[4]) .. "[ENDCOLOR].[NEWLINE]Currently you have " .. cFriendship .. " [ICON_INFLUENCE] Influence is there."; 
				title = title .. " of " .. csname;
			end
			instance.LabelTrait:SetText("[COLOR_BLACK]" .. traitstr)
			instance.LabelTrait:SetToolTipString(traittooltip)
			instance.LabelTraitName:SetText("[COLOR_BLACK]" .. title)
			instance.LabelTraitName:SetToolTipString(title)
			IconHookup( GameInfo.Leaders[data[1]].PortraitIndex, 128, GameInfo.Leaders[data[1]].IconAtlas, instance.LeaderPortrait );
			instance.Button:RegisterCallback( Mouse.eLClick, PreMyButtonFunction);
			instance.UniqueBox:SetHide(true);
			if data[2] then
				instance.UniqueBox:SetHide(false)
				instance.BonusUnit:SetText(Locale.Lookup(GameInfo.Units[data[2]].Description));
				local tooltip = GetUUTooltip(data[2])
				instance.BonusUnit:SetToolTipString(tooltip)
				instance.B1:SetToolTipString(tooltip)
				IconHookup(GameInfo.Units[data[2]].PortraitIndex, 64, GameInfo.Units[data[2]].IconAtlas, instance.B1)
			end
			
			table.insert(iTsx, instance)	
		end
		Controls.LeaderStack:CalculateSize();
	else
		print("HRE has too few leaders")
		OnClose()
	end
end

function GTXX()
	return iTsx;
end

--latestuff // anarchy
function PreMyButtonFunction(void1)
	local iPlayer = Game.GetActivePlayer();
	globalChoose = void1;
	Controls.ChooseConfirm:SetHide(false)
end

function OnYes()
	Controls.ChooseConfirm:SetHide(true)
	if globalChoose ~= -1 then
		Events.AudioPlay2DSound("AS2D_INTERFACE_POLICY");
	else
		Events.AudioPlay2DSound("AS2D_EVENT_NOTIFICATION_BAD")
	end
	HumanPlayerChooseAnAbility(Game.GetActivePlayer())
	OnClose()
end
Controls.ConfirmYes:RegisterCallback( Mouse.eLClick, OnYes);

function OnNo()
	Controls.ChooseConfirm:SetHide(true)
end
Controls.ConfirmNo:RegisterCallback( Mouse.eLClick, OnNo);

function GetUUTooltip(unitType, b)
	local unitclass = GameInfo.Units[unitType].Class;
	local defaultunit = GameInfoTypes[GameInfo.UnitClasses[unitclass].DefaultUnit];
	local string = "Every trained or upgraded [COLOR_POSITIVE_TEXT]" .. Locale.Lookup(GameInfo.Units[defaultunit].Description) .. "[ENDCOLOR] is gonna be replaced with [COLOR_POSITIVE_TEXT]" ..  Locale.Lookup(GameInfo.Units[unitType].Description) .. "[ENDCOLOR].";
	if b then
		return string;
	end
	if GameInfo.Units[unitType].Help then
		string = string .. "[NEWLINE][NEWLINE]========[NEWLINE]" ..  Locale.Lookup(GameInfo.Units[unitType].Description) .. "[NEWLINE]========[NEWLINE]" .. Locale.Lookup(GameInfo.Units[unitType].Help)
	end
	return string;
end

function SetTraitData(iPlayer, yBuilding, citystate, npolicy, nrel, traitid)
	local cYield = load(Players[iPlayer], "LS17HREcyb");
	if cYield then
		for iCity in Players[iPlayer]:Cities() do
			iCity:SetNumRealBuilding(TraitYieldM[cYield][1], 0)
			iCity:SetNumRealBuilding(relDummy, 0);
		end
	end
	if yBuilding then
		CurrentYieldTrait[iPlayer] = yBuilding;
		save(Players[iPlayer], "LS17HREcyb", yBuilding)
		for iCity in Players[iPlayer]:Cities() do
			iCity:SetNumRealBuilding(TraitYieldM[yBuilding][1], 2)
		end
	end
--[[	Players[iPlayer]:SetHasPolicy(policybase, false);
	for i, data in pairs(PolicyLikeTraitT) do
		Players[iPlayer]:SetHasPolicy(data[1], false);
	end
	if npolicy then
		Players[iPlayer]:SetHasPolicy(PolicyLikeTraitT[npolicy][1], true);
	else
		Players[iPlayer]:SetHasPolicy(policybase, true);
	end]]

	local cTrait = load(Players[iPlayer], "LS17HREctid");
	if cTrait then
		CurrentTraitID[iPlayer] = nil;
		OnRemoveTrait(iPlayer, cTrait)
	end
	if traitid then
		CurrentTraitID[iPlayer] = traitid;
		OnAddTrait(iPlayer, traitid)
		save(Players[iPlayer], "LS17HREctid", traitid)
	end
--[[	save(Players[iPlayer], "LS17HRErel", nrel)
	if nrel then
		for iCity in Players[iPlayer]:Cities() do
			if iCity:GetReligiousMajority() == nrel then
				iCity:SetNumRealBuilding(relDummy, 1);
			end
		end
	end 
	save(Players[iPlayer], "LS17HREhpt" .. npolicy, 1)]]
	
	
--[[	local cMinor = load(Players[iPlayer], "LS17HREccs")
	if cMinor then
		Players[cMinor]:ChangeMinorCivFriendshipWithMajor(iPlayer, -50)
	end
	save(Players[iPlayer], "LS17HREccs", citystate) ]] 
	if citystate then
		Players[citystate]:ChangeMinorCivFriendshipWithMajor(iPlayer, 70)
	end
	if Game.GetActivePlayer() == iPlayer then
		UpdateIconInTopPanel()
	end
end

GameEvents.CityCaptureComplete.Add(function(player, cap, x, y, nPlayer)
	if CurrentYieldTrait[nPlayer] then
		local iCity = Map.GetPlot(x,y):GetPlotCity();
		iCity:SetNumRealBuilding(TraitYieldM[CurrentYieldTrait[nPlayer]][1], 2)
--[[	if iCity:GetReligiousMajority() == CurrentRelTrait[nPlayer] then
			iCity:SetNumRealBuilding(relDummy, 1);
		end]]
	end
	if CurrentTraitID[nPlayer] then
		NewCityAcquired(nPlayer, Map.GetPlot(x,y):GetPlotCity(), CurrentTraitID[nPlayer]);
	end
end)

GameEvents.PlayerCityFounded.Add(function(nPlayer, x, y)
	if CurrentYieldTrait[nPlayer] then
		Map.GetPlot(x,y):GetPlotCity():SetNumRealBuilding(TraitYieldM[CurrentYieldTrait[nPlayer]][1], 2)
	end
	if CurrentTraitID[nPlayer] then
		NewCityAcquired(nPlayer, Map.GetPlot(x,y):GetPlotCity(), CurrentTraitID[nPlayer]);
	end
end)

function GetCityStateTraitText(iMinor)
	local strTraitText = "";
	local pMinor = Players[iMinor];
	if (pMinor ~= nil) then
		local iTrait = pMinor:GetMinorCivTrait();
		if (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_CULTURED) then
			strTraitText = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_CULTURED_ADJECTIVE");
		elseif (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_MILITARISTIC) then
			strTraitText = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_MILITARISTIC_ADJECTIVE");
		elseif (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_MARITIME) then
			strTraitText = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_MARITIME_ADJECTIVE");
		elseif (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_MERCANTILE) then
			strTraitText = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_MERCANTILE_ADJECTIVE");
		elseif (iTrait == MinorCivTraitTypes.MINOR_CIV_TRAIT_RELIGIOUS) then
			strTraitText = Locale.ConvertTextKey("TXT_KEY_CITY_STATE_RELIGIOUS_ADJECTIVE");
		end
	end
	return strTraitText;
end

--Top Panel

function UpdateIconInTopPanel()
	local iPlayer = Game.GetActivePlayer();
	local cYield = load(Players[iPlayer], "LS17HREcyb")
	local cLeader = load(Players[iPlayer], "LS17HRErl");
	local cMinor = load(Players[iPlayer], "LS17HREccs")
	local cRel = load(Players[iPlayer], "LS17HRErel")
	local cMain;
	local txt = "Your current leader is " .. Locale.Lookup(GameInfo.Leaders[cLeader].Description) .. ".[NEWLINE]";
	local noBonus = true;
	CivIconHookup( Game.GetActivePlayer(), 32, Controls.Icon, Controls.CivIconBG, Controls.CivIconShadow, false, true );
	for i, data in pairs(PolicyLikeTraitT) do
		if Players[iPlayer]:HasPolicy(data[1]) then
			cMain = i;
		end
	end
	if cYield then
		txt = txt .. "[NEWLINE][ICON_BULLET]" .. TraitYieldM[cYield][2];
		noBonus = false;
	end
	if cMain then
		txt = txt .. "[NEWLINE][ICON_BULLET]" .. PolicyLikeTraitT[cMain][2];
		noBonus = false;
	end
	if cRel then
		txt = txt .. "[NEWLINE][ICON_BULLET]Every city following " .. GameInfo.Religions[cRel].IconString .. " " .. Locale.Lookup(GameInfo.Religions[cRel].Description) .. " has +1 [ICON_HAPPINESS_1] Happiness.";
	end	
	if cMinor then
		txt = txt .. "[NEWLINE][ICON_BULLET]Your leader is from city-state of " .. Players[cMinor]:GetName() .. ".";
		noBonus = false;
	end
	for classtype, type in pairs(repTable[iPlayer] or {}) do
		txt = txt .. "[NEWLINE][ICON_BULLET]" .. GetUUTooltip(type, true);
	end
	if CurrentTraitID[iPlayer] then
		noBonus = false;
		txt = txt .. "[NEWLINE][ICON_BULLET]" .. TraitCoreT[CurrentTraitID[iPlayer]].Text;
	end
	if noBonus then
		txt = txt .. "[NEWLINE]Your leader is not providing any bonuses.";
	end
	Controls.IconBox:SetToolTipString(txt);
end

function GetTooltipForReligion(iPlayer, iRel)
	local str = "Every city following " .. GameInfo.Religions[iRel].IconString .. " [COLOR_POSITIVE_TEXT]" .. Locale.Lookup(GameInfo.Religions[iRel].Description) .. "[ENDCOLOR] will have +1 [ICON_HAPPINESS_1] Happiness."
	local num = 0;
	for iCity in Players[iPlayer]:Cities() do
		if iCity:GetReligiousMajority() == iRel then
			num = num + 1;
		end
	end
	str = str .. "[NEWLINE][NEWLINE]Right now [COLOR_POSITIVE_TEXT]" .. num .. "[ENDCOLOR] of your cities follows it.";
	return str;
end

--[[GameEvents.CityConvertsReligion.Add(function(iPlayer, iRel, x, y)
	if CurrentRelTrait[iPlayer] then
		local iCity = Map.GetPlot(x,y):GetPlotCity();
		if CurrentRelTrait[iPlayer] == iCity:GetReligiousMajority() then
			iCity:SetNumRealBuilding(relDummy, 1);
		else
			iCity:SetNumRealBuilding(relDummy, 0);
		end
	end
end)]]
			
Controls.CRPLSB:SetVoid1(-1)
Controls.CRPLSB:RegisterCallback( Mouse.eLClick, PreMyButtonFunction);
Controls.CRPLSB:SetToolTipString("Forces another leader with unknown traits, starting anarchy for 1-3 turns.")
Controls.CRPLSB:SetHide(true)

function DoAnarchy(iPlayer)
	if #PostValidLeaders > 0 then
		local cEra = Players[iPlayer]:GetCurrentEra()
		local bStartEra = cEra == Game.GetStartEra();
		PostValidLeaders = Shuffle(PostValidLeaders)
		if PostValidLeaders[1] then
			if PostValidLeaders[1][1] == bd then
				table.remove(PostValidLeaders, 1)
				if not PostValidLeaders[1] then
					return
				end
			end
		else
			return
		end
		local str = "It seems that " .. Locale.Lookup(GameInfo.Leaders[PostValidLeaders[1][1]].Description) .. " will end Anarchy soon and become our leader.[NEWLINE]"
		SetNewDummyLeader(iPlayer, PostValidLeaders[1][1])
		table.remove(PostValidLeaders, 1)
		if cEra == eMedieval or cEra == eRenaissance then
			local bGuysUnique = {}
			for i, data in pairs(tempOptions) do
				if data[2] then
					bGuysUnique[data[2]] = 1;
				end
			end
			local hUniqueTab = {}
			for i, stuff in pairs(ValidUnitTable[cEra]) do
				if not bGuysUnique[stuff] then
					table.insert(hUniqueTab, stuff)
				end
			end
			hUniqueTab = Shuffle(hUniqueTab)
			if hUniqueTab[1] then
				SetUniqueUnit(iPlayer, hUniqueTab[1], cEra)
				str = str .. "[NEWLINE][ICON_BULLET]" .. GetUUTooltip(hUniqueTab[1], true);
			end
		end
		local hy;
		if not bStartEra then
			local yTab = {}
			local bYield = {}
			for i, data in pairs(tempOptions) do
				if data[3] then
					bYield[data[3]] = 1;
				end
			end
			local cYieldBuilding = load(Players[iPlayer], "LS17HREcyb");
			for i, ydata in pairs(TraitYieldM) do
				if ydata[1] ~= cYieldBuilding then
					if not bYield[ydata[1]] then
						table.insert(yTab, i)
					end
				end
			end
			hy = yTab[math.random(1,#yTab)];
			str = str .. "[NEWLINE][ICON_BULLET]" .. TraitYieldM[hy][2];
		end
		local policyT = {}
		local bpolicy = {}
		for i, data in pairs(tempOptions) do
			if data[5] then
				bpolicy[data[5]] = 1;
			end
		end
		for i, data in pairs(PolicyLikeTraitT) do
			if not load(Players[iPlayer], "LS17HREhpt" .. data[1]) then
				if (not data[4]) or (cEra > data[4]) then
					if not bpolicy[data[1]] then
						table.insert(policyT, i)
					end
				end
			end
		end
		local hp = policyT[math.random(1,#policyT)];
		str = str .. "[NEWLINE][ICON_BULLET]" .. PolicyLikeTraitT[hp][2];
		--City State and Religion can overlap
		local hcs;
		if not bStartEra then
			local minorT = {}
			local pTeam = Teams[Players[iPlayer]:GetTeam()];
			for i,v in pairs(Players) do
				if v:IsMinorCiv() then
					if v:IsAlive() then
						if pTeam:IsHasMet(v:GetTeam()) then
							if not pTeam:IsAtWar(v:GetTeam()) then
								table.insert(minorT, i)
							end
						end
					end
				end
			end
			if #minorT > 0 then
				hcs = minorT[math.random(1,#minorT)];
				local csname = Players[hcs]:GetName();
				str = str .. "[NEWLINE][ICON_BULLET]+70 [ICON_INFLUENCE] Influence with [ICON_CITY_STATE] " .. csname .. ".";
			end
		end
		local hRel;
		if cEra > eClassical then
			local hRelT = {}
			local bMajor = false;
			for iCity in Players[iPlayer]:Cities() do
				local mRel = iCity:GetReligiousMajority();
				if mRel > -1 then
					if mRel > 0 then
						bMajor = true;
					end
					table.insert(hRelT, mRel)
				end
			end
			if bMajor then
				hRel = hRelT[math.random(1,#hRelT)];
				str = str .. "[NEWLINE][ICON_BULLET]Every city following " .. GameInfo.Religions[hRel].IconString .. " " .. Locale.Lookup(GameInfo.Religions[hRel].Description) .. " has +1 [ICON_HAPPINESS_1] Happiness.";
			end
		end
		Players[iPlayer]:ChangeAnarchyNumTurns(math.random(1,3))
		Players[iPlayer]:AddNotification(NotificationTypes.NOTIFICATION_GENERIC , str, "Anarchy!")
		SetTraitData(iPlayer, hy, hcs, hp, hRel)
	end
end

local hredummyFT = GameInfoTypes.BUILDING_DUMMY_LS_HRE_FT;

function OnAddTrait(iPlayer, cTrait)
	local cCity = Players[iPlayer]:GetCapitalCity();
	if TraitCoreT[cTrait].Policy then
		Players[iPlayer]:SetHasPolicy(policybase, false);
		Players[iPlayer]:SetHasPolicy(TraitCoreT[cTrait].Policy, true);
	end
	if cCity then
		if TraitCoreT[cTrait].Building then
			for iCity in Players[iPlayer]:Cities() do
				iCity:SetNumRealBuilding(TraitCoreT[cTrait].Building, 1)
			end
		end
		if cTrait == 3 then
			local jUnit = Players[iPlayer]:InitUnit(GameInfoTypes.UNIT_SCOUT, cCity:GetX(), cCity:GetY());
			jUnit:JumpToNearestValidPlot();
		elseif cTrait == 6 then
			local jUnit = Players[iPlayer]:InitUnit(GameInfoTypes.UNIT_SETTLER, cCity:GetX(), cCity:GetY());
			jUnit:JumpToNearestValidPlot();
		elseif cTrait == 9 then
			local jUnit = Players[iPlayer]:InitUnit(GameInfoTypes.UNIT_WRITER, cCity:GetX(), cCity:GetY());
			jUnit:JumpToNearestValidPlot();
		elseif cTrait == 12 then
			local jUnit = Players[iPlayer]:InitUnit(GameInfoTypes.UNIT_GREAT_GENERAL, cCity:GetX(), cCity:GetY());
			jUnit:JumpToNearestValidPlot();
		elseif cTrait == 15 then
			Players[iPlayer]:ChangeNumResourceTotal(GameInfoTypes.RESOURCE_COAL, 5);
		elseif cTrait == 18 then
			cCity:SetNumRealBuilding(hredummyFT, 1);
			cCity:SetNumRealBuilding(hredummyFT, 0);
		elseif cTrait == 19 then
			Players[iPlayer]:ChangeNumFreePolicies(1);
		elseif cTrait == 20 then
			local jUnit = Players[iPlayer]:InitUnit(GameInfoTypes.UNIT_ENGINEER, cCity:GetX(), cCity:GetY());
			jUnit:JumpToNearestValidPlot();
		elseif cTrait == 21 then
			local jUnit = Players[iPlayer]:InitUnit(GameInfoTypes.UNIT_SCIENTIST, cCity:GetX(), cCity:GetY());
			jUnit:JumpToNearestValidPlot();
		end
	end
end

function OnRemoveTrait(iPlayer, cTrait)
	if TraitCoreT[cTrait].Building then
		for iCity in Players[iPlayer]:Cities() do
			iCity:SetNumRealBuilding(TraitCoreT[cTrait].Building, 0)
		end
	end
	if TraitCoreT[cTrait].Policy then
		Players[iPlayer]:SetHasPolicy(policybase, true);
		Players[iPlayer]:SetHasPolicy(TraitCoreT[cTrait].Policy, false);
	end
end

function NewCityAcquired(nPlayer, iCity, cTrait)
	if TraitCoreT[cTrait].Building then
		iCity:SetNumRealBuilding(TraitCoreT[cTrait].Building, 1)
	end
end