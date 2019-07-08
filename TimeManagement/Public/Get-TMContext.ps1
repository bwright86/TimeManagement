<#
.Synopsis
   Get the current activity context.
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


function Get-TMContext {
    [cmdletbinding()]
    [OutputType()]
    param(    )

    Begin {   }

    Process {

        $Script:ActivityContext

    }

    End {   }

}