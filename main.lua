RaidMembers = {}

SLASH_SGC1 = "/snap"

StaticPopupDialogs["CopyDialog"] = {
    text = "Press Ctrl-C to copy the text.",
    button1 = OKAY,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    hasEditBox = true,
    maxLetters = 1000,
    OnAccept = function() -- add another edit box with an input option to pass through boss / DKP gain?
    
        tinsert(RaidMembers,"====================")
        for i=1, GetNumGroupMembers() do
            local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(i)
            if online then
                tinsert(RaidMembers,format("%s, %s",date(),name))
            end
        end
        tinsert(RaidMembers,"====================")
    
        print('completed SavedVar upload')
    
    end
}

SlashCmdList.SGC = function(input)

    if (not IsInGroup()) then
        print("you aren't in a group")
        return
    end
    
    local playerName = ""

    for i = 1, GetNumGroupMembers() do
        local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(i)
        playerName = playerName .. name .. ";"
    end


    local dialog = StaticPopup_Show("CopyDialog")
    local editBox = dialog.editBox

    editBox:SetText(playerName)
    editBox:HighlightText()
    editBox:SetFocus()
    print('check')
end