# linux lua-lsp support

- consider a function to be a process that you can give information, and have it
  complete some task.

## sumneko/lua-language-server

this works mostly by installing coc-lua through coc.vim setup..
one exception to keep the server from crashing when editing lua files
inside a big project, this line needs to be modified from the defaults
which recursively parse all files in the current folder

"Lua.runtime.path": ["?.lua"],

for some reason editing files in ~/ does not work... must be due to some sort of
recursive resolution....

- string recipes
  http://lua-users.org/wiki/StringRecipes

- lua operators
  https://www.tutorialspoint.com/lua/lua_operators.htm

- quick primer
  https://www.youtube.com/watch?v=kgiEF1frHQ8

## interpreter

lua> x = 123
lua> = type(x)
number

## patterns

https://www.lua.org/pil/20.2.html

### lua character classes

. all characters
%a letters
%c control characters
%d digits
%l lower case letters
%p punctuation characters
%s space characters
%u upper case letters
%w alphanumeric characters
%x hexadecimal digits
%z the character with representation 0

`upper case letter represent the opposite of the class`

`e.g. %A means any none letters`

#### quantifiers

`+` 1 or more repetitions
`*` 0 or more repetitions
`-` also 0 or more repetitions (shortest occurrence)
`?` optional (0 or 1 occurrence)

#### operators

- lua operators explained

  https://www.tutorialspoint.com/lua/lua_operators.htm

`..` Concatenates two strings. a..b where a is "Hello " and b is "World", will
return "Hello World".

`#` An unary operator that return the length of the string or a table.
`#"Hello"` will return 5

#### character escaping

`%` can be used to escape special characters

`%%` makes escapes to a single `%` literal

## Comparison Operators

== equal
< less than

> greater than
> <= less than or equal to
> = greater than or equal to
> ~= inequality (not !=)

## combining statements and or, if else etc

```lua
if x > 1 or x < 20 then print(x) end
if x > 1 end x < 20 then print(x) end
if not x > 1 end x < 20 then print(x) end
print(20)

```

if x
elseif y
end

## range, tested loops

```lua
local count = 0

for i = 1, 10 do -- init i to 1, 10 is max range
  for e = 1, 10 do -- different variable
    count = count + 1 -- no += operator..
  end
end

print(count)
```

## tables

```lua
local colors = {"blue", "green", "red"}

for i = 1, #colors do -- #colors is length of colors
  print(colors[i])
end
```

## table manipulation

```lua
local colors = {"blue", "green", "red"}

table.insert(colors, "orange") -- add orange
table.remove(colors, "blue") -- remove blue
```

## first class functions

```lua
-- can be assigned to variables and passed to other functions

lua>fun = function(x) return x + 1 end
lua>local x = {}
lua>x[1] = print
lua>x[1]('hello')
hello

-- define local function, this is only visible in its local scope

local fun = function (x) return x * 20 end

```

## chaining commands

```lua
-- prints local variable since its on the same scope/line
local x = 63
print(64)
```

## variables (*global/local) *default

- assigments are global by default, use local to make them local

## shortest occurance example

```lua

x = '/*this this*/test /*test */1232 test'
-- this makes sure that only the first closing */ is matched correctly per group
print(x:gsub('/%*.-%*/', '<comment>'))

lua test.lua
<comment>test <comment>1232 test
```

#### kali linux support

- this is needed for kali linux lua lsp support

  sudo luarocks install dkjson
  sudo luarocks install lua-lsp

## lua reference

http://www.syntaxstation.com/lua.html

## method calls colon :

```lua
f:read()
```

## Lua starts counting at 1, not 0...

```lua
local tbl = {"a", "b", "c"}

for i = 1, #tbl do
  print(colors[i])
end
```

- break, continue - lua includes a **break** statement but not a continue
  statement

## data types

```lua
myNum = 100 --Number
myOtherNum = 20.18 --Number
myString = "Hello World!" --String
myBool = true --Boolean
```

## type checking

```lua
n = 5
assert(type(n) == "number")
-> true
```

## comments

```lua
-- Comment on a single line
--[[
     Block comments
     Everything in here will be
     treated as a comment
--]]
```

## conditionals

```lua
if myNum == 0 then
  myNum = myNum + 1
end

if myNum > 1 then
  result = "myNum is greater than 1"
elseif myNum < 1 then
  result = "myNum is less than 1"
else
  result = "myNum is equal to 1"
end
```

## loops

```lua
-- While Loop
while myNum < 50 do
  myNum = myNum + 1
end

-- For Loop
-- Loops 100 times, iterator "i" increases by 1 each loop
for i = 1, 100 do
  myNum = myNum + 1
end

-- Optional third parameter is the increment value
-- This loop decreases by 5 each time from 100 to 0
for i = 100, 0, -5 do
  myNum = myNum + 1
end

-- for loop include step
for i = 1, 100, 0.5 do
  print(i)
end
```

- repeat until

```lua
i = 1
repeat
  print(i)
  i = i + 1
until i == 10
```

## functions

```lua
function isNegative(n)
  if n < 0 then
    return true
  else
    return false
  end
end

isNegative(-15) -- Returns true

-- Multiple parameters
function pow(base, exp)
  return base ^ exp
end

-- Functions can be assigned to variables
myVar = isNegative
myVar(20) -- Returns false
```

## tables

- tables in lua are considered associative
- an associative table is a collection of values that are each associated with a
  key
- table keys cannot contain reserved names

```lua
test = {}
test.end = 'test' -- error
```

```lua
myTable = {} -- Creates empty table
myTable[1] = "a" -- Put character 'a' at index 1

-- NOTE: Tables in Lua start at index 1

myTable["lua"] = 20 -- myTable contains 20 at index "lua"
myTable[1] = nil -- Removes value stored at index 1

myTable.name = "Alex" -- myTable["name"] contains string "Alex"

otherTable = {2, 3, 5} -- Creates table with 2 stored at index 1,
-- 3 stored at index 2, and 5 at index 3

-- Iterate through all values in a table
for i, n in ipairs(otherTable) do
  result = result + n
  -- i stores the current index
  -- n stores the value at current index
end
-- During loop, variable "result" increases by 2, then 3, then 5.
```

### list/arrays are just tables with no key

```lua
tbl = { 1, 2, 3 }

show size of array

print(#tbl)
```

## dofile = loads and executes script

```lua
dofile("myfile.lua")
```

## iterating over tables

- ipairs() - use to iterate over an array(list)
- pairs() - use to iterate over a dict/hash table

## read from stdin

```lua
x = io.read()
-- reads from stdin
```

## writing modules using tables, similar to python class

```lua
local vec = {}

vec.norm = function(x, y)
  return math.sqrt(x * x + y * y)
end

vec.dist = function(x1, y1, x2, y2)
  return vec.norm(x1 - x2, y1 - y2)
end

return vec
```

## lua path / lua search path

- returns the lua search path

```lua
package.path
```

## error handling

```lua
assert(cond, 'error messsage here')

-- other way to handle it
function (x, y) error( 'this is an error msg' ) end

```

## open files/working with files

- open and write to file

```lua
-- open and write to file
f = io.open("filename.txt", "w")

-- writing to files

f:write("hello there \n")
f:close()
```

- open and read from file

```lua
f = io.open("filename.txt")

x = f:read()
print(x)
f:close()
```

## useful built in modules

```lua
io
math.random(1, 20)
math.pi()
str = 'pancakes'
string.sub(str, 4, 7 )
```

## method calls can be done with a : on any object

when calling a function with : "self" is inserted as the first parameter

```lua
t = {}
t.myval = 265
function t.f(self, x) print(self.myval) end
t:f()
265
-- same can be done with dot notation and passing t (table) as self
> t.f(t)
265
```

```lua
str = 'pancakes'
str:sub(1, 3)
-> pan

str = 'this is a test'
print(str:len())
-> 14
print(str:gsub('this', 'that'))
-> that is a test
```

## metatables

- setmetatable() first parameter is the table it self and also the return value
- second parameter is the metatable being set

```lua
meta = { a = 1 }
t = setmetatable({}, meta)

-- define a backup table for failed key lookups

backup = { mykey = 100 }
meta.__index = backup
t.mytest

nil
 t.mykey
100

```

## creating modules

```lua
-- Create an example file mymodule.lua with the following content:

local mymodule = {}

function mymodule.foo()
  print("Hello World!")
end

return mymodule

-- Now to use this new module in the interactive interpreter, just do:

> mymodule = require "mymodule"
> mymodule.foo()
Hello World!

-- Deep copy a table
local function table_copy(t)
  local copy = {}
  for n,v in pairs(t) do
    if type(v) == 'table' then
             v = table_copy(v)
    end
    copy[n] = v
  end
  return copy
end
```

## clearing tables

clear entry on table by assigning nil

```lua
test = {}
test.x = "test"
test.x = nil
```

## tables remove elements

remove last element from the table

```lua
table.remove()
```

## table sort

sorts in place

```lua
table.sort(tbl)
```

## name space / create module

```lua
mod = {}

function mod.factorial(num)
  local total = 1
  for i = 1, num do
    total = total * i
  end
  return total
end

return mod
```

## using tables for object oriented programming (OOP)

```lua
counter = {
  count = 0
}

function counter.get(self)
  return self.count
end

function counter.inc(self)
  self.count = self.count + 1
  return self.count
end
```

## create objects using tables

```lua
-- call using: x = new_counter()

-- inc and get need to be called with x:get() not x.get()
do
  local function get(self)
    return self.count
  end

  local function inc(self)
    self.count = self.count + 1
  end

  function new_counter(value)
    if type(value) ~= "number" then
      value = 0
    end
    local obj = {
      count = value,
      get = get,
      inc = inc
    }
    return obj
  end
end
-- using obj:get() makes automatically
-- passes self as the first argument

x = {}

function x:get()
  self.val = 9
  return self
end
```

Instead of typing counter.get(counter), you can call counter:get(). Lua
translates counter:get() into counter.get(counter), saving you a bit of typing
and making code easier to read.

## define functions using :

Defining Functions Using :
You can use the : operator to define functions, making this type of program- ming even more natural. When this happens, Lua includes an implicit first argument called self. That’s why you used the variable name self in the previous example.
Redefine the earlier functions by typing the following into your interpreter:

```lua
counter = {
  count = 0
}

function counter:get()
  return self.count
end

function counter:inc()
  self.count = self.count + 1
end
```

## factory functions page 68

return new objects when they are called

## Extending Tables with Metatables

- Each table in Lua is capable of having a metatable attached to it. A metatable
  is a secondary table that gives Lua extra information about how that table
  should be treated when it is used. For example, by default, when you try to
  print a table you are given as tring that looks something like table:
  0x30d470,which isn’t extremely readable.

## metamethods, are methods assinged to a metatable

- they begin with two `__` underscores, e.g. `__index and __newindex`

```
___add        - behavior when used in addition
___mul        - behavior when used in multiplication
___div        - behavior when used in division
___sub        - behavior when used in subtraction
___unm        - behavior when negated (unary minus).
___tostring   - argument to tostring(). This also affects the print() function, which calls tostring() directly.
___concat     - Defines the behavior when used with the concatenation operator (..)
___index      - Defines the behavior when the table is indexed with a key that doesn’t exist in that table.
___newindex   - Defines the behavior when a previously unset key in the table is being set.
```

```lua
-- tbl = regular table
-- mtable = metatable
tbl = {"a", "b", "c"}
mtable = {}
setmetable(tbl, mtable)
```

- setmetatble returns the table passed as the first argument

- getmetable(tbl) returns the metatable or nil

```lua
-- test to see if mt is set
print(getmetatable(tbl) == mt)
```

### `__tostring` metamethod

```lua
-- prints table to stdout, affects tostring and print functions
function mt.__tostring(tbl)
  -- mt = metatable
  local result = "{"

  for i = 1, #tbl do
    if i > 1 then
      result = result .. ", "
    end
    result = result .. tostring(tbl[i])
  end

  result = result .. "}"
  return result
end
```

### `__index` metamethod

Normally, when a table does not have a value associated with a given key, nil is
returned. That makes sense for run-of-the-mill tables, but at times it is more
appropriate to take other action instead. The index metamethod allows that to
happen, following this procedure:

1. Code tries to access an unassociated key in a table.

2. If the table has an
   index metatable entry that is another table, look
   up the same key in that table and return it (or nil if it doesn't exist).
   This may
   possibly trigger the `__index` metamethod of the second table,
   making a chain.

3. If the table has an
   index metatable entry that is a function, call the
   function with the table and the key as arguments, and return the result.
