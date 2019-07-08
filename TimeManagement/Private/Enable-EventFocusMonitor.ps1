

function Enable-EventFocusMonitor {
    [CmdletBinding()]
    Param (    )

    Begin {   }

    Process {

        if ( $Script:ActiveWindowMonitor.Enabled ) {
            Write-Verbose "Window focus monitoring is already enabled."
        } else {
            $Script:ActiveWindowMonitor.Enable()
            Write-Verbose "Enabling Window focus monitoring."
        }

    }

    End {   }
}