Farming Redo Mod
by TenPlus1

https://forum.minetest.net/viewtopic.php?id=9019

Farming Redo is a simplified version of the built-in farming mod in minetest and comes with wheat, cotton, carrot, cucumber, potato and tomato to start out with which spawn throughout the map... new foods need only be planted on tilled soil so no seeds are required, original wheat and cotton will require seeds which are found inside normal and jungle grass...

This mod works by adding your new plant to the {growing=1} group and numbering the stages from _1 to as many stages as you like, but the underscore MUST be used only once in the node name to separate plant from stage number e.g.

"farming:cotton_1"      through to   "farming:cotton_8"
"farming:wheat_1"       through to   "farming:wheat_8"
"farming:cucumber_4"    through to   "farming:cucumber_4"

Changelog:

1.22 - Added grape bushes at high climates which can be cultivated into grape vines using trellis (9 sticks).
1.21 - Added auto-refill code for planting crops (thanks crabman77), also fixed a few bugs
1.20b- Tidied code, made api compatible with new 0.4.13 changes and changed to soil texture overlays
1.20 - NEW growing routine added that allows crops to grow while player is away doing other things (thanks prestidigitator)
1.14 - Added Green Beans from Crops mod (thanks sofar), little bushels in the wild but need to be grown using beanpoles crafted with 4 sticks (2 either side)
1.13 - Fixed seed double-placement glitch.  Mapgen now uses 0.4.12+ for plant generation
1.12 - Player cannot place seeds in protected area, also growing speeds changed to match defaults
1.11 - Added Straw Bale, streamlined growing abm a little, fixed melon rotation bug with screwdriver
1.10 - Added Blueberry Bush and Blueberry Muffins, also Pumpkin/Melon easier to pick up, added check for unloaded map
1.09 - Corn now uses single nodes instead of 1 ontop of the other, Ethanol recipe is more expensive (requires 5 corn) and some code cleanup.
1.08 - Added Farming Plus compatibility, plus can be removed and no more missing nodes
1.07 - Added Rhubarb and Rhubarb Pie
1.06 - register_hoe and register_plant added for compatibility with default farming mod, although any plants registered will use farming redo to grow
1.05 - Added Raspberry Bushels and Raspberry Smoothie
1.04 - Added Donuts... normal, chocolate and apple... and a few code cleanups and now compatible with jungletree's from MoreTrees mod
1.03 - Bug fixes and more compatibility as drop-in replacement for built-in farming mod
1.02 - Added farming.mod string to help other mods identify which farming mod is running, if it returns "redo" then you're using this one, "" empty is built-in mod
1.01 - Crafting coffee or ethanol returns empty bucket/bottle, also Cocoa spawns a little rarer
1.0 - Added Cocoa which randomly grows on jungle tree's, pods give cocoa beans which can be used to farm more pods on a jungle trunk or make Cookies which have been added (or other treats)
0.9 - Added Pumpkin, Jack 'O Lantern, Pumpkin Slice and Sugar
(a huge thanks to painterly.net for allowing me to use their textures)
0.8 - Added Watermelon and Melon Slice
0.7 - Added Coffee, Coffee Beans, Drinking Cup, Cold and Hot Cup of Coffee
0.6 - Added Corn, Corn on the Cob... Also reworked Abm
0.5 - Added Carrot, Cucumber, Potato (and Baked Potato), Tomato
0.4 - Checks for Protection, also performance changes
0.3 - Added Diamond and Mese hoe
0.2 - Fixed check for wet soil
0.1 - Fixed growing bug
0.0 - Initial release

License of media (textures):
----------------------------
Created by PilzAdam (License: WTFPL):
  farming_bread.png
  farming_soil.png
  farming_soil_wet.png
  farming_soil_wet_side.png
  farming_string.png

Created by Calinou (License: CC BY-SA):
  farming_tool_bronzehoe.png
  farming_tool_steelhoe.png
  farming_tool_stonehoe.png
  farming_tool_woodhoe.png
  farming_tool_mesehoe.png
  farming_tool_diamondhoe.png

Created by VanessaE (License: WTFPL):
  farming_cotton_seed.png
  farming_wheat_seed.png
  farming_flour.png
  farming_wheat.png
  farming_wheat_1.png
  farming_wheat_2.png
  farming_wheat_3.png
  farming_wheat_4.png
  farming_wheat_5.png
  farming_wheat_5.png
  farming_wheat_7.png
  farming_wheat_8.png
  farming_cotton_1.png
  farming_cotton_2.png
  farming_cotton_3.png
  farming_cotton_4.png
  farming_cotton_5.png
  farming_cotton_6.png
  farming_cotton_7.png
  farming_cotton_8.png

Created by Doc (License: WTFPL):
  farming_cucumber.png
  farming_cucumber_1.png
  farming_cucumber_2.png
  farming_cucumber_3.png
  farming_cucumber_4.png
  farming_potato.png
  farming_potato_1.png
  farming_potato_2.png
  farming_potato_3.png
  farming_potato_4.png
  farming_raspberries.png
  farming_raspberry_1.png
  farming_raspberry_2.png
  farming_raspberry_3.png
  farming_raspberry_4.png

Created by Gambit:
  default_junglegrass.png
  farming_carrot.png
  farming_carrot_1.png
  farming_carrot_2.png
  farming_carrot_3.png
  farming_carrot_4.png
  farming_carrot_5.png
  farming_carrot_6.png
  farming_carrot_7.png
  farming_carrot_8.png

Created by JoseTheCrafter and edited by TenPlus1:
  farming_tomato.png
  farming_tomato_1.png
  farming_tomato_2.png
  farming_tomato_3.png
  farming_tomato_4.png
  farming_tomato_5.png
  farming_tomato_6.png
  farming_tomato_7.png
  farming_tomato_8.png

Created by GeMinecraft and edited by TenPlus1:
  farming_corn.png
  farming_corn_cob.png
  farming_corn_1.png
  farming_corn_2.png
  farming_corn_3.png
  farming_corn_4.png
  farming_corn_5.png
  farming_corn_6.png
  farming_corn_7.png
  farming_corn_8.png

Created by TenPlus1
  farming_cocoa_1.png
  farming_cocoa_2.png
  farming_cocoa_3.png
  farming_cocoa_beans.png
  farming_cookie.png
  farming_raspberry_smoothie.png
  farming_rhubarb_1.png
  farming_rhubarb_2.png
  farming_rhubarb_3.png
  farming_rhubarb.png
  farming_rhubarb_pie.png