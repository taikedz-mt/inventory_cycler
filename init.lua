icycle = {name="icycle", version="0.1"}

ifuncs = dofile(minetest.get_modpath("icycle").."lua/cycle.lua")

items = dofile(minetest.get_modpath("icycle").."lua/items.lua")
items.initialize(ifuncs)

aux1 = dofile(minetest.get_modpath("icycle").."lua/aux1.lua")
aux1.initialize(ifuncs)

