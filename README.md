# esx_identity

## Requirements
* Dependencies For Full Functionality
  * [esx_skin](https://github.com/ESX-Org/esx_skin)
  * [esx_policejob](https://github.com/ESX-Org/esx_policejob)
  * [esx_society](https://github.com/ESX-Org/esx_society)

## Download & Installation

## Installation
- Import `esx_identity.sql` in your database
- Add this to your `server.cfg`:
- Note: the sql now only uses the users table
```
start esx_identity
```

- If you are using esx_policejob or esx_society, you need to enable the following in the scripts' `config.lua`:
```Config.EnableESXIdentity          = true```

### Commands
```
/register
/char
/chardel
```

## Notes

## Licensing

There is no license, therefore this code is copyrighted by default, and no one can modify or distribute this updated script on their servers without permission. You may use this script as-is, but DO NOT post it anywhere yourself, please give them the link to this repo.

If you have any sources for esx_aiomenu that date before this update was released, then you may use them following the licenses of the old script. For help with ESX AIOMenu or the new version of ESX Identity, please join the discord via this link: https://discord.gg/3ECcWxn

Copyright 2017-2018, David Miles, All rights reserved.
