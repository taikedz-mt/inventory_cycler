# Inventory cycle for Minetest

Item to cycle through rows of inventory

Cycles rows of inventory upwards/downwards into the top row - access different lines of your inventory without opening the inventory screen!

## Item

The inventory cycling tool ("iCycler") can be made by combining three block types, in a diagonal pattern:

```
t = group:tree - any tree trunk
a = group:sand - any sand
o = group:stone - any stone 

[t] [ ] [ ]
[ ] [a] [ ]
[ ] [ ] [o]
```

## Use

* The item must be in active inventory slot 1, the leftmost slot
* Left-click move rows upward.
    * The active (top) row becomes the bottom row, and each other row is moved up
    * Items in slot 1 of each row do not get moved
* Right-click to move rows downward
* Hold `E` to cycle continuously through rows continuously
    * By default, every 0.7 second
    * configurable period through `/icycle period <N>`

