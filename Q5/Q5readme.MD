# TFS/OTClient Frost Storm Functionality

This repository contains the modifications needed to add a Frost Storm spell to The Forgotten Server (TFS) and OTClient.

## Server-Side (TFS)

1. **Create Dash Spell:**
   - Save the `frost_storm.lua` script in the `data/spells/attac/` directory.

2. **Register the Spell:**
   - Add the spell entry in `data/spells/spells.xml` with an appropriate name and id.

## Usage

- **Restart your server and client** to apply changes.
- **Log into the game** and say the words associated with the spell to activate it.

## Notes

- Ensure proper cooldowns, mana/stamina costs, and safety checks in the script.
- Strange visual glitches when activating, doesn't show spell unless player moves.
