--- A better version of [lrunkit](https://github.com/daelvn/lrunkit).
-- @author daelvn
-- @module runkit

format = (str, fmt) ->
  for k, v in pairs fmt do str = str\gsub "%$#{k}", "#{v}"
  str
clear  = (str) -> str\gsub "%$[a-zA-Z0-9]+", ""

-- Helper function to check that all arguments passed are strings
check = (f) -> (...) ->
  args = {...}
  for i, arg in ipairs args do assert ("string" == type arg), "argument ##{i} is not a string"
  f ...

formCommand = (cmd, argl) ->
  for arg in *argl
    switch type arg
      when "string", "number", "boolean"
        cmd ..= " #{arg}"
      when "table"
        cmd = format cmd, arg
      else
        error "runkit $ invalid type passed to the command"
  clear cmd

-- lrInstall = command "luarocks install $1 $2 $package $version"
-- lrInstall package: "rockwriter", "--keep"

is_windows = "\\" == package.config\sub 1,1
--- Makes a command silent for both Unix and Windows.
-- @tparam string cmd Command to be silenced.
silence = (cmd) -> cmd .. if is_windows then " >nul 2>nul" else " >/dev/null 2>/dev/null"

--- Runs a simple command, without capturing output. **Curried function.*
-- @tparam string cmd Command to be run.
-- @param ... Parameters to the command, may be tables (if using `$`) or strings.
-- @treturn boolean Whether the command ran successfully or not.
-- @treturn string Reason for exit ("exit" or "signal").
-- @treturn number|nil If the reason for exit is "signal, this contains the signal.
command = check (cmd) -> (...) ->
  cmd              = formCommand cmd, {...}
  ok, mode, signal = os.execute cmd
  return (ok or false), mode, signal

--- Runs a command and captures its output. **Curried function.**
-- This function uses `io.popen`, which may not be availiable in all platforms.
-- @tparam string cmd Command to be run.
-- @param ... Parameters to the command, may be tables (if using `$`) or strings.
-- @treturn string Result of the command.
capture = check (cmd) -> (...) ->
  cmd = formCommand cmd, {...}
  local result
  with io.popen cmd, "r"
    result = \read "*a"
    \close!
  result

--- Perform basic IO operations on a command. **Curried function.**
-- The command structure returned only contains one field, `command`, which contains the final command.
-- @tparam string cmd Command to be run.
-- @param ... Parameters to the command, may be tables (if using `$`) or strings.
-- @treturn Command Command structure.
interact = (cmd) -> (...) ->
  cmd = formCommand cmd, {...}
  { command: cmd }

--- Uses `io.popen` on the command.
-- @tparam Command self Command structure.
-- @tparam string mode Mode to open with `io.popen`.
popenC = (mode) => @handle = io.popen @command, mode

--- Reads from the open handle in a command.
-- @tparam Command self Command structure.
-- @tparam string format Format to read. Defaults to "r"
-- @treturn string Result.
readC = (format="r") =>
  if @rhandle
    return @rhandle\read format
  else
    return @handle and (@handle\read format) or error "handle does not exist"

--- Shortcut for `readC cmd, "*a"`
-- @tparam Command self Command structure.
-- @treturn string Whole results of the command.
readAllC = => @handle and (@handle\read "*a") or error "handle does not exist"

--- Writes to the command.
-- @tparam Command self Command structure.
-- @tparam string str Contents to be written.
writeC = (str) => @handle and (@handle\write str) or error "handle does not exist"

--- Closes the command.
-- @tparam Command self Command structure.
closeC = =>
  @rhandle\close! if @rhandle
  @handle and @handle\close! or error "handle does not exist"

{ :silence, :command, :capture, :interact, :popenC, :readC, :readAllC, :writeC, :closeC }
