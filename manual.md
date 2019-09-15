# runkit Manual

## Introduction

`runkit` is a better version of the older [lrunkit](https://github.com/daelvn/lrunkit), and both are design to make command execution from Lua and MoonScript much easier. This allows you to make "bindings" to command-line programs to use them in Lua.

## Command formation

All commands passed to `runkit` functions have a specific syntax for you to format them, and take arguments in a specific
way.

`runkit` functions are curried, the first takes a command, and the second takes any amount of arguments to call the command with.

### Variables

You can specify a named variable such as `$package`, and if you pass a table which contains the key `package`, it will be replaced.

### Simple arguments

Passing a simple arguments just concatenates it.

### Lists

Passing a list of simple arguments concatenates them all.

### Last

You can make a list of items be appended right at the end of the command by setting `__list` to `true` for that list.

### Constants

You can pass the constant `SILENT` as an argument to make the command run silently, or `REDIRECT_STDERR` to capture stderr as well.
