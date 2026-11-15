---------------------------------------------------------
--  ShoppingDock - settings, minimap button, Options page
--  Author: Dranged
---------------------------------------------------------
-- Only the standalone install has these. An addon that embeds ShoppingDock.lua gets the dock
-- and the slash command; it can add its own "Show shopping list dock" check with
-- ShoppingDock.IsEnabled / ShoppingDock.SetEnabled.
--
-- Everything goes through the global ShoppingDock: that's whichever copy is running, which may
-- be a newer one embedded in another addon rather than this folder's.

local ADDON, NS = ...
local UI = NS.UI

NS.ICON = "Interface\\Icons\\INV_Misc_Bag_10"

function NS.Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cffffd100ShoppingDock|r: " .. tostring(msg))
end

local function SD() return _G.ShoppingDock end

-- ShoppingDockDB is shared with the dock; display settings sit at its top level.
local function DB()
    local sd = SD()
    if sd and sd.DB then return sd.DB() end
    _G.ShoppingDockDB = _G.ShoppingDockDB or {}
    return _G.ShoppingDockDB
end

---------------------------------------------------------
--  SECTION: Settings window
---------------------------------------------------------
local win

local function Build()
    win = UI.Window({ name = "ShoppingDockSettings", title = "ShoppingDock", width = 440, height = 300 })
    local body = win.body

    local dock = UI.Check(body, "Show shopping list dock",
        function() return SD() and SD().IsEnabled() end,
        function(on) if SD() then SD().SetEnabled(on) end end)
    dock:SetPoint("TOPLEFT", 0, 0)
    local dockNote = UI.Text(body, "The Shopping list button beside the auction house, and the dock opening "
        .. "there by itself when a list has things left to buy.", "GameFontHighlightSmall")
    dockNote:SetPoint("TOPLEFT", dock, "BOTTOMLEFT", 26, -2)
    dockNote:SetPoint("RIGHT", body, "RIGHT", 0, 0)
    dockNote:SetTextColor(0.7, 0.7, 0.7)

    local mm = UI.Check(body, "Show minimap button",
        function() return not DB().minimap.hide end,
        function(on) UI.SetLauncherShown(DB().minimap, on) end)
    mm:SetPoint("TOPLEFT", 0, -62)

    local lookLabel = UI.Text(body, "Look", "GameFontNormalSmall")
    lookLabel:SetPoint("TOPLEFT", 4, -102)
    local look = UI.Dropdown(body, 220, function()
        local out = {}
        for _, o in ipairs(NS.LookOptions()) do out[#out + 1] = { value = o.value, label = o.text } end
        return out
    end, function() return NS.db.theme or "auto" end, function(v) NS.SetLook(v) end)
    look:SetPoint("TOPLEFT", 0, -118)

    local open = UI.Button(body, "Open the dock", 160, 24, function()
        if SD() then SD().Show() end
    end)
    open:SetPoint("BOTTOMLEFT", 0, 0)
    local slash = UI.Text(body, "|cffffd100/sdock|r opens the dock, |cffffd100/sdock config|r this window.",
        "GameFontHighlightSmall")
    slash:SetPoint("LEFT", open, "RIGHT", 12, 0)
end

function NS.OpenSettings()
    if not win then Build() end
    win:Show()
end

local function ToggleSettings()
    if win and win:IsShown() then win:Hide() else NS.OpenSettings() end
end

-- the slash command reaches this through the running copy, whichever that is
if SD() then SD().OpenSettings = NS.OpenSettings end

UI.RegisterSettingsPage(NS.ICON, "/sdock config", NS.OpenSettings)

function ShoppingDock_OnCompartmentClick(_, button)
    if button == "RightButton" then ToggleSettings() elseif SD() then SD().Toggle() end
end

---------------------------------------------------------
--  SECTION: Login
---------------------------------------------------------
local loader = CreateFrame("Frame")
loader:RegisterEvent("PLAYER_LOGIN")
loader:SetScript("OnEvent", function()
    local db = DB()
    if db.theme == nil then db.theme = "auto" end
    if type(db.minimap) ~= "table" then db.minimap = { hide = false } end
    NS.db = db
    -- a copy that took over after this file loaded keeps the settings window
    if SD() and not SD().OpenSettings then SD().OpenSettings = NS.OpenSettings end
    UI.Launcher({
        icon = NS.ICON,
        db = db.minimap,
        onLeft = function() if SD() then SD().Toggle() end end,
        onRight = ToggleSettings,
    })
end)
