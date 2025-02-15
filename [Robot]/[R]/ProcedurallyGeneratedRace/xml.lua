-- ## XML Stuff

Xml = {}
function Xml:new(file,rootName)
	local object = {}
	setmetatable(object,self)
	self.__index = self
	object.file = file
	object.rootName = rootName
	object.rootNode = nil
	return object
end

function Xml:open(tryToOpenAutomatically)
	self.autoOpened = false
	
	if self.rootNode ~= nil then
		return
	end
	if tryToOpenAutomatically then
		self.autoOpened = true
		
	end
	local rootNode = xmlLoadFile(self.file)
	if not rootNode then
		rootNode = xmlCreateFile(self.file,self.rootName)
	end
	self.rootNode = rootNode
	return rootNode
end

function Xml:getAttribute(node,attributeName)
	self:open(true)
	if type(node) == "table" then
		node = self:findNode(node)
		if node == false then
			return false
		end
	end
	if node == "root" then
		node = self.rootNode
	end
	local attribute = xmlNodeGetAttribute(node,tostring(attributeName))
	return attribute
end

function Xml:findNode(table)
	local parent = table.parent
	if parent == nil or parent == "root" then
		parent = self.rootNode
	end
	local tag = table.tag
	local attribute = table.attribute
	if attribute == nil then
		attribute = {}
	end
	
	local children = xmlNodeGetChildren(parent)
	if children == false then return false end
	for i,node in ipairs(children) do
		if self:matchNode(node,tag,attribute) then
			return node
		end
	end
	if table.create == true then
		return self:createChild(parent,tag,attribute)
	end
	return false
end

function Xml:createChild(parent,tag,attribute)
	if tag == nil then
		tag = "node"
	end
	if attribute == nil then
		attribute = {}
	end
	local node = xmlCreateChild(parent,tag)
	for k,v in pairs(attribute) do
		xmlNodeSetAttribute(node,tostring(k),tostring(v))
	end
	return node
end

function Xml:matchNode(node,tag,attribute)
	-- check if tag (node-name) matches (or rather if it doesn't)
	if tag ~= nil and xmlNodeGetName(node) ~= tag then
		return false
	end
	-- check if attributes match (or rather if one doesn't)
	for k,v in pairs(attribute) do
		local attr = xmlNodeGetAttribute(node,k)
		if attr ~= tostring(v) then
			return false
		end
	end
	return true
end

function Xml:unload()
	xmlUnloadFile(self.rootNode)
	self.rootNode = nil
end