-- FILE: customMapEditorScriptingExtension_s.lua
-- PURPOSE: Prevent the map editor feature set being limited by what MTA can load from a map file by adding a script file to maps
-- VERSION: 07/January/2025 , custom edit by LotsOfS
-- IMPORTANT: Check the resource 'editor_main' at https://github.com/mtasa-resources/ for updates

local resourceName = getResourceName(resource)
local usedLODModels = {}
local LOD_MAP_NEW = {}

-- Makes removeWorldObject map entries and LODs work
local function onResourceStartOrStop(startedResource)
	local startEvent = eventName == "onResourceStart"
	local removeObjects = getElementsByType("removeWorldObject", source)

	for removeID = 1, #removeObjects do
		local objectElement = removeObjects[removeID]
		local objectModel = getElementData(objectElement, "model")
		local objectLODModel = getElementData(objectElement, "lodModel")
		local posX = getElementData(objectElement, "posX")
		local posY = getElementData(objectElement, "posY")
		local posZ = getElementData(objectElement, "posZ")
		local objectInterior = getElementData(objectElement, "interior") or 0
		local objectRadius = getElementData(objectElement, "radius")

		if startEvent then
			removeWorldModel(objectModel, objectRadius, posX, posY, posZ, objectInterior)
			removeWorldModel(objectLODModel, objectRadius, posX, posY, posZ, objectInterior)
		else
			restoreWorldModel(objectModel, objectRadius, posX, posY, posZ, objectInterior)
			restoreWorldModel(objectLODModel, objectRadius, posX, posY, posZ, objectInterior)
		end
	end

	if startEvent then
		local useLODs = get(resourceName..".useLODs")

		if useLODs then
			local objectsTable = getElementsByType("object", source)

			for objectID = 1, #objectsTable do
				local objectElement = objectsTable[objectID]
				local objectModel = getElementModel(objectElement)
				local lodModel = LOD_MAP_NEW[objectModel]

				if lodModel then
					local objectX, objectY, objectZ = getElementPosition(objectElement)
					local objectRX, objectRY, objectRZ = getElementRotation(objectElement)
					local objectInterior = getElementInterior(objectElement)
					local objectDimension = getElementDimension(objectElement)
					local objectAlpha = getElementAlpha(objectElement)
					local objectScale = getObjectScale(objectElement)
					
					local lodObject = createObject(lodModel, objectX, objectY, objectZ, objectRX, objectRY, objectRZ, true)
					
					setElementInterior(lodObject, objectInterior)
					setElementDimension(lodObject, objectDimension)
					setElementAlpha(lodObject, objectAlpha)
					setObjectScale(lodObject, objectScale)

					setElementParent(lodObject, objectElement)
					setLowLODElement(objectElement, lodObject)

					usedLODModels[lodModel] = true
				end
			end
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, onResourceStartOrStop, false)
addEventHandler("onResourceStop", resourceRoot, onResourceStartOrStop, false)

-- MTA LOD Table [object] = [lodmodel] 
LOD_MAP_NEW = {
	[18474] = 18525, -- cstwnland03 => cstwnland_lod (countryS)
	[4091] = 4097, -- supports07_lan => lodsupports07_lan (LAn)
	[5394] = 5567, -- xstpdnam_lae => lodxrailbrij1 (LAe)
	[3268] = 3366, -- mil_hangar1_ => lod_mil_hangar1_ (countn2)
	[3887] = 3888, -- demolish4_sfxrf => loddemolish4_sfxrf (SFSe)
	[3643] = 3745, -- la_chem_piping => lodla_chem_piping (LAs2)
	[3651] = 3650, -- ganghous04_lax => lodganghous04_lax (LAe2)
	[8194] = 8195, -- vgsscorrag_fence01 => lodscorrag_fence01 (vegasS)
	[11326] = 11328, -- sfse_hublockup => lod_hublockup (SFSe)
	[11011] = 11376, -- crackfactjump_sfs => lodckfactjump_sfs (SFSe)
	[1267] = 1261, -- billbd2 => lodlbd2 (LAe)
	[5728] = 5954, -- dummybuild46_law => lodmybuild46_law (LaWn)
	[18247] = 18560, -- cuntwjunk03 => cuntwjunk03_lod (countryS)
	[5004] = 5008, -- lasrnway6_las => lodrnway6_las (LAs)
	[4847] = 4933, -- beach1_las0gj => lodch1_las0gj01 (LAs)
	[7446] = 7762, -- vegasnroad40 => lodasnroad40 (vegasW)
	[8540] = 8791, -- vgsrailroad05 => lodrailroad05 (vegasE)
	[13190] = 13203, -- ce_busdepot => busdepot_lod (countrye)
	[6990] = 7008, -- vegasnroad797 => lodasnroad797 (vegasN)
	[4842] = 4932, -- beach1_las0fg => lodch1_las0fg01 (LAs)
	[9958] = 10285, -- submarr_sfe => lodmarr_sfe (SFe)
	[7479] = 7768, -- vegasnroad46 => lodasnroad46 (vegasW)
	[8247] = 8250, -- pltschlhnger69_lvs => lodschlhnger69_lvs (vegasS)
	[6881] = 6892, -- vegasnroad072 => lodasnroad072 (vegasN)
	[3866] = 3869, -- demolish1_sfxrf => loddemolish1_sfxrf (SFSe)
	[8658] = 8999, -- shabbyhouse11_lvs => lodbbyhouse11_lvs (vegasE)
	[5291] = 5357, -- snpedscrsap_las01 => lodedscrsap_las02 (LAs2)
	[3244] = 3338, -- pylon_big1_ => pylon_lodbig1_ (countn2)
	[6914] = 7179, -- vgsnrailroad05 => lodnrailroad05 (vegasN)
	[11012] = 11270, -- crackfact_sfs => lodcrackfact_sfs (SFSe)
	[3589] = 3592, -- compfukhouse3 => lodpfukhouse3 (LAe2)
	[3269] = 3369, -- bonyrd_block1_ => lod_bnyd_blk1_ (countn2)
	[17636] = 17722, -- lae2_ground11 => lodlae2_ground11 (LAe2)
	[7052] = 7129, -- vegasnroad079 => lodasnroad079 (vegasN)
	[8947] = 8958, -- vgelkup => lodelockup_01 (vegasE)
	[3755] = 3756, -- las2warhus_las2 => lodwarhus_las03 (LAs2)
	[13295] = 13298, -- ce_terminal1 => lodce_terminal1 (countrye)
	[10828] = 10893, -- drydock1_sfse => loddock1_sfse (SFSe)
	[3655] = 3656, -- ganghous03_lax => lodganghous03_lax (LAe2)
	[3648] = 3647, -- ganghous02_lax => lodganghous02_lax (LAe2)
	[11092] = 11163, -- burgalrystore_sfs => lodgalrystore_sfs (SFSe)
	[8186] = 8191, -- vgssredbrix03 => lodsredbrix03 (vegasS)
	[3646] = 3706, -- ganghous05_lax => lodgnghos05_lax (LAe2)
	[18266] = 18498, -- wtown_shops => lodwn_shops (countryS)
	[10023] = 10155, -- sfe_archybald1 => lod_archybald1 (SFe)
	[3270] = 3368, -- bonyrd_block2_ => lod_bnyd_blk2_ (countn2)
	[3271] = 3367, -- bonyrd_block3_ => lod_bnyd_blk3_ (countn2)
	[11088] = 11282, -- cf_ext_dem_sfs => lodext_dem_sfs (SFSe)
	[3649] = 3654, -- ganghous01_lax => lodganghous01_lax (LAe2)
}