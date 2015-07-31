# PSSudo

PowerShell module that provides `Start-Elevated` function: it will the provided command line in elavated mode. There is only one restriction: the command to be executed must be a program.

This function is aliased as `sudo`

## Installing

If you have [PsGet](http://psget.net/) installed:

    Install-Module PSSudo
  
Or you can install it manually coping `PSSudo.psm1` to your modules folder (e.g. ` $Env:USERPROFILE\Eduardo_Sousa\Documents\WindowsPowerShell\Modules\PSSudo\`)
