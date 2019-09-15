local command, capture, interact, popenC, readC, readAllC, writeC, closeC, SILENCE
do
  local _obj_0 = require("runkit")
  command, capture, interact, popenC, readC, readAllC, writeC, closeC, SILENCE = _obj_0.command, _obj_0.capture, _obj_0.interact, _obj_0.popenC, _obj_0.readC, _obj_0.readAllC, _obj_0.writeC, _obj_0.closeC, _obj_0.SILENCE
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
cat = command("cat", SILENCE)
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
