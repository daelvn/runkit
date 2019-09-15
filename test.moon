import command, capture, interact, popenC, readC, readAllC, writeC, closeC, SILENCE from require "runkit"

ct  = 0
new = ->
  ct += 1
  print ct

new!
cat = command "cat"
cat "test.txt"

new!
cat = command "cat $file"
cat file: "test.txt"

new!
cat file: "test.txt", "test.txt"

new!
cat = command "cat", SILENCE
cat "test.txt"

new!
cat = capture "cat"
print cat "test.txt"

new!
cat = interact "cat"
res = cat "test.txt"
popenC res
print readAllC res
closeC res
