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

# Module variables for the AWM object and Context GUI form.
$Script:ActiveWindowMonitor = $null
$Script:AWMContextForm = $null

# The current context to be written with activities.
$Script:ActivityContext = "Initial Startup"

# A list of context currently available.
$Script:ContextData = @()

# Create an Options variable to store common options in.
$Script:TMOptions = @{}
$Script:TMOptions.DataFolder = "C:\Users\brent.wright.WRIGHT.000\AppData\Roaming\Microsoft\Windows\PowerShell\TimeManagement\"
$Script:TMOptions.ContextData = Join-Path $Script:TMOptions.DataFolder "ContextData.csv"
$Script:TMOptions.ReportFolder = Join-Path $Script:TMOptions.DataFolder "Reports\"
$Script:TMOptions.ReportName = { "TMReport_{0:yyyyMMdd}.csv" -f $(Get-Date) }
$Script:TMOptions.HideContextOlderThanDays = 7
$Script:TMOptions.Runspaces = @()

# Create the folder structure if it doesn't already exist.
if ( -not (Test-Path -Path $Script:TMOptions.DataFolder -PathType Container)) {
    New-Item -Path $Script:TMOptions.DataFolder -ItemType Directory -Force | Out-Null
}

if ( -not (Test-Path -Path $Script:TMOptions.ReportFolder -PathType Container)) {
    New-Item -Path $Script:TMOptions.ReportFolder -ItemType Directory -Force | Out-Null
}

# A queue to hold transformed activities that are ready to be stored in a file.
$Global:ActivityQueue = [System.Collections.Queue]::Synchronized( $(new-object System.Collections.Queue) )
$Global:RecentEventObj = new-object System.Collections.Queue

# Import assembly for GUI Forms.
Add-Type -AssemblyName System.Windows.Forms

# Export the public functions for use.
#$($Public.Basename) | Export-ModuleMember
$($Public.Basename + $Private.Basename) | Export-ModuleMember

# Load context data initially
Import-ContextData