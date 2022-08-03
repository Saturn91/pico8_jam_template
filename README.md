# Pico 8 Game for GMTK 2022 Jam on itch

To run the project using VS Code: launch.json has everything setup so you can just click on RUN/Startdebugging in VS code to get pico8 running your card.

# Lua Test Frame work

The Lua test framework is not able to run function within a .p8 file, you have to copy them into the tested_code.lua file and test then (and eventually move it back into your .p8 file once it works as expected... keep uptodate!)

1. Edit the test in test/test.lua and test/tested_code.lua

2. make sure a Lua interpetor is installed so you can run .lua files from your terminal or commandline.

5. run ```lua main.lua``` within the test folder - to test

## API
The api is keept really simple, use t.assert_equal(a, b, "a has to equal b").

a and b are the two objects / variables or function outputs you whish to compare, the third (and optional) parameter is a description. The result will look like this for passed tests:

```
...>lua ./lib/main.lua         


-----Test starts-----
[info]: test succeded: 4/4 passed
```

And like this for failed tests

```
...>lua ./lib/main.lua


-----Test starts-----
--> [error]: test sort failed -> 1,2,3,4, != 1,2,3,3,
--> [error]: 1/3 tests failed!
```