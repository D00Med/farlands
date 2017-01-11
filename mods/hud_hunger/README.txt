Modpack "Better HUD and hunger"
===============================
ModPack-Version: 2.x.1

Copyright (c) 2013-2016 BlockMen <blockmen2015@gmail.com>


About this mod:
~~~~~~~~~~~~~~~
This Modpack includes two mods, "Better HUD" (hud) and "Hunger"(hunger).

HUD:
The hud mod improves the HUD of Minetest and adds statbars for Hunger and Armor (hidden by default).
Also it provides an API to add new statbars easily, see API.txt for more informations.

Changes in builtin HUD items:
- Adds background for Health bar
- Uses better textures for Hotbar
- Uses texture for crosshair
- Positions of builtin statbars can be changed via "hud.conf" file
- Experimental "ItemWheel" that replaces the hotbar (must be enabled by adding "hud_item_wheel = true" in minetest.conf)

This mod supports the 3d_armor mod by stu (https://github.com/stujones11/minetest-3d_armor)


Hunger:
The hunger mod adds hunger mechanics to Minetest, which are based on player actions and on time.
Also it changes the eating in Minetest, e.g. an Apple does not restore Health, but it rises your saturation.
Example: 1 apple fills up the hunger bar by 1 "bread" (statbar symbol).
Although the statbar show 20 hunger points (10 breads) on the HUD you can fill it up to 30 points.

By default it supports a lot of food already (see full list below) and food that for registered via the API.
For more information how to register more food see API.txt



License:
~~~~~~~~
(c) Copyright BlockMen (2013-2016)


Code:
Licensed under the GNU LGPL version 2.1 or higher.
You can redistribute it and/or modify it under 
the terms of the GNU Lesser General Public License 
as published by the Free Software Foundation;

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

See LICENSE.txt and http://www.gnu.org/licenses/lgpl-2.1.txt


Textures:
see README.txt in each submodule


Github:
~~~~~~~
https://github.com/BlockMen/hud_hunger

Forum:
~~~~~~
https://forum.minetest.net/viewtopic.php?id=6342


Changelog:
~~~~~~~~~~
see changelog.txt in each submodule


Dependencies (hunger):
~~~~~~~~~~~~~
- default
- farming
- flowers
- hud


Supported food/mods:
~~~~~~~~~~~~~~~~~~~~
- Apples (default)
- Animalmaterials (mobf modpack)
- Bread (default)
- Bushes
- bushes_classic
- Creatures
- Dwarves (beer and such)
- Docfarming
- Ethereal
- Fishing
- Farming plus
- Farming (default and Farming Redo)
- Food
- fruit
- Glooptest
- JKMod
- kpgmobs
- Mobfcooking
- Mobs Redo
- Mooretrees
- Mtfoods
- mushroom
- mush45
- Seaplants (sea)
- Simple mobs
- Wine
