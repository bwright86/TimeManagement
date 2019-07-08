<#
.Synopsis
   Stop the current session that is tracking the user's active windows, using event-driven actions.
.DESCRIPTION
   A longer description that describes what is being done.


   ####
   # Author: Brent Wright
   # Date Created: 07/02/2019
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

function Stop-TMWatcher {
    [cmdletbinding()]
    param(    )

    Begin {   }

    Process {

      # Disable the Active Window monitoring.
      Disable-EventFocusMonitor

      # Unregister any watcher event subscriptions.
      Unregister-EventFocusMonitor

    }

    End {   }

}