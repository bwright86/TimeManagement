<#
.SYNOPSIS
Begins a session of tracking the user's active windows, using event-driven actions.

.DESCRIPTION
A longer detailed description of what is done in the function.

    Author      : Brent Wright
    Date Created: 9/7/2018
    Date Updated:


.EXAMPLE
# Start a Time Management session, and track the active windows.
C:\PS> Start-TimeManagement

.LINK
http://www.fabrikam.com/extension.html
.LINK
Set-Item
#>

Function Start-TimeManagement {
    [CmdletBinding()]
    Param (
        # Help description for Param 1.
        [Parameter(Mandatory=$true,
                   Position=1,
                   ValueFromPipeline=$true)]
        $Param1,
        # Help description for Param 2.
        [int]
        $Param2
    )

    Begin {   }

    Process {

        # Create the activity monitor object, and register it as an event.
        Register-EventFocusMonitor

        Enable-EventFocusMonitor

        $Global:TMContext = ""

        $Global:TMContext

    }

    End {   }
}