# Pico 8 Template for game james

To run the project using VS Code: launch.json has everything setup so you can just click on RUN/Startdebugging in VS code to get pico8 running your card.

# Remapping Pico 8 controls in the web build
To allow users to remap the default pico8 keys do the following:

1. build the web version within pico: ```export index.html```
2. get the files from the [pico8 local folder](C:\Users\manue\AppData\Roaming\pico-8\carts)
2. in the index.html file replace the bottom section bellow ```<!-- Add content below the cart here -->``` with the following magic code:
```html
<!-- allow remaping of player controls -->
<button onclick="nfig_toggle()" style="width: 200px; height: 50px; background-color: rgb(255, 153, 0); border: none; color: white; font-size: 20px; cursor: pointer; margin-top: -25px;">remap controls</button>

</div> <!-- body_0 -->
</body></html>
<script src="https://cdn.jsdelivr.net/gh/codl/pico-nfig@1.0.1/lib/nfig.js" integrity="sha256-g5hO7r4Wj0Z51eaV73ATXK3yLGl7hqB30UN986DuCO0=" crossorigin="anonymous"></script>
```

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