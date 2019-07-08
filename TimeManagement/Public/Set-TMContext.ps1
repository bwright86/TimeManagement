<#
.Synopsis
   Change the current context to another value.
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


function Set-TMContext {
    [cmdletbinding()]
    param(
    # Context around the current work being performed.
    [Parameter(Mandatory=$true,
               Position=0,
               ValueFromPipeline=$true)]
    [string]
    $Context
    )

    Begin {   }

    Process {

        $Script:ActivityContext = $Context
    }

    End {   }

}