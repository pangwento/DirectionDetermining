local direction = require("direction")
local vector3 = require("vector3")

local vXZ = 
{
    vector3:new(1, 0, 0),
    vector3:new(0.5, 0, 0.5),
    vector3:new(0, 0, 1),
    vector3:new(-0.5, 0, 0.5),
    vector3:new(-1,0, 0),
    vector3:new(-0.5, 0, -0.5),
    vector3:new(0,0, -1),
    vector3:new(0.5, 0, -0.5)
}

local view_forward = vector3:new(-0.61, -0.5, 0.61)
local view_right = vector3:new(0.71, 0, 0.71)

local function test()
    local result = {}
    for i, v in ipairs(vXZ) do
        result[i] = direction.get_direction(v:normalized(), view_forward, view_right)
    end
    return result
end

local result = test()
for _, v in ipairs(result) do
    print(v)
end