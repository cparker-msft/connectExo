<#

.SYNOPSIS 
Name: connectEXO.ps1
Connects to Exchange Online PowerShell 
 
.DESCRIPTION 
Can be used instead of following the manual process outlined in:
https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell?view=exchange-ps

THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR   
FITNESS FOR A PARTICULAR PURPOSE.
 
.NOTES 
┌─────────────────────────────────────────────────────────────────────────────────────────────┐ 
│ METADATA                                                                                    │ 
├─────────────────────────────────────────────────────────────────────────────────────────────┤ 
│   AUTHOR       : Cameron Parker                                                             |
│   DESCRIPTION  : Script to automate connecting to Exchange Online PowerShell                |
|   RELEASED     : 12/14/2018                                                                 |
|   LAST UPDATED : 12/18/2018                                                                 |
└─────────────────────────────────────────────────────────────────────────────────────────────┘ 
 
.EXAMPLE 
.\connectEXO.ps1

OR call from shortcut:
"%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe " -noexit -command "&C:\PathToScript\connectEXO.ps1"

  ** You can configure the shortcut to run the powershell process as an admin (Right-click shortcut > Properties > Advanced > Select Run as administrator)
#> 

function createSession {
    param()

    
    Write-Host ""
    Write-Host ""
    Write-Host "Please enter your credentials:" -ForegroundColor Yellow
    $upn = Read-Host "Username [UPN]"
    $password = Read-Host "Password" -AsSecureString
    $creds = New-Object System.Management.Automation.PSCredential($upn, $password)

    $provisionSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $creds -Authentication Basic -AllowRedirection

    return $provisionSession
}

Write-Host ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
Write-Host ">> Exchange Online PowerShell  >>"
Write-Host ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
Write-Host ""
Write-Host ""

# Confirm that Execution Policy has been configured for Remote Signed
# If not, user will need to allow this
Write-Host "Checking Execution Policy... " -NoNewline
$getPolicyResult = Get-ExecutionPolicy

if ($getPolicyResult -eq ("RemoteSigned" -or "Unrestricted")) {
    Write-Host "$getPolicyResult" -ForegroundColor Green
}
else {
    Write-Host "$getPolicyResult" -NoNewline -ForegroundColor Red
    Write-Warning ". You must set your Execution Policy to a minimum of Remote Signed. Making the call: Set-ExecutionPolicy RemoteSigned"
    Set-ExecutionPolicy RemoteSigned
}

# Create a new Session
$Session = createSession

# Import the Session
$noSession = $true
while($noSession){

    # Try to import Session - if this fails, catch it so we can retry if user elects to
    try {
        Import-PSSession $Session -DisableNameChecking | Out-Null
        $noSession = $false

        Clear-Host
        Write-Host "Session successfully created. " -ForegroundColor Green
        Write-Host "Protip - remove your session when completed: " -NoNewLine -ForegroundColor Yellow
        Write-Host "Get-PSSession | Remove-PSSession" -ForegroundColor Cyan
        Write-Host ""
        Write-Host ""
    }
    catch {
        Write-Host ""
        Write-Host "Failure to import session!" -ForegroundColor Red
        Write-Host ""
        $decide = Read-Host "Would you like to try again? [y/N]"

        if (($decide -notmatch "Yes") -and ($decide -notmatch "yes") -and ($decide -notmatch "y") -and ($decide -notmatch "Y")){
            break
        }

        # Re-attempt to create a new Session
        $Session = createSession
    }

}