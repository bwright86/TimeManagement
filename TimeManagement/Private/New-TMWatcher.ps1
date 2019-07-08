<#
.Synopsis
   Create an ActiveWindowMonitor object for use.
.DESCRIPTION
   A longer description that describes what is being done.


   ####
   # Author: Brent Wright
   # Date Created: mm/dd/yyyy
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


function New-TMWatcher {
    [cmdletbinding()]
    [OutputType()]
    param(    )

    Begin {   }

    Process {

      if ($null -eq $Script:ActiveWindowMonitor) {

         # Instantiate object to monitor active windows, store in the global variable.
         $Script:ActiveWindowMonitor = New-Object System.Diagnostics.ActiveWindowWatcher

         "New `"Active Window Monitor`" object created." | Write-Verbose

      } elseif ($Force) {

         $Script:ActiveWindowMonitor.dispose()
         # Instantiate object to monitor active windows, store in the global variable.
         $Script:ActiveWindowMonitor = New-Object System.Diagnostics.ActiveWindowWatcher

         "New `"Active Window Monitor`" object created. An existing one was forcebly removed to create a new one." | Write-Verbose

      } else {
         Write-Warning "A Window Focus monitor was already created. If there is an issue, use -Force to create a new one."
      }

    }

    End {   }

}