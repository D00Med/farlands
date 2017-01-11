Witchcraft by D00Med
Some notes:
>farming_redo is required for the mod even though this is not shown in depends.txt
>mobs_redo is optionally required for the mod, but since pmobs requires it, it is assumed that if you have pmobs then you have mobs.
>Some potions are dangerous!

Some crafting recipes:

herbs(shapeless):
weed or groundfungus or bush

jar of eyes:
eye, X, X
eye, X. X
drinking glass, X, X

eyes(shapeless):
jar of eyes

magic cooking pot:
copper lump, X, copper lump
copper lump, X, copper lump
X, copper lump, X

the magic cooking pot cooks its contents without fire, so there is no need to light a fire underneath.

potion shelf:
wood, wood, wood
potion, potion, potion
wood, wood, wood

empty scroll:
paper, diamond, paper
paper, paper, paper

Need some slime? try scraping it out of an empty cauldron with a drinking glass.

Potion ingredients(may be slightly inaccurate):
>herbs
>jar of eyes
>diamond
>apple
>gold lumps
>mese crystal fragment
>obsidian shard
>jar of slime
>curlyfruit
>mushroom(moreplants)
>red mushroom(flowers)
>grass
>umbrella plant
>glass
>glass fragments
>flint
>tnt
>copper block
>steel block
>steel ingot
>lilypad
>dirt
>sand
>gravel
>bucket of water
>bullrush
>bones

About the recipes:

init.lua contains the pot recipes. For each pot there is a line similar to the one below, in the 'witchraft.pot' table.

{"blue", "brown", "default:dirt", "blue2", "moreplants:bullrush", "red", "purple"},
{"potion name", "result1", "ingredient1", "result2", "ingredient2", "combine potion", "combine result"}

The first column of the table("blue"), is the color of the current potion pot. In the example, it is the blue pot, so the ingredients and results in the other columns
will apply to the blue pot, ie: the blue pot must be rightclicked. It is important that the name of the pot is in the name of it's texture, eg: a blue pot has the texture "witchraft_pot_blue.png"

The second and fourth columns are the two possible results after adding new ingredients. The last column is the result after combining the current potion with another.

The third and fifth columns are the ingredients required. The ingredient req. to make the potion in column 2 must be in column 3, and the ingredient req. to make the potion in columns 4 must be in columns 5.
The 6th column is the potion that can be combined with the current potion to make a new potion.