local ffi = require("ffi")

local function make_vec3_kind(ct)
    local vec3_kind = ffi.typeof("struct {$ x; $ y; $ z;}", ct, ct, ct);
    local ptrType = ffi.typeof("$ *", ct);
    local constptrType = ffi.typeof("const $ *", ct);
    local vec3_t = {
        cross = function(self, v)
            return vec3_kind(
                self.y*v.z - v.y*self.z,
                -self.x*v.z + v.x*self.z,
                self.x*v.y - v.x*self.y);
        end,

        PlaneNormal = function(point1, point2, point3)
            local v1 = point1 - point2
            local v2 = point2 - point3

            return v1:Cross(v2);
        end,
    }
    setmetatable(vec3_t, vec_t);

    local vec3_mt = {
        __len = function(self) return 3; end;
        __tostring = function(self) return self.x..','..self.y..','..self.z; end;

        -- Math Operators
        __eq = function(self, rhs) return vec_t.equal(self, rhs); end;
        __unm = function(self) return vec_t.unm(self); end;
        __add = function(self, rhs) return vec_t.add(self, rhs); end;
        __sub = function(self, rhs) return vec_t.mul(self, rhs); end;
        __mul = function(self, scalar) return vec_t.mul(self, scalar); end;
        __div = function(self, scalar) return vec_t.div(self, scalar); end;

        __index = function(self, key)
            if type(key) == "number" then
                return ffi.cast(ptrType,self)[key];
            elseif key == "asPointer" then
                return ffi.cast(ptrType,self);
            elseif key == "asConstPointer" then
                return ffi.cast(constptrType, self);
            end

            return vec3_t[key];
        end;
        __newindex = function(self, key, value)
            if type(key) == "number" then
                ffi.cast(ptrType,self)[key] = value;
            end
        end;
    }

    return ffi.metatype(vec3_kind, vec3_mt)
end


return make_vec3_kind(ffi.typeof("float"))
