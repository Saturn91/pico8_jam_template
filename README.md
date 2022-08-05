# Pico 8 Template for Pico8 game james (and all other kind of pico8 projects) using vs studio code das an IDE
This is my personal template to have a starting point for pico8 game jams.
It is tested for windows and I am pretty sure it only works on windows due to the commands used in the .vscode/launch.json folder.

## what this template provides
- a template to structure your github project
- run your edited card easily from vs studio code
- on web builds: remap controls (perfect for game jams as everyone complains that the default controls for pico8 are weird)
- [optional->see requirements] simplified lua testing framework to test lua functions without starting Pico8

## requirements
- basic knowledge of git / github -> very usefull tools every dev should have a look at - yes you aswell ;-).
- installed personal Pico8 on your OS (this is not a replacement, only a vs code setup to make things easier)
- installed visual studio code (get it [here](https://code.visualstudio.com/download))
- [optional] if you want to use the test framework, you have to install a local Lua runtime get it [here](http://luabinaries.sourceforge.net/download.html)

# Get started
Once you meet all the requirements
1. Use the `Use this template` button on top of this repo, to create your own repo for a new game
2. On your Pico8 dev machine clone the github repo you just created
3. Open the folder with the name of your created repository in vs code with `file/open folder`
4. Select game.p8 and hit `F5` to see the magic happen

# Run your card from VS code

launch.json has everything setup.
1. Select game.p8 to show up in the tab 
2. click on RUN/Startdebugging (or use the shortcut `F5`) to get pico8 running your card.

# Build your game 

1. run the card as already described
2. hit ESC to exit the game
3. in the Pico8 cmd enter "export index.html" (for the web build)
4. go to your pico8's cards folder (i.e. `C:\Users\YOUR_USER_NAME\AppData\Roaming\pico-8\carts`) there you have your build -> copy index.html and index.js
5. for a jam: either zip those two files into i.e. webbuild.zip and upload it to itch.io 
6. OR add the optional posibility to remap the controls as specified in the next section (web builds only)

# Remapping Pico 8 controls in the web build
For this I use [this open source project here](https://github.com/codl/pico-nfig) which is not mine ;-).
To allow users to remap the default pico8 keys do the following:

1. build your game as described in the last section
2. get the files from the [pico8 local folder](C:\Users\manue\AppData\Roaming\pico-8\carts)
3. paste them into a folder called webbuild
4. copy the nfig.js from this repo, or download it [here](https://github.com/codl/pico-nfig/blob/master/lib/nfig.js) and paste it aside the index.html and the index.js
5. your folder structure looks now like this:
```
webbuild
 |-index.html
 |-index.js
 |-nfig.js
```
6. in the index.html file replace the bottom section bellow ```<!-- Add content below the cart here -->``` with the following magic code:
```html
<!-- allow remaping of player controls -->
<button onclick="nfig_toggle()" style="width: 200px; height: 50px; background-color: rgb(255, 153, 0); border: none; color: white; font-size: 20px; cursor: pointer; margin-top: -100px;">remap controls</button>

</div> <!-- body_0 -->
</body></html>
<script src="./nfig.js" type='text/javascript'></script>
```
7. zip your folder as `webbuild.zip` containing the 3 files above directly, no subfolder)
8. upload to itch.io

# Lua Test Frame work
## Before you use
1. You can only test general Lua code and no pico8 specific functions like rect, spr and so on...
2. You will have to copy functions from the .p8 file into the test/tested_code.lua file in order to test them... - and if you do test driven development - copy them back after doing some adjustments... 
4. I know this is tedious! Maybe I find a better solution in the future, I am open for suggestions!

## Setup a Test

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
