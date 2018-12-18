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

* This script is REQUIRED for the new ESX AIOMenu.

* If you have any sources for esx_aiomenu that date before this update was released, then you may use them following the licenses of the old script. For help with ESX AIOMenu or the new version of ESX Identity, please join the discord via this link: https://discord.gg/3ECcWxn

## Credits

* Special thanks to Cosharek For Help In The Creation Of The UI Design.
* Special thanks to Alphakush and CMD.Telhada for help with initial testing.

## Licensing

Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International Public License

* Attribution — You must give appropriate credit. If supplied, you must provide the name of the creator and attribution parties, a copyright notice, a license notice, a disclaimer notice, and a link to the material. CC licenses prior to Version 4.0 also require you to provide the title of the material if supplied, and may have other slight differences.

* NonCommercial — You may not use the material for commercial purposes. A commercial use is one primarily intended for commercial advantage or monetary compensation.

* NoDerivatives — If you remix, transform, or build upon the material, you may not distribute the modified material. Merely changing the format never creates a derivative.

Copyright 2017-2018, David Miles, All rights reserved.
