local combats = {}
local areas = {
    -- Area 1
    {
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 1, 0, 1, 2, 1, 0, 1, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0}
    },
    -- Area 2
    {
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 2, 0, 0, 0, 0},
        {0, 0, 1, 0, 1, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0}
    }
}

-- Function to calculate the damage values
function onGetFormulaValues(player, level, maglevel)
    local min = (level / 5) + (maglevel * 5.5) + 25
    local max = (level / 5) + (maglevel * 11) + 50
    return -min, -max
end

-- Register the function globally
_G.onGetFormulaValues = onGetFormulaValues

-- Loop to set up all combat areas and respective combat objects
for i, area in ipairs(areas) do
    local combat = Combat()
    combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
    combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
    combat:setArea(createCombatArea(area))

    -- Set the callback using the globally registered function
    combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

    table.insert(combats, combat)
end

-- Function to cast the spell for multiple areas/combats using the combatIndex
local function castSpell(creatureId, variant, combatIndex)
    local creature = Creature(creatureId)

    if not creature then
        return false
    end

    local combat = combats[combatIndex]
    if not combat then
        return false
    end

    return combat:execute(creature, variant)
end

function onCastSpell(creature, variant)
    for i = 2, #combats do
        addEvent(castSpell, 250 * (i - 1), creature:getId(), variant, i)
    end

    return combats[1]:execute(creature, variant)
end
