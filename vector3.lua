local abs, sqrt = math.abs, math.sqrt
local class = require("middleclass")
local vector3 = class("vector3")

function vector3:initialize(_x, _y, _z)
    if type(_x) == "table" then
        local v = _x
        _x = v.x
        _y = v.y
        _z = v.z
    end
    self.x = _x or 0
    self.y = _y or 0
    self.z = _z or 0
end

function vector3:set(_x, _y, _z)
    if type(_x) == "table" then
        local v = _x
        _x = v.x
        _y = v.y
        _z = v.z
    end
    self.x = _x
    self.y = _y
    self.z = _z 
    return self
end

function vector3.zero()
    return vector3:new(0,0,0)
end

function vector3:add(v)
    self.x = self.x + v.x
    self.y = self.y + v.y
    self.z = self.z + v.z
    return self
end

function vector3:sub(v)
    self.x = self.x - v.x
    self.y = self.y - v.y
    self.z = self.z - v.z
    return self
end

function vector3:mul(num)
    self.x = self.x * num
    self.y = self.y * num
    self.z = self.z * num
    return self
end

function vector3:normalized()
    local num = self:magnitude()
    if num > 0.00001 then
        self.x = self.x/num
        self.y = self.y/num
        self.z = self.z/num
    else
        self.x = 0
        self.y = 0
        self.z = 0
    end
    return self
end

function vector3:normalize()
    local num = self:magnitude()
    if num > 0.00001 then
        return vector3:new(self.x/num, self.y/num, self.z/num)
    end
    return vector3.zero()
end

function vector3:magnitude()
    return sqrt(self.x*self.x + self.y*self.y + self.z*self.z)
end

function vector3.dot(lhs, rhs)
    return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z
end

return vector3