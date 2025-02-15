-- FILE: newMapEditorScriptingExtension_s.lua
-- PURPOSE: Prevent the map editor feature set being limited by what MTA can load from a map file by adding a script file to maps
-- VERSION: 11/October/2024
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
LOD_MAP_NEW = {[6342] = 6475, [17602] = 17813, [5513] = 5558, [4564] = 4579, [4022] = 4191, [4251] = 4386, [11540] = 11581, [11556] = 11641, [7836] = 7835, [4585] = 4626,
[0] = 0, [17596] = 17834, [3168] = 3343, [10815] = 11373, [3167] = 3340, [10056] = 9938, [4602] = 4580, [3244] = 3338}