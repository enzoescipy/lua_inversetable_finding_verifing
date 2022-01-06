LENGTH = 100000
TIME = 0


-- ready to testing
local testTable = {}

math.randomseed(os.time())
local charset = {}

for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end

local function randomString(length)
    if length > 0 then
        return randomString(length - 1) .. charset[math.random(1, #charset)]
    else
        return ""
    end
end

for i=1,LENGTH do
    table.insert(testTable, randomString(100))
end

local function selectRandom(table)
    return table[math.random(1,LENGTH)]
end

local toFind = selectRandom(testTable)


TIME = os.clock()

local function diffTimer()
    Time = os.clock()
end

local function printDiff(value,num)
    print(num,":",value,(os.clock() - TIME) * 1000)
    TIME = os.clock()
end

--real code

diffTimer()
----typical lua code : less use of memory version
local testTableInv = {}
for i,v in ipairs(testTable) do
    testTableInv[v] = i
end
local result = testTableInv[toFind]
printDiff(result,1)

----typical lua code : less use of cpu version
diffTimer()
result = testTableInv[toFind]
printDiff(result,2)

----brute force algorithm, not using fixed memory, but cpu load is high.
diffTimer()
for i,v in ipairs(testTable) do
    if v == toFind then
        result = i
        break
    end
end
printDiff(result,3)

----
