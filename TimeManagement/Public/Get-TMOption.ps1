<#
.Synopsis
   Show current options for the Time Management module.
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


function Get-TMOption {
    [cmdletbinding()]
    [OutputType()]
    param(
    # Specific option to return value for.
    [string]
    $Option
    )

    Begin {   }

    Process {

        if ( $PSBoundParameters.ContainsKey("Option") ) {
            $Script:TMOptions.$Option
        } else {
            $Script:TMOptions
        }
    }

    End {   }

}