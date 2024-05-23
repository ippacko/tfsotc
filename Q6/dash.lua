local distance = 9
local speed = 75
local highlightEffect = CONST_ME_MAGIC_RED -- Assuming red highlight effect
local fadeEffect = CONST_ME_MAGIC_BLUE -- Placeholder effect for fading images

-- Function to check if the position is walkable
local function isWalkable(pos)
    local tile = Tile(pos)
    if not tile then
        print("Tile at position", pos, "is not valid.")
        return false
    end

    local ground = tile:getGround()
    if not ground then
        print("Ground does not exist at position", pos)
        return false
    end

    if ground:hasProperty(CONST_PROP_BLOCKSOLID) or ground:hasProperty(CONST_PROP_NOFIELD) then
        print("Ground at position", pos, "is not walkable due to blocking property.")
        return false
    end

    for i = 1, tile:getThingCount() do
        local thing = tile:getThing(i)
        if thing and thing:isItem() and (thing:hasProperty(CONST_PROP_BLOCKSOLID) or thing:hasProperty(CONST_PROP_NOFIELD)) then
            print("Found blocking item at position", pos)
            return false
        elseif thing and thing:isCreature() then
            print("Found creature at position", pos)
            return false
        end
    end

    print("Position", pos, "is walkable.")
    return true
end

function createFadingEffect(position)
    -- Show fading effect at the position
    position:sendMagicEffect(fadeEffect)
end

function onWalk(cid, speed, distance)
    local player = Player(cid)
    if not player then
        print("Player with CID", cid, "not found.")
        return
    end

    local prePos = player:getPosition()
    local pos = Position(prePos)
    pos:getNextPosition(player:getDirection())

    print("Attempting to walk to position", pos)

    if isWalkable(pos) then
        -- Create fade effect at the previous position
        createFadingEffect(prePos)

        -- Teleport player and apply highlight effect
        player:teleportTo(pos, true)
        pos:sendMagicEffect(highlightEffect)
        print("Teleported to position", pos)

        if distance > 1 then
            addEvent(onWalk, speed, cid, speed, distance - 1)
            print("Scheduled next walk for CID", cid)
        end
    else
        prePos:sendMagicEffect(CONST_ME_POFF)  -- Visual effect to indicate collision
        print("Cannot walk to position", pos)
    end
end

function onCastSpell(creature, var)
    local cid = creature:getId()
    print("Casting spell for creature with CID", cid)
    onWalk(cid, speed, distance)
    return true
end
