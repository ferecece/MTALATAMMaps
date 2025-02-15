-- Compiled by Scene2Res, a MTA:SA GTA III engine map importer
local streamerMemory=0;
local cached={};
local resourceQueue={};
local textureCache = {};
local streamedObjects = {};
local pModels = {};

setCloudsEnabled(false);
debug.sethook(nil);

local function getResourceSize(path)
	if not (fileExists(path)) then return 0; end;

	local file = fileOpen(path);
	local size = fileGetSize(file)

	fileClose(file);
	return size;
end

local function requestTexture(model, path)
	local txd = textureCache[path];

	if not (txd) then
		local size = getResourceSize(path);
		if (size == 0) then return false; end

		if ( streamerMemory + size > 268435456 ) then
			outputDebugString("out of streaming memory! ("..path..")");
			return false;
		end

		txd = engineLoadTXD(path, false);

		if not (txd) then
			return false;
		end

		textureCache[path] = txd;
		streamerMemory = streamerMemory + size;
	end
	return txd;
end

local function loadResources(model, size)
	if not (model.impTxd) then
       if (model.txd) then
		    engineImportTXD(model.txd, model.id);

       end
		model.impTxd = true;
	end

	model.model = engineLoadDFF(model.model_file, model.id);

	if not (model.model) then return false; end;

	if not (model.col_file) then
		if not (model.super) then return false; end

		model.col = pModels[model.super].col;
	else
		model.col = engineLoadCOL(model.col_file, 0);

		if not (model.col) then return false; end
	end

	cached[model.id] = {
		model = model,
		size = size
	};
	resourceQueue[model.id] = nil;
	streamerMemory = streamerMemory + size;
	return true;
end

local function freeResources(model)
	local cache = cached[model.id];

	if not (cache) then return true; end

	if (model.col_file) then
		destroyElement(model.col);
	end
	destroyElement(model.model);
	model.model = nil;
	model.col = nil;
	cached[model.id] = nil;
	streamerMemory = streamerMemory - cache.size;
	return true;
end

local function cacheResources(model)
	if (resourceQueue[model.id]) then return false; end

	if (cached[model.id]) then return true; end

	local size = getResourceSize(model.model_file);
	if (model.col_file) then
		size = size + getResourceSize(model.col_file);
	end
	if ( streamerMemory + size > 268435456 ) then
		outputDebugString("streamer memory limit reached... queueing request!");

		resourceQueue[model.id] = {
			size = size,
			model = model
		};
		return false;
	end

	return loadResources(model, size);
end

local function loadModel(model)
	if (model.loaded) then return true; end

	if (model.super) then
       local superModel = pModels[model.super];
       if (superModel) then
		    if not (loadModel(superModel)) then
			    return false;
		    end
       end
	end

	if not (cacheResources(model)) then return false; end

	engineReplaceModel(model.model, model.id);
	engineReplaceCOL(model.col, model.id);

	model.loaded = true;
	return true;
end

local function freeModel(model)
	if not (model.loaded) then return true; end

	engineRestoreModel(model.id);
	engineRestoreCOL(model.id);

	model.loaded = false;
	if (model.super) then
       local superModel = pModels[model.super];
       if (superModel) then
		    freeModel(superModel);
       end
	end
end

local function modelStreamOut ()
	local pModel = pModels[getElementModel(source)];

	if not (pModel) then return end;

	if (pModel.lodID) then return true; end

	pModel.numStream = pModel.numStream - 1;

	if (pModel.numStream == 0) then
		freeModel(pModel);
	end
end

local function modelStreamIn ()
	local pModel = pModels[getElementModel(source)];

	if not (pModel) then return end;

	if (pModel.lodID) then return true; end

	pModel.numStream = pModel.numStream + 1;

	if not (pModel.numStream == 1) then return true; end

	if not (loadModel(pModel)) then
		setElementInterior(source, 123);
		setElementCollisionsEnabled(source, false);
	end
end

function loadModels ()
	local pModel, pTXD, pColl, pTable;

	pTable={

	};

	for m,n in ipairs(pTable) do
		pModels[n[1]] = {
			id = n[1],
			name = n[2],
			txd = requestTexture(false, "textures/"..n[3]..".txd"),
			numStream = 0,
			lod = n[4] / 5,
			super = n[5]
		};
		pModelEntry = pModels[n[1]];
		pModelEntry.model_file = "models/"..n[2]..".dff";
		engineSetModelLODDistance(n[1], n[4] / 5);
	end

	pTable={
		{ model=3975, model_file="nqrr_track1", txd_file="nqrr", coll_file="nqrr_track1", lod=300 },
		{ model=3982, model_file="nqrr_track1h", txd_file="nqrr", coll_file="nqrr_track1h", lod=300 },
		{ model=3976, model_file="nqrr_start", txd_file="nqrr", coll_file="nqrr_start", lod=300 },
		{ model=3978, model_file="nqrr_finish", txd_file="nqrr", coll_file="nqrr_finish", lod=300 },
		{ model=3980, model_file="nqrr_tree2", txd_file="nqrr", coll_file="nqrr_tree2", lod=300 },
		{ model=3979, model_file="nqrr_tree1", txd_file="nqrr", coll_file="nqrr_tree1", lod=300 },
		{ model=3981, model_file="nqrr_tree3", txd_file="nqrr", coll_file="nqrr_tree3", lod=300 }
	};

	local n,m;

	for n,m in ipairs(pTable) do
		pModels[m.model] = {
			id = m.model,
			name = m.model_file,
			txd = requestTexture(false, "textures/"..m.txd_file..".txd"),
			numStream = 0,
			lod = m.lod,
			lodID = m.lodID
		};
		pModelEntry = pModels[m.model];
		pModelEntry.model_file="models/"..m.model_file..".dff";
		pModelEntry.col_file="coll/"..m.coll_file..".col";
		engineSetModelLODDistance(m.model, m.lod);

		if (m.lodID) then
			for j,k in ipairs(getElementsByType("object", resourceRoot)) do
				if (getElementModel(k) == m.model) then
					local x, y, z = getElementPosition(k);
					local rx, ry, rz = getElementRotation(k);
					setLowLODElement(k, createObject(m.lodID, x, y, z, rx, ry, rz, true));
				end
			end
		end
	end
end
loadModels();

addEventHandler("onClientPreRender", root, function()
		local m,n;
		local objects = getElementsByType("object", resourceRoot);
		local x, y, z = getCameraMatrix();

		for m,n in ipairs(objects) do
			local model = pModels[getElementModel(n)];

			if (model) then
				local streamObject = streamedObjects[n];
				local distance = getDistanceBetweenPoints3D(x, y, z, getElementPosition(n));

				if not (streamObject) then
					if (distance < model.lod) then
						source = n;

						modelStreamIn();

						streamedObjects[n] = true;
					end
				elseif (distance > model.lod) then
					source = n;

					modelStreamOut();

					streamedObjects[n] = nil;
				end
			end
		end
	end
);

local function getBiggestCacheObject()
	local obj;
	local size = 0;

	for m,n in pairs(cached) do
		if (size < n.size) and not (n.model.loaded) then
			size = n.size;
			obj = n.model;
		end
	end
	return obj, size;
end

addEventHandler("onClientRender", root, function()
		local _,request = ({ pairs(resourceQueue) })[1]( resourceQueue );
		if not (request) then return true; end;

		while ( streamerMemory + request.size > 268435456 ) do
			local cacheObj = getBiggestCacheObject();
			if not (cacheObj) then
				outputDebugString("waiting for cache objects...");
				return true;
			end

			freeResources(cacheObj);
		end
		resourceQueue[request.model.id] = nil;

		local model = request.model;

		if not (loadModel(model)) then return false; end

		for m,n in ipairs(getElementsByType("object", resourceRoot)) do
			if (getElementModel(n) == model.id) then
				setElementInterior(n, 0);
				setElementCollisionsEnabled(n, true);
			end
		end
	end
);

addCommandHandler("mcollect", function()
		outputDebugString("collecting map garbage...");

		for m,n in pairs(cached) do
			if (n.model.loaded == false) then
				freeResources(n.model);
			end
		end
		collectgarbage();
	end
);

addCommandHandler("mapmem", function()
		outputChatBox("streamer memory: "..streamerMemory.." out of 268435456");
	end
);

collectgarbage("collect");
setJetpackMaxHeight(1700);
