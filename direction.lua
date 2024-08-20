local abs = math.abs
local vector3 = require("vector3")

-- xz 平面
local matrixXZ = 
{
    vector3:new(1, 0, 0), -- x轴
    vector3:new(0, 0, 0), -- y轴
    vector3:new(0, 0, 1), -- z轴
}
-- xy平面
local matrixXY = 
{
    vector3:new(1, 0, 0), -- x轴
    vector3:new(0, 1, 0), -- y轴
    vector3:new(0, 0, 0), -- z轴
}

local EDirection = 
{
    none = 0,
    right = 1, 
    rightup = 2,
    up = 3,
    leftup = 4,
    left = 5,
    leftdown = 6,
    down = 7,
    rightdown = 8,
}

local useXY = false
local epsilon = 0.01

local _M = {}

local function mul_matrix(matrix, vector)
    return vector3:new(
        matrix[1].x * vector.x + matrix[2].x * vector.y + matrix[3].x * vector.z,
        matrix[1].y * vector.x + matrix[2].y * vector.y + matrix[3].y * vector.z,
        matrix[1].z * vector.x + matrix[2].z * vector.y + matrix[3].z * vector.z
    )
end

function _M.get_direction(v_normalized, view_forward, view_right)
    local m = useXY and matrixXY or matrixXZ
    local view_forward_2d = mul_matrix(m, view_forward):normalized()
    local view_right_2d = mul_matrix(m, view_right):normalized()

    local f = vector3.dot(view_forward_2d, v_normalized)
    local r = vector3.dot(view_right_2d, v_normalized)

    if abs(r - 1) < epsilon    then return EDirection.right end
    if abs(r - (-1)) < epsilon then return EDirection.left end
    if abs(f - 1) < epsilon    then return EDirection.up end
    if abs(f - (-1)) < epsilon then return EDirection.down end

    if r > 0 and f > 0 then return EDirection.rightup end
    if r > 0 and f < 0 then return EDirection.rightdown end
    if r < 0 and f > 0 then return EDirection.leftup end
    if r < 0 and f < 0 then return EDirection.leftdown end
    return EDirection.none
end


return _M