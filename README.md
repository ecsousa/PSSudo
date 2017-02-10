# PSSudo

PowerShell module that provides `Start-Elevated` function: it will execute the
provided command line with elevated privileges. This module is able to handle
the following argument types:

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
situations that would be OK. But there is a few exceptions. For instance, in
the following command:

`sudo Set-MpPreference -DisableRealtimeMonitoring $False`

PowerShell would resolve `$False` to `'False'` before executing `Start-Elevated`.
Then, the following block would be executed in the elevated PowerShell:

`Set-MpPreference -DisableRealtimeMonitoring False`

This will throw an error, because PowerShell is not able to implicitly convert
the `'False'` string into a Boolean type.

For such cases, you could execute:

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
`$Env:USERPROFILE\Documents\WindowsPowerShell\Modules\PSSudo\`)
