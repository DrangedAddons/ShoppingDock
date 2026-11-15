# ShoppingDock

A WoW Forever addon (interface 16001) that docks a panel to the auction house's right edge and works through any [Auctionator](https://www.curseforge.com/wow/addons/auctionator) shopping list one item at a time:

- opens with the auction house window when the list you're on has things left to buy; closed, it folds into a **Shopping List ▸** button in the AH window's title bar, left of the close button, shown while there's at least one shopping list and pressed in while the dock is open (click it again to close the dock). The number on it is how many items are left.
- searches the AH for the current item and shows what buying the rest costs now, against what the list expected
- **Buy**: a commodity is bought in one purchase for the whole amount (two clicks, Buy now then Confirm at the AH's exact price); a separate auction is bought one stack at a time
- **The plan**: every item on the list with what it's expected to cost (or costs now, after a rescan). Click a row to buy that item next.
- an amount box to buy more or fewer than the list says, **Skip**, and **Forget list** (after asking, deletes the list: from the dock with its progress, and from Auctionator's shopping lists)
- click the list name to pick any shopping list from a dropdown, grouped by the addon that made it; the dock opens on its own at the AH when the current list has things left to buy
- **Rescan item** searches the current item again; **Rescan list** searches every item still to buy and shows what each costs now on its row, with a "Now" total in the summary

ShoppingDock reads Auctionator's saved lists. The only change it ever makes to them is **Forget list**, which deletes a list through Auctionator's own list manager. It needs Auctionator.

## Two ways to ship it

**Standalone**: install this folder like any addon. You get the dock plus a settings window (`/sdock config`, the minimap button's right-click, Options > AddOns, the Addon Compartment): *Show shopping list dock*, *Show minimap button*, and the window look.

**Embedded**: an addon that makes shopping lists copies `ShoppingDock.lua` into itself, so its players don't need a second download. See [Embedding](#embedding).

Either way, only one dock ever runs. Every copy of `ShoppingDock.lua` carries a version (`MINOR`). At load the newest copy takes the global `ShoppingDock` table, and the others don't do anything: no frames, no AH searches, no event handling. With the same `MINOR` in two places, the first one loaded wins. If CraftRoute and CrateCost both embed it and the player also has the standalone addon, there's still one dock and one *Shopping list* button. It shows both addons' lists, opens on whichever list was made most recently, and the list menu switches between them.

## Slash commands

- `/sdock` (or `/shoppingdock`): open or close the dock
- `/sdock config`: settings (standalone only)

## API for addons that make shopping lists

Always go through the global, and check that it's there:

```lua
local listName = "CrateCost: crates"   -- prefix with your addon's name
Auctionator.API.v1.CreateShoppingList("CrateCost", listName, searchStrings)
if ShoppingDock then
  ShoppingDock.SetListPlan(listName, {
    { id = 2589, name = "Linen Cloth", qty = 20, planned = 12345 },
    { id = 2592, name = "Wool Cloth",  qty = 10, planned = 40000 },
  })
  ShoppingDock.ShowShoppingList(listName) -- optional: open the dock on it now
end
```

### `ShoppingDock.SetListPlan(listName, plan [, source])` → `true` / `false`

Tells the dock what you expect each item to cost. Call it **right after** `CreateShoppingList`: creating a list resets the dock's progress for that name, and a plan set before that would be wiped.

`plan` is either a list or a map:

```lua
{ { id = itemID, name = "Linen Cloth", qty = 20, planned = 12345 }, ... }   -- itemID also accepted as `itemID`
{ [itemID] = { qty = 20, planned = 12345, name = "Linen Cloth" }, ... }
```

- `qty`: how many the plan covers
- `planned`: total copper you expect those `qty` to cost (the dock uses `planned / qty` each)
- `name`: optional, but pass it. It matches the plan to the list's search term and saves an AH lookup for items the client hasn't cached.

`source` is optional: the group the list goes under in the dock's list picker. Without it the dock uses the calling addon's folder name (read from the call stack), so `"CrateCost"` or `"CraftRoute"` comes out right by itself. Lists nobody registered go under their name's first word when that's a loaded addon, else "Other lists".

Calling it again replaces the list's plan. Without a plan the dock uses Auctionator's price at the moment it first saw the list ("Listed at"). Returns `false` if the arguments are wrong or the copy you reached isn't the running one (only possible if you kept an old reference instead of reading the global).

### `ShoppingDock.ShowShoppingList(listName)`

Makes `listName` the dock's list and opens the dock. Does nothing while the player has *Show shopping list dock* turned off.

### Other calls

| Call | Does |
|---|---|
| `ShoppingDock.Show()` / `Hide()` / `Toggle()` | open or close the dock |
| `ShoppingDock.IsEnabled()` | the *Show shopping list dock* setting (default on) |
| `ShoppingDock.SetEnabled(on)` | change it. Hosts that embed the dock can put a check for it in their own settings. |
| `ShoppingDock.MINOR` | version of the running copy |

### List names

Lists, plans and progress are keyed by list name. Two addons only step on each other if they use the same name, so prefix yours (`"CraftRoute: Tailoring 1-300"`, `"CrateCost: crates"`).

## Embedding

1. Copy `ShoppingDock.lua` into your addon and list it in your `.toc` after your house kit files (Theme.lua, Widgets.lua), if you have them. When your addon namespace has the kit, the dock takes your window look and button skin. Without the kit it draws its own flat panel.
2. Add `ShoppingDockDB` to your `.toc`'s `## SavedVariables:` line. Every host declares the same name, so the player's progress and plans follow them whichever addons they have installed. Without it the dock still works, but forgets progress at logout.
3. Your `.toc` needs Auctionator as a dependency or optional dependency so Auctionator loads first.
4. Don't edit the copied file. Pull new versions from this repo. Bump `MINOR` in the core when it changes, so the newest copy wins in the field.

## Saved data

`ShoppingDockDB` (account-wide, since Auctionator's lists are too):

- `lists[listName]`: `items` (bought, spent, skipped, amount per item) and `plan`
- `active`: the list the dock is on
- `enabled`, `theme`, `minimap`: settings

Progress for a list goes when Auctionator no longer has that list.
