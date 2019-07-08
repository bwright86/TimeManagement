<#
.Synopsis
   Retrieve the existing Context Data used previously
.DESCRIPTION
   A longer description that describes what is being done.


   ####
   # Author: Brent Wright
   # Date Created: 07/06/2019
   # Date Updated: mm/dd/yyyy

.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.NOTES
   Updates:
     mm/dd/yyyy - user.name - fixed a bug, added a new feature...
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>


function Import-ContextData {
    [cmdletbinding()]
    [OutputType()]
    param(    )

    Begin {   }

    Process {

        if (Test-Path -Path $Script:TMOptions.ContextData) {
            $Script:ContextData = Get-Content $Script:TMOptions.ContextData | ConvertFrom-Csv | ForEach-Object {
                $_.LastUsed = [datetime]$_.LastUsed
            }
        } else {
            $Script:ContextData = @(
                [PSCustomObject]@{Context = Project1; Type = Project; LastUsed = $([datetime]"6/15/2019")}
                [PSCustomObject]@{Context = Project2; Type = Project; LastUsed = $([datetime]"6/22/2019")}
                [PSCustomObject]@{Context = Project3; Type = Project; LastUsed = $([datetime]"6/29/2019")}
                [PSCustomObject]@{Context = Project4; Type = Project; LastUsed = $([datetime]"7/6/2019")}
                [PSCustomObject]@{Context = Task1; Type = Task; LastUsed = $([datetime]"6/15/2019")}
                [PSCustomObject]@{Context = Task2; Type = Task; LastUsed = $([datetime]"6/22/2019")}
                [PSCustomObject]@{Context = Task3; Type = Task; LastUsed = $([datetime]"6/29/2019")}
                [PSCustomObject]@{Context = Task4; Type = Task; LastUsed = $([datetime]"7/6/2019")}
                [PSCustomObject]@{Context = BAU1; Type = BAU; LastUsed = $([datetime]"6/15/2019")}
                [PSCustomObject]@{Context = BAU2; Type = BAU; LastUsed = $([datetime]"6/22/2019")}
                [PSCustomObject]@{Context = BAU3; Type = BAU; LastUsed = $([datetime]"6/29/2019")}
                [PSCustomObject]@{Context = BAU4; Type = BAU; LastUsed = $([datetime]"7/6/2019")}
                [PSCustomObject]@{Context = Maint1; Type = Maintenance; LastUsed = $([datetime]"6/15/2019")}
                [PSCustomObject]@{Context = Maint2; Type = Maintenance; LastUsed = $([datetime]"6/22/2019")}
                [PSCustomObject]@{Context = Maint3; Type = Maintenance; LastUsed = $([datetime]"6/29/2019")}
                [PSCustomObject]@{Context = Maint4; Type = Maintenance; LastUsed = $([datetime]"7/6/2019")}
            )
        }

        "Imported {0} contextual items" -f $Script:ContextData.count | Write-Verbose

    }

    End {   }

}