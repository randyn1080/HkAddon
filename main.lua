RaidMembers = {}
LootHistory = {}

SLASH_SGC1 = "/clutch"
SLASH_RECORD1 = "/record"
SLASH_PURCHASE1 = "/purchase"

StaticPopupDialogs["CopyDialog"] = {
    text = "Press Ctrl-C to copy the text.",
    button1 = OKAY,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    hasEditBox = true,
    maxLetters = 1000,
    -- OnAccept = function() -- add another edit box with an input option to pass through boss / DKP gain?
    
    --     tinsert(RaidMembers,"====================")
    --     for i=1, GetNumGroupMembers() do
    --         local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(i)
    --         -- if online then
    --             if UnitIsInMyGuild(format("%s",name)) then                    
    --                 tinsert(RaidMembers,format("%s, %s",date(),name))
    --             end
    --         -- end
    --     end
    --     tinsert(RaidMembers,"====================")
    
    --     print('completed SavedVar upload')
    
    -- end
}

SlashCmdList.SGC = function(input)

    if (not IsInGroup()) then
        print("you aren't in a group")
        return
    end
    
    local playerName = ""

    for i = 1, GetNumGroupMembers() do
        local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(i)
        -- if online then
            if UnitIsInMyGuild(format("%s",name)) then
                playerName = playerName .. name .. ";"
            end
        -- end                
    end


    local dialog = StaticPopup_Show("CopyDialog")
    local editBox = dialog.editBox

    editBox:SetText(playerName)
    editBox:HighlightText()
    editBox:SetFocus()

end

SlashCmdList.RECORD = function(msg)

    tinsert(RaidMembers,"====================")
        for i=1, GetNumGroupMembers() do
            local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(i)
            if online then
                if UnitIsInMyGuild(format("%s",name)) then                    
                    tinsert(RaidMembers,format("%s, %s, %s",date(),name,msg))
                end
            end
        end
    tinsert(RaidMembers,"====================")

    print('Completed Recording DKP')

end

SlashCmdList.PURCHASE = function(msg)

    tinsert(LootHistory, format("%s, %s",date(), msg))

    print('Completed Recording Purchase DKP')

end