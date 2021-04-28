TEST [[
---@class <!A!>
---@class B : <?A?>
]]

TEST [[
---@class <!A!>
---@type B|<?A?>
]]

TEST [[
---@class Class
local <?<!t!>?>
---@type Class
local x
]]

TEST [[
---@class Class
local <!t!>
---@type Class
local <?<!x!>?>
]]

TEST [[
---@class A
local mt = {}
function mt:<!cast!>()
end

---@type A
local obj
obj:<?cast?>()
]]

TEST [[
---@class A
local <!mt!> = {}
function mt:cast()
end

---@type A
local <!obj!>
<?obj?>:cast()
]]

TEST [[
---@type A
local <?<!obj!>?>

---@class A
local <!mt!>
]]

TEST [[
---@type A
local obj
obj:<?func?>()

---@class A
local mt
function mt:<!func!>()
end
]]

TEST [[
---@type A
local obj
obj:<?func?>()

local mt = {}
mt.__index = mt
function mt:<!func!>()
end
---@class A
local obj = setmetatable({}, mt)
]]

TEST [[
---@alias <!B!> A
---@type <?B?>
]]

TEST [[
---@class <!Class!>
---@param a <?Class?>
]]

TEST [[
---@type <!fun():void!>
local <?<!f!>?>
]]

TEST [[
---@param f <!fun():void!>
function t(<?<!f!>?>) end
]]

TEST [[
---@vararg <!fun():void!>
function f(<?...?>) end
]]

TEST [[
---@overload fun(y: boolean)
---@param x number
---@param y boolean
---@param z string
function <!f!>(x, y, z) end

print(<?f?>)
]]

TEST [[
local function f()
    return 1
end

---@class Class
local <!mt!>

---@type Class
local <?<!x!>?> = f()
]]

TEST [[
---@class Class
---@field <!name!> string
---@field id integer
local mt = {}
mt.<?name?>
]]

TEST [[
---@alias <!A!> string

---@type <?A?>
]]

TEST [[
---@class X
---@field <!a!> string

---@class Y:X

---@type Y
local y
y.<?a?>
]]

TEST [[
---@class <!loli!>
local <!unit!>

function unit:pants()
end

---@see <?loli?>
]]

TEST [[
---@class loli
local unit

function unit:<!pants!>()
end

---@see loli#<?pants?>
]]

TEST [[
---@class AAAA
---@field a AAAA
AAAA = {};

function AAAA:<!SSDF!>()
    
end

AAAA.a.<?SSDF?>
]]

TEST [[
---@class Cat
local <!m!> ---hahaha
---@class Dog
local 	m2
---@type Cat
local <?<!v!>?>
]]

TEST [[
---@class Cat
local <!m!> --hahaha
---@class Dog
local 	m2
---@type Cat
local <?<!v!>?>
]]

TEST [[
---@class Cat
 local <!m!> ---hahaha

  ---@class Dog
   local 	m2
	 ---@type Cat
	 	 local <?<!v!>?>
]]

TEST [[
---@return <!fun()!>
local function f() end

local <?<!r!>?> = f()
]]

TEST [[
---@generic T
---@param p T
---@return T
local function f(p) end

local <!k!>
local <?<!r!>?> = f(k)
]]

TEST [[
---@class Foo
local Foo = {}
function Foo:<!bar1!>() end

---@generic T
---@param arg1 T
---@return T
function Generic(arg1) print(arg1) end

local v1 = Generic(Foo)
print(v1.<?bar1?>)
]]

TEST [[
---@class Foo
local Foo = {}
function Foo:bar1() end

---@generic T
---@param arg1 T
---@return T
function Generic(arg1) print(arg1) end

local v1 = Generic("Foo")
print(v1.<?bar1?>)
]]

TEST [[
---@class Foo
local Foo = {}
function Foo:bar1() end

---@generic T
---@param arg1 `T`
---@return T
function Generic(arg1) print(arg1) end

local v1 = Generic(Foo)
print(v1.<?bar1?>)
]]

TEST [[
---@class Foo
local Foo = {}
function Foo:<!bar1!>() end

---@generic T
---@param arg1 `T`
---@return T
function Generic(arg1) print(arg1) end

local v1 = Generic("Foo")
print(v1.<?bar1?>)
]]

TEST [[
---@class Foo
local Foo = {}
function Foo:<!bar1!>() end

---@type table<number, Foo>
local v1
print(v1[1].<?bar1?>)
]]

TEST [[
---@class Foo
local Foo = {}
function Foo:<!bar1!>() end

---@class Foo2
local Foo2 = {}
function Foo2:bar1() end

---@type Foo2<number, Foo>
local v1
print(v1[1].<?bar1?>)
]]

--TODO 得扩展 simple 的信息才能识别这种情况了
--TEST [[
-----@class Foo
--local Foo = {}
--function Foo:bar1() end
--
-----@class Foo2
--local Foo2 = {}
--function Foo2:<!bar1!>() end
--
-----@type Foo2<number, Foo>
--local v1
--print(v1.<?bar1?>)
--]]

TEST [[
---@type fun():<!fun()!>
local f

local <?<!f2!>?> = f()
]]

TEST [[
---@generic T
---@param x T
---@return fun():T
local function f(x) end

local v1 = f(<!{}!>)
local <?<!v2!>?> = v1()
]]

TEST [[
---@generic V
---@return fun(x: V):V
local function f(x) end

local v1 = f()
local <?<!v2!>?> = v1(<!{}!>)
]]

TEST [[
---@class Foo
local Foo = {}
function Foo:<!bar1!>() end

---@type table<number, Foo>
local v1

---@generic T: table, V
---@param t T
---@return fun(table: V[], i?: integer):integer, V
---@return T
---@return integer i
local function ipairs(t) end

for i, v in ipairs(v1) do
    print(v.<?bar1?>)
end
]]

TEST [[
---@class Foo
local Foo = {}
function Foo:<!bar1!>() end

---@type table<Foo, Foo>
local v1

---@generic T: table, K, V
---@param t T
---@return fun(table: table<K, V>, index: K):K, V
---@return T
---@return nil
local function pairs(t) end

for k, v in pairs(v1) do
    print(k.<?bar1?>)
    print(v.bar1)
end
]]

TEST [[
---@class Foo
local Foo = {}
function Foo:<!bar1!>() end

---@type table<number, table<number, Foo>>
local v1
for i, v in ipairs(v1) do
    local v2 = v[1]
    print(v2.<?bar1?>)
end
]]

TEST [[
---@class Foo
local Foo = {}
function Foo:<!bar1!>() end

---@type table<number, table<number, Foo>>
local v1
print(v1[1][1].<?bar1?>)
]]

TEST [[
---@class X

---@class Y
---@field <!a!> string

---@class Z:X, Y

---@type Z
local z
z.<?a?>
]]
