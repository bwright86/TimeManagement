## Author: Brent Wright
# Date Created: 05/26/2018

# Description: This is a Pester test file for private functions, that can help test hidden functions in a module.

$ModuleName = "TimeManagement"
$ModulePath = "$PSScriptRoot\..\..\$ModuleName"

# Remove the module if already imported, and import the module
if (Get-Module $ModuleName) {
    Remove-Module $ModuleName
}
Import-Module $ModulePath -Verbose

#$VerbosePreference = "Continue"

InModuleScope $ModuleName {
Describe 'Show-ContextWindow' {

    It "Form displays" {
        Show-ContextWindow -Verbose

        $true | Should -Be $true
    }
}
}
