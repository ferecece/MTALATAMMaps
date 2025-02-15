--
-- file: c_primitive3D_ring_ap.lua
-- version: v1.5
-- author: Ren712
-- This class allows creation of transformed materialPrimitive3D 
--
-- include: fx/primitive3D_ring_ap.fx, c_common.lua

local scx,scy = guiGetScreenSize ()
    
CPrm3DRingAp = { }
CPrm3DRingAp.__index = CPrm3DRingAp
     
function CPrm3DRingAp: create( pos, rot, siz, color )
	local scX, scY = guiGetScreenSize()
	local cShader = {
		shader = nil,
		color = Vector4(color.x, color.y, color.z, color.w),
		texCoord = {Vector2(1, 1),Vector2(0, 0)},
		position = pos,
		rotation = rot,
		rotationSpeed = Vector3(0, 0, 0),
		size = siz,
		destBlend = 6, -- see D3DBLEND https://msdn.microsoft.com/en-us/library/windows/desktop/bb172508%28v=vs.85%29.aspx
		shape = Vector2(1.6, 0.3),
		distFade = Vector2(450, 400),
		flipVertex = false,
		fogEnable = true,
		cullMode = 1,
		clip = 450,
		tessellation = Vector2(24, 24)
	}

	cShader.shader = DxShader("primitive3D_ring_ap.fx")

	if cShader.shader then
		-- pass position and a forward vector to recreate gWorld matrix
		cShader.shader:setValue( "sElementRotation", math.rad( rot.x ), math.rad( rot.y ), math.rad( rot.z ))
		cShader.shader:setValue( "sLightRotationSpeed", cShader.rotationSpeed.x, cShader.rotationSpeed.y, cShader.rotationSpeed.z )
		cShader.shader:setValue( "sElementPosition", pos.x, pos.y, pos.z )
		cShader.shader:setValue( "sElementColor", cShader.color.x / 255, cShader.color.y / 255, cShader.color.z / 255, cShader.color.w/ 255 )
		cShader.shader:setValue( "sElementSize", siz.x, siz.y, siz.z )
		cShader.shader:setValue( "sElementShape", cShader.shape.x, cShader.shape.y )
		cShader.shader:setValue( "sFlipTexture", false )
		cShader.shader:setValue( "sFlipVertex", cShader.flipVertex )
		cShader.shader:setValue( "fDestBlend" ,cShader.destBlend )
		cShader.shader:setValue( "gDistFade", cShader.distFade.x, cShader.distFade.y )			
		cShader.shader:setValue( "uvMul", cShader.texCoord[1].x, cShader.texCoord[1].y )
		cShader.shader:setValue( "uvPos", cShader.texCoord[2].x, cShader.texCoord[2].y )
		
		cShader.trianglestrip = createPrimitiveQuadUV(cShader.tessellation)
	
		self.__index = self
		setmetatable( cShader, self )
		return cShader
	else
		return false
	end
end

function CPrm3DRingAp: setBlendAdd( isAddBlend )
	if self.shader then
		if isAddBlend then
			self.destBlend = 2
			self.shader:setValue( "fDestBlend" ,2 )
		else
			self.destBlend = 6
			self.shader:setValue( "fDestBlend" ,6 )
		end		
	end
end

function CPrm3DRingAp: setDistFade( distFade )
	if self.shader then
		self.distFade = distFade
		self.shader:setValue( "gDistFade", distFade.x, distFade.y )
	end
end

function CPrm3DRingAp: setClipDistance( clipDist )
	if self.shader then
		self.clip = clipDist
	end
end

function CPrm3DRingAp: setTexture( texture )
	-- for compatibility
end

function CPrm3DRingAp: setTessellation( div )
	if self.shader then
		self.tessellation = div
		self.trianglestrip =  createPrimitiveQuadUV(self.tessellation)
	end
end

function CPrm3DRingAp: setCullMode( cull )
	-- for compatibility
end

function CPrm3DRingAp: setFlipVertex( flip )
	if self.shader then
		self.flipVertex = flip
		self.shader:setValue( "sFlipVertex", flip )
	end
end

function CPrm3DRingAp: setPosition( pos )
	if self.shader then
		self.position = pos
		self.shader:setValue( "sElementPosition", pos.x, pos.y, pos.z )
	end
end

function CPrm3DRingAp: setFogEnable( isEnabled )
 -- for compatibility
end

-- rotation order "ZXY"
function CPrm3DRingAp: setRotation( rot )
	if self.shader then
		self.rotation = rot
		self.shader:setValue( "sElementRotation", math.rad( rot.x ), math.rad( rot.y ), math.rad( rot.z ))
	end
end

function CPrm3DRingAp: setDirection( fwVec )
	if self.shader then
		local rot = Vector3( math.deg( math.asin( fwVec.z / fwVec:getLength() )), 0, -math.deg( math.atan2( fwVec.x, fwVec.y )))
		self.rotation = rot
		self.shader:setValue( "sElementRotation", math.rad( rot.x ), math.rad( rot.y ), math.rad( rot.z ))
	end
end

function CPrm3DRingAp: setSize( siz )
	if self.shader then
		self.size = siz
		self.shader:setValue( "sElementSize", siz.x, siz.y, siz.z )
	end
end

function CPrm3DRingAp: setShape( shape )
	if self.shader then
		self.shape = shape
		self.shader:setValue( "sElementShape", shape.x, shape.y )
	end
end		
		
function CPrm3DRingAp: setTexCoord( uvMul, uvPos )
	if self.shader then
		self.texCoord = { uvMul, uvPos }		
		self.shader:setValue( "uvMul", uvMul.x, uvMul.y )
		self.shader:setValue( "uvPos", uvPos.x, uvPos.y )
	end
end

function CPrm3DRingAp: setBillboard( isBill )
	-- for compatibility
end

function CPrm3DRingAp: setColor( col )
	if self.shader then
		self.color = Vector4( col.x, col.y, col.z, col.w )
		self.shader:setValue( "sElementColor", col.x / 255, col.y / 255, col.z / 255, col.w / 255 )
	end
end

function CPrm3DRingAp: draw()
	if self.shader then
		if ( self.position - getCamera().matrix.position ).length < math.min( self.clip, getFarClipDistance() ) then			
			-- draw the outcome
			dxDrawMaterialPrimitive3D( "trianglestrip", self.shader, false, unpack( self.trianglestrip ) )
		end
	end
end
        
function CPrm3DRingAp: destroy()
	if self.shader then
		destroyElement( self.shader )
	end
	self = nil
end
