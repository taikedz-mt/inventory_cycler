-- All file variabels local. Do not pollute the global space. Keep your environment clean!

local ifuncs = dofile(minetest.get_modpath("inventory_cycler").."lua/cycle.lua")

local items = dofile(minetest.get_modpath("inventory_cycler").."lua/items.lua")
items.initialize(ifuncs)

local aux1 = dofile(minetest.get_modpath("inventory_cycler").."lua/aux1.lua")
aux1.initialize(ifuncs)

