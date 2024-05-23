# TFS/OTClient Dash Functionality

This repository contains the modifications needed to add a dash spell to The Forgotten Server (TFS) and OTClient.

## Server-Side (TFS)

1. **Create Dash Spell:**
   - Save the `dash.lua` script in the `data/spells/scripts/` directory.

2. **Register the Spell:**
   - Add the spell entry in `data/spells/spells.xml` with an appropriate name and id.

## Usage

- **Restart your server and client** to apply changes.
- **Log into the game** and use the spell words to activate.

## Notes

- Ensure proper cooldowns, mana/stamina costs, and safety checks in the script.
- Verify client-server synchronization to avoid desynchronization issues.
