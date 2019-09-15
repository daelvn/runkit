package = "runkit"
version = "2.0-1"
description = {
  summary = "A better version of lrunkit, for running commands in Lua easily.",
  homepage = "https://github.com/daelvn/runkit",
}
source = {
  url = "git://github.com/daelvn/runkit",
  tag = "v2.0",
}
build = {
  type = "none",
  copy_directories = { "docs",  },
  install = {
    lua = { ["runkit"] = "runkit.lua", },
  }
}
