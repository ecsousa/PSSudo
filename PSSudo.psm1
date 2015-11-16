function Start-Elevated {
    $psi = new-object System.Diagnostics.ProcessStartInfo

    $emuHk = $env:ConEmuHooks -eq 'Enabled'

    if($args.Length -eq 0) {
        if($emuHk) {
            $psi.FileName = $env:WINDIR + '\System32\WindowsPowerShell\v1.0\powershell.exe'
            $psi.Arguments = "-new_console:a -ExecutionPolicy $(Get-ExecutionPolicy) -NoLogo"
            $psi.UseShellExecute = $false
        }
        else {
            Write-Warning "You must provived to program to be executed and its command line arguments"
            return
        }
    }
    else {
        if($args.Length -ne 1) {
            $cmdLine = [string]::Join(' ', ($args[1..$args.Length] | % { '"' + (([string] $_).Replace('"', '""')) + '"' }) )
        }
        else {
            $cmdLine = ''
        }

        $cmd = $args[0]

        $alias = Get-Alias $cmd -ErrorAction SilentlyContinue
        while($alias) {
            $cmd = $alias.Definition;
            $alias = Get-Alias $cmd -ErrorAction SilentlyContinue
        }

        $cmd = Get-Command $cmd -ErrorAction SilentlyContinue

        switch -regex ($cmd.CommandType) {
            'Application' {
                $program = $cmd.Source
            }
            'Cmdlet|Function' {
                $program = $env:WINDIR + '\System32\WindowsPowerShell\v1.0\powershell.exe'

                $cmdLine = "$($cmd.Name) $cmdLine"
                $cmdLine = "-NoLogo -Command `"$cmdLine; pause`""

            }
            'ExternalScript' {
                $program = $env:WINDIR + '\System32\WindowsPowerShell\v1.0\powershell.exe'

                $cmdLine = "& '$($cmd.Source)' $cmdLine"
                $cmdLine = "-NoLogo -Command `"$cmdLine; pause`""
            }
            default {
                Write-Warning "Command '$($args[0])' not found."
                return
            }
        }

        if($emuHk) {
            $psi.UseShellExecute = $false
            $cmdLine = "-new_console:a $cmdLine";
        }
        else {
            $psi.Verb = "runas"
        }


        $psi.FileName = $program
        $psi.Arguments = $cmdLine
    }

    [System.Diagnostics.Process]::Start($psi) | out-null

}

Set-Alias sudo Start-Elevated

