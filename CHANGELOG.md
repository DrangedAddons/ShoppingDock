# Changelog

## 0.3.0

- The list picker is a proper dropdown: solid background (the AH no longer shows through), lists grouped under the addon that made them (CraftRoute, CrateCost...; hand-made lists under "Other lists"), sorted A-Z, with a scrollbar when they don't fit.
- **Rescan list** sits at the top right of the summary, **Rescan item** at the top right of the current item. The row of rescan buttons under Buy is gone, so the list gets that space back.
- The dock has a solid fill under its border, so nothing behind it shows through under any window look.
- `SetListPlan` takes an optional third argument, `source`, for the picker's group. Without it the dock reads the calling addon's folder from the call stack.
- Core `MINOR` 3.

## 0.2.0

- Pick the list from the dock: click the list name for a menu of every Auctionator shopping list, with how far along each one is. The arrows still step through them.
- **Rescan item** searches the AH again for the item you're on.
- **Rescan list** searches every item still to buy, one after another, and shows on each row what the rest of it costs now: red over what the list expected, green under, the amount in brackets when the AH doesn't have enough. The summary gets a "Now" line with the total. Click again to stop.
- Core `MINOR` 2, so this copy wins over 0.1.0 copies embedded elsewhere.

## 0.1.0

- First version. A dock on the auction house's right edge that works through any Auctionator shopping list one item at a time: live price against what the list expected, Buy now / Confirm for commodities, one stack at a time for auctions, Skip, an amount box, Start over and Done with list.
- `ShoppingDock.SetListPlan` and `ShoppingDock.ShowShoppingList` for addons that make lists.
- `ShoppingDock.lua` can be embedded in other addons. Only the newest copy runs, so there's always one dock.
- Settings: Show shopping list dock, Show minimap button, window look. `/sdock`, `/sdock config`.
