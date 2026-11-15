# Changelog

## 0.1.0

- First version. A dock on the auction house's right edge that works through any Auctionator shopping list one item at a time: live price against what the list expected, Buy now / Confirm for commodities, one stack at a time for auctions, Skip, an amount box, Start over and Done with list.
- `ShoppingDock.SetListPlan` and `ShoppingDock.ShowShoppingList` for addons that make lists.
- `ShoppingDock.lua` can be embedded in other addons. Only the newest copy runs, so there's always one dock.
- Settings: Show shopping list dock, Show minimap button, window look. `/sdock`, `/sdock config`.
