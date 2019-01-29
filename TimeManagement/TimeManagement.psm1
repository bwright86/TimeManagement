# Shamelessly borrowed from Rambling Cookie Monster. Link here:
# https://github.com/RamblingCookieMonster/PSStackExchange/blob/db1277453374cb16684b35cf93a8f5c97288c41f/PSStackExchange/PSStackExchange.psm1


#Get public and private function definition files.
$Public  = @( Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path "$PSScriptRoot\Private\*.ps1" -ErrorAction SilentlyContinue )
$Classes = @( Get-ChildItem -Path "$PSScriptRoot\Classes\*.ps1" -ErrorAction SilentlyContinue )

Write-Verbose "PSScriptRoot: $PSScriptRoot"
"Found {0} file(s) to import in Classes, Public, and Private." -f $($Public.count + $Private.count + $Classes.count) | Write-Verbose

#Dot source the files
Foreach($import in @($Public + $Private + $Classes))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function/class $($import.fullname): $_"
    }
}

# Global variables for the AWM object and Context GUI form.
$Global:ActiveWindowMonitor = $null
$Global:AWMContextForm = $null

# The current context to be written with activities.
$Global:ActivityContext = "Initial Startup"

# A queue to hold transformed activities that are ready to be stored in a file.
#$Script:ActivityQueue = [System.Collections.Queue]::Synchronized( $(new-object System.Collections.Queue) )

# Import assembly for GUI Forms.
Add-Type -AssemblyName System.Windows.Forms

$($Public.Basename + $Private.Basename) | Export-ModuleMember
