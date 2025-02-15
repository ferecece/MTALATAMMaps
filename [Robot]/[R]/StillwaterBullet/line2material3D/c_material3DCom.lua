--
-- file: c_material3DCom.lua
-- version: v1.5
-- author: Ren712
-- This class allows creation of screen space dxImages in 3d world space.
--
  
local scx,scy = guiGetScreenSize ()
    
CMat3DCom = { }
CMat3DCom.__index = CMat3DCom
	 
function CMat3DCom: create()
	local scX, scY = guiGetScreenSize()
	local cShader = {
		shader = dxCreateShader( "line2material3D/fx/material3DCom.fx" ),
		texture = nil,
		color = tocolor(255, 255, 255, 255),
		texCoord = {Vector2(1, 1),Vector2(0, 0)},
		position = Vector3(0,0,0),
		rotation = Vector3(0,0,0),
		size = Vector2(0,0),
		destBlend = 6, -- see D3DBLEND https://msdn.microsoft.com/en-us/library/windows/desktop/bb172508%28v=vs.85%29.aspx
		billboard = false,
		isCorona = false,
		depthBias = 1,
		distFade = Vector2(450, 400),
		zEnable = true,
		zWriteEnable = true,
		flipVertex = false,
		fogEnable = true,
		cullMode = 1 -- see D3DCULL https://msdn.microsoft.com/en-us/library/windows/desktop/bb172529%28v=vs.85%29.aspx
	}
	if cShader.shader then
		-- screen resolution also to scale image size and proportions to 1x1 world unit
		cShader.shader:setValue( "sScrRes", {scX, scY} )
		-- pass position and a forward vector to recreate gWorld matrix
		cShader.shader:setValue( "sElementRotation", 0, 0, 0 )
		cShader.shader:setValue( "sElementPosition", 0, 0, 0 )
		cShader.shader:setValue( "sElementSize", 1, 1 )
		cShader.shader:setValue( "sFlipTexture", false )
		cShader.shader:setValue( "sFlipVertex", cShader.flipVertex )
		cShader.shader:setValue( "sIsBillboard", cShader.billboard )
		cShader.shader:setValue( "fDestBlend" ,cShader.destBlend )
		cShader.shader:setValue( "bIsCorona", cShader.isCorona )
		cShader.shader:setValue( "fDepthBias", cShader.depthBias )
		cShader.shader:setValue( "gDistFade", cShader.distFade.x, cShader.distFade.y )
		cShader.shader:setValue( "uvMul", cShader.texCoord[1].x, cShader.texCoord[1].y )
		cShader.shader:setValue( "uvPos", cShader.texCoord[2].x, cShader.texCoord[2].y )
		cShader.shader:setValue( "sFogEnable", cShader.fogEnable )
		cShader.shader:setValue( "fZEnable", cShader.zEnable )
		cShader.shader:setValue( "fZWriteEnable", cShader.zWriteEnable )
		cShader.shader:setValue( "fCullMode", cShader.cullMode )
		self.__index = self
		setmetatable( cShader, self )
		return cShader
	else
		return false
	end
end

function CMat3DCom: setCorona( isCorona )
	if self.shader then
		self.isCorona = isCorona
		if isCorona then
			self.isBillboard = true
			self.destBlend = 2
			self.zWriteEnable = false
			self.fogEnable = false
		end
		self.shader:setValue( "bIsCorona", self.isCorona )
		self.shader:setValue( "fZWriteEnable", self.zWriteEnable )
		self.shader:setValue( "sFogEnable", self.fogEnable )
		self.shader:setValue( "sIsBillboard", self.isBillboard )
		self.shader:setValue( "fDestBlend" ,self.destBlend )		
	end
end

function CMat3DCom: setBlendAdd( isAddBlend )
	if self.shader then
		if isAddBlend then
			self.destBlend = 2
		else
			self.destBlend = 6	
		end
		self.shader:setValue( "fDestBlend" ,self.destBlend )		
	end
end

function CMat3DCom: setDistFade( distFade )
	if self.shader then
		self.distFade = distFade
		self.shader:setValue( "gDistFade", self.distFade.x, self.distFade.y )
	end
end


function CMat3DCom: setTexture( texture )
	if self.shader then
		self.texture = texture
		self.shader:setValue( "sTexColor", self.texture )		
	end
end

function CMat3DCom: setPosition( pos )
	if self.shader then
		self.position = pos
		self.shader:setValue( "sElementPosition", pos.x, pos.y, pos.z )
	end
end

function CMat3DCom: setCullMode( cull )
	if self.shader then
		self.cullMode = cull
		self.shader:setValue( "fCullMode", cull )
	end
end

function CMat3DCom: setZEnable( isEnabled )
	if self.shader then
		self.zEnable = isBill
		self.shader:setValue( "fZEnable", self.zEnable )
	end
end

function CMat3DCom: setZWriteEnable( isEnabled )
	if self.shader then
		self.zWriteEnable = isBill
		self.shader:setValue( "fZWriteEnable", self.zWriteEnable )
	end
end

function CMat3DCom: setFogEnable( isEnabled )
	if self.shader then
		self.fogEnable = isBill
		self.shader:setValue( "fFogEnable", self.fogEnable )
	end
end

function CMat3DCom: setFlipVertex( flip )
	if self.shader then
		self.flipVertex = flip
		self.shader:setValue( "sFlipVertex", flip )
	end
end

-- rotation order "ZXY"
function CMat3DCom: setRotation( rot )
	if self.shader then
		self.rotation = rot
		self.shader:setValue( "sElementRotation", math.rad( rot.x ), math.rad( rot.y ), math.rad( rot.z ))
	end
end

function CMat3DCom: setSize( siz )
	if self.shader then
		self.size = siz
		local sizMed = (siz.x + siz.y)/2
		self.depthBias = math.min(sizMed, 1)
		self.shader:setValue( "sElementSize", siz.x, siz.y )
		self.shader:setValue( "fDepthBias", self.depthBias )
	end
end

function CMat3DCom: setDepthBias( dBias )
	if self.shader then
		self.depthBias = dBias
		self.shader:setValue( "fDepthBias", self.depthBias )
	end
end

function CMat3DCom: setTexCoord( uvMul, uvPos )
	if self.shader then
		self.texCoord = { uvMul, uvPos }		
		self.shader:setValue( "uvMul", uvMul.x, uvMul.y )
		self.shader:setValue( "uvPos", uvPos.x, uvPos.y )
	end
end

function CMat3DCom: setBillboard( isBill )
	if self.shader then
		self.billboard = isBill
		self.shader:setValue( "sIsBillboard", self.billboard )
	end
end

function CMat3DCom: setColor( col )
	if self.shader then
		self.color = tocolor(col.x, col.y, col.z, col.w)
	end
end

function CMat3DCom: draw()
	if self.shader then
		-- draw the outcome
		dxDrawMaterialLine3D( 0 + self.position.x, 0 + self.position.y, self.position.z + 0.5, 0 + self.position.x, 0 + self.position.y, 
			self.position.z - 0.5, self.shader, 1, self.color, 0 + self.position.x,1 +  self.position.y,0 + self.position.z )	
	end
end
        
function CMat3DCom: destroy()
	if self.shader then
		destroyElement( self.shader )
	end
	self = nil
end
