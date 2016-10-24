# PSSudo

PowerShell module that provides `Start-Elevated` function: it will execute the
provided command line in elavated mode. This module is able to handle to
following argument types:

* Application
* Cmdlet
* Function
* PowerShell Script
* Script Block
* Alias _(For Alias, PSSudo will try to resolve as one of the other types
  above)_

This function is aliased as `sudo`

**Note**: When using Cmdlets, Functions or Scripts, PowerShell will resolve
variable arguments before passing them to the Start-Elevated function. For most
situatio that would be ok. But there is a few exceptions. For instance, in the
following command:

`sudo Set-MpPreference -DisableRealtimeMonitoring $False`

PowerShell would resolve $False to 'False' before executing Start-Elevated.
Then, the following block would be executed in the elevated PowerShell:

`Set-MpPreference -DisableRealtimeMonitoring False`

This will throw an error, because PowerShell is not able to implicit convert
'False' string into boolean type.

For those case, you could execute:

`sudo Set-MpPreference -DisableRealtimeMonitoring 0` _(As PowerShell converts
zero into $False)_

Or use a Script Block:

`sudo { Set-MpPreference -DisableRealtimeMonitoring $False }`


## Installing

Windows 10 users:

    Install-Module PSSudo -Scope CurrentUser

Otherwise, if you have [PsGet](http://psget.net/) installed:


    Install-Module PSSudo
  
Or you can install it manually coping `PSSudo.psm1` to your modules folder (e.g.
` $Env:USERPROFILE\Eduardo_Sousa\Documents\WindowsPowerShell\Modules\PSSudo\`)
