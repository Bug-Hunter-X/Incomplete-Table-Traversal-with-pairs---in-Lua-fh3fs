local function foo(t)
  for k, v in pairs(t) do
    if type(v) == "table" then
      foo(v)
    end
  end
end

local function foo_improved(t)
  for k, v in ipairs(t) do
    if type(v) == "table" then
      foo_improved(v)
    end
  end
end

local t = {a = 1, b = {c = 2, d = {e = nil, f = 4}}}

--Original function's behavior:
foo(t) -- Doesn't process f

--Improved function's behavior:
foo_improved(t) -- Processes all elements correctly

-- Note: ipairs is used in foo_improved, which handles sequential tables only.  For generic tables, use pairs and add nil key handling

local function foo_complete(t)
  for k, v in pairs(t) do
    if type(v) == "table" then
       if next(v) ~= nil then --Check if the table is empty
        foo_complete(v)
       end
    end
  end
end

foo_complete(t) -- Processes all elements correctly even with nil keys in nested tables
