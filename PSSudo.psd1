@{
RootModule = 'PSSudo.psm1'
ModuleVersion = '1.1.0'
GUID = '75640361-a312-4e57-8564-9c8b904d333b'
Author = 'Eduardo Sousa'
Description = 'Function for executing programs with adminstrative privileges'
PowerShellVersion = '3.0'
DotNetFrameworkVersion = '4.0'
CLRVersion = '4.0'
FunctionsToExport = @('Start-Elevated')
AliasesToExport = @('sudo')
HelpInfoURI = 'https://github.com/ecsousa/PSSudo'
PrivateData = @{
        Tags='sudo elevation'
        ProjectUri='https://github.com/ecsousa/PSSudo'
    }
}
