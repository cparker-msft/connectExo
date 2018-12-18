# connectExo
## Description
Script to automate connecting to Exchange Online PowerShell.

Can be used instead of following the manual process outlined in:
https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell?view=exchange-ps


## Usage
* From PowerShell:

  ```.\connectEXO.ps1```
 



* You can call from a shortcut supplying something like the following as the target:

  ```"%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe " -noexit -command "&C:\PathToScript\connectEXO.ps1"```

  Note: You can configure the shortcut to run the powershell process as an admin (Right-click shortcut > Properties > Advanced > Select Run as administrator)
  
  
## Disclaimer
THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
