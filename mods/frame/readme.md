
frame
=====

This minetest mod adds a lag-free, simple and stylish item and node
frame to minetest. It can contain either nodes or craftitems.

The player can place these frames in any orientation, just like normal
nodes. Then, with an item or node in hand, the player can place the
item or node into the item frame. If the itemframe is punched, the
item or node is returned to the puncher.

The concept works through the use of object materials. The empty
frame node has the same model, but part of the mesh is transparent
and therefore not visible. If an item is inserted, the transparent
textures are replaced with the texture of the item or node, and thus
it looks like the node is inserted, while effectively the frame is
a single node without metadata.

There are no crafting recipes for each variant. The player can craft
a frame and potentially use `/giveme` to give filled versions of the
frame, but the creative inventory does not contain them as they are
easily filled already.

The model was made in blender from scratch by the author.

The texture of the frame itself was created from the itemframe texture
of the excellent Isabella II texture pack, which is Public Domain. The
texture has been reworked to allow for a more detailed texturing of
the frame model.

The frame mod has an API that can be used by other mods to create
new item/node-frame combinations. See api.md for usage information.

