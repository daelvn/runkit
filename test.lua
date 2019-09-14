local silence, command, capture, interact, popenC, readC, readAllC, writeC, closeC
do
  local _obj_0 = require("runkit")
  silence, command, capture, interact, popenC, readC, readAllC, writeC, closeC = _obj_0.silence, _obj_0.command, _obj_0.capture, _obj_0.interact, _obj_0.popenC, _obj_0.readC, _obj_0.readAllC, _obj_0.writeC, _obj_0.closeC
end
local ct = 0
local new
new = function()
  ct = ct + 1
  return print(ct)
end
new()
local cat = command("cat")
cat("test.txt")
new()
cat = command("cat $file")
cat({
  file = "test.txt"
})
new()
cat({
  file = "test.txt"
}, "test.txt")
new()
cat = command(silence("cat"))
cat("test.txt")
new()
cat = capture("cat")
print(cat("test.txt"))
new()
cat = interact("cat")
local res = cat("test.txt")
popenC(res)
print(readAllC(res))
return closeC(res)
