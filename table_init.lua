--Place this inside the Tables folder and name it init.lua
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/furnitureStove001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
	local phys = self:GetPhysicsObject()
	
	if phys:IsValid() then
		phys:Wake()
	end
	self.isBaking = false
	self.finishBakeTime = 0
	
	self.hasDough = false
	self.hasTomato = false
	self.hasCheese = false
end

function ENT:StartTouch(ent)
	if ent:GetClass() == "dough" and self.hasDough == false and self.isBaking == false then
		ent:Remove()
		self.hasDough = true
	end
	
	if ent:GetClass() == "tomato" and self.hasTomato == false and self.isBaking == false then
		ent:Remove()
		self.hasTomato = true
	end
	
	if ent:GetClass() == "cheese" and self.hasCheese == false and self.isBaking == false then
		ent:Remove()
		self.hasCheese = true
	end
	
	if self.hasDough == true and self.hasTomato == true and self.hasCheese == true then
		self.isBaking = true
		self.finishBakeTime = CurTime() + 5
	end
end

function ENT:Think()
	if self.isBaking == true then
		self:SetColor(Color(255,0,0))
	else
		self:SetColor(Color(0,255,0))
	end
	
	if self.isBaking == true then
		if self.finishBakeTime <= CurTime() then
			self.isBaking = false
			self.hasDough = false
			self.hasTomato = false
			self.hasCheese = false
			
			local pizza = ents.Create("pizza")
			pizza:SetPos(self:GetPos() + Vector(0,0,50))
			pizza:Spawn()
		end
	end
end