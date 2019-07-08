<#
.Synopsis
   Begin a session of tracking the user's active windows, using event-driven actions.
.DESCRIPTION
   A longer description that describes what is being done.


   ####
   # Author      : Brent Wright
   # Date Created: 9/7/2018
   # Date Updated: mm/dd/yyyy

.EXAMPLE
    Start-TimeManagement
    # Start a Time Management session, and track the active windows.

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

Function Start-TMWatcher {
    [CmdletBinding()]
    Param (
        # Set an initial context when starting.
        [Parameter(Mandatory = $false,
            Position = 1,
            ValueFromPipeline = $true)]
        [string]
        $InitialContext,
        # Help description for Param 2.
        [int]
        $Param2
    )

    Begin {   }

    Process {

      try {
         # Create the activity monitor object, and register it as an event.
         New-TMWatcher

         Register-EventFocusMonitor

         Enable-EventFocusMonitor

         $Script:ActivityContext
      } catch {
         "TMWatcher could not be started successfully, see errors below:" | Write-Error
         throw $_
      }

    }

    End {   }
}