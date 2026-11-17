# Changelog

## 0.7.1

- **Reset list** clears the rescan results too: no prices on The plan's rows, no "Now" line in the summary, and no more/less-than-expected marks on the item. A rescan still running stops. The dock no longer searches the current item straight after a reset; Rescan item, Rescan list or Search again does.
- Core `MINOR` 14.

## 0.7.0

- **Reset list** (bottom right) starts the list over so it can be bought again: what's been bought, spent and skipped goes back to zero. The list, its expected prices and Auctionator's list stay.
- **Forget list** is now **Delete list**, at the bottom left with Auctionator's trash icon. It still asks first, then deletes the list from the dock and from Auctionator.
- Core `MINOR` 13.

## 0.6.0

- **Forget list** deletes the list, from the dock and from Auctionator's shopping lists, after a Yes/Cancel check. It used to leave the list in both, marked "forgotten".
- Lists forgotten with an earlier version are deleted from Auctionator the next time you log in or open the auction house.
- Forgotten lists no longer appear in the list menu or count toward showing the Shopping List button.
- Core `MINOR` 12.

## 0.5.5

- The Shopping List button stays in the AH title bar while the dock is open, pressed in: gold-lit with its arrow turned back to point left. Clicking it then closes the dock.
- Core `MINOR` 10.

## 0.5.4

- An addon icon (icon.tga for the AddOns list, minimap button and Options page; icon.ico for the DrangedAddons manager), built from the game's bag icon by `tools/make_icon.py`.

## 0.5.3

- The plan has a scrollbar when it has more items than fit: a thin track on the right with a thumb you can drag (the mouse wheel still works).
- Core `MINOR` 9.

## 0.5.2

- The Shopping List button moves up to the AH window's title bar, left of the close button, the same spot on every tab. It reads **Shopping List**, with the bag icon, the number of items left, and an arrow pointing right to where the dock opens. The tab-row button from 0.5.1 is gone.
- Core `MINOR` 8.

## 0.5.1

- The Shopping list button moves to the AH's bottom tab row, right of Auctionator's tabs, drawn like those tabs. It stays in that spot on every tab, where the search row and title bar spots it had in 0.5.0 clashed with buttons on some of Auctionator's tabs. It shows the number of items left and opens the dock. It doesn't change the AH's view.
- Core `MINOR` 7.

## 0.5.0

- The **Shopping list** tab sticking out of the AH window is gone. When the dock is closed it folds into a bag button inside the AH window: at the top right of Auctionator's Shopping tab search row, or in the title bar beside the close button on other tabs, where the AH's own search bar runs to the edge. The number on it is how many items are left on your list. It doesn't show at all when there are no shopping lists.
- The dock opens in the same frame as the auction house window (it used to wait half a second), and lines up with the window's top.
- Core `MINOR` 6.

## 0.4.1

- The `<` `>` arrows beside the list are gone. The list dropdown spans the dock's width.
- Core `MINOR` 5.

## 0.4.0

- "The list" is now **The plan**. Click any row to buy that item next. A skipped item comes back when you click it. After it's bought, the dock carries on with the next item after it.
- **Forget list** is back in place of Start over and Done with list. It drops what's been bought and skipped on the list and stops the dock opening for it at the AH. Auctionator's list isn't touched, and it stays in the list menu, marked "forgotten", to start again.
- Core `MINOR` 4.

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
