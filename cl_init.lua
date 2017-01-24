--Place this inside every folder and name it cl_init.lua
include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end