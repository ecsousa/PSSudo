if([Diagnostics.Process]::GetCurrentProcess().Modules | ? { ($_.ModuleName -eq 'ConEmuHk.dll') -or ($_.ModuleName -eq 'ConEmuHk64.dll') }) {
    $emuHk = $true;
}
else {
    $emuHk = $false;
}


function Start-Elevated {
    $psi = new-object System.Diagnostics.ProcessStartInfo

    if($args.Length -eq 0) {
        if($emuHk) {
            $psi.FileName = $env:WINDIR + '\System32\WindowsPowerShell\v1.0\powershell.exe'
            $psi.Arguments = '-new_console:a -ExecutionPolicy ' + (Get-ExecutionPolicy) + ' -NoExit -Command "Import-Module ''' + $PSScriptRoot + '''"'
            $psi.UseShellExecute = $false
        }
        else {
            Write-Warning "You must provived to program to be executed and its command line arguments"
            return
        }
    }
    else {
        $program = $args[0]

        $alias = Get-Alias $program -ErrorAction SilentlyContinue
        while($alias) {
            $program = $alias.Definition;
            $alias = Get-Alias $program -ErrorAction SilentlyContinue
        }

        if($emuHk) {
            $fullProgram = which $program | select-object -First 1

            if($fullProgram) {
                $program = $fullProgram
            }
            
            $psi.UseShellExecute = $false
            $cmdLine = '-new_console:a ';
        }
        else {
            $psi.Verb = "runas"
            $cmdLine = ''
        }

        if($args.Length -ne 1) {
            $cmdLine = $cmdLine + [string]::Join(' ', ($args[1..$args.Length] | % { '"' + (([string] $_).Replace('"', '""')) + '"' }) )
        }

        $psi.FileName = $program
        $psi.Arguments = $cmdLine
    }

    [System.Diagnostics.Process]::Start($psi) | out-null

}

Set-Alias sudo Start-Elevated

