# A helper function to be ran during an event notification.

function Receive-EventFocusActivity {
    [CmdletBinding()]
    Param (
        # The object with details of the event
        [Parameter(Mandatory=$true,
                   Position=1,
                   ValueFromPipeline=$true)]
        $InputObject
    )

    Begin {   }

    Process {

        $obj = [PSCustomObject]@{
            Timestamp   = $(Get-Date)
            ProcessID   = $InputObject.ProcessID
            ModuleName  = $inputObject.ModuleName
            WindowTitle = $InputObject.WindowTitle
            Context     = $Global:ActivityContext
        }

        $Script:ActivityQueue.Enqueue($obj)

    }

    End {   }
}