

function Enable-EventFocusMonitor {
    [CmdletBinding()]
    Param (    )

    Begin {   }

    Process {

        if ($Global:ActiveWindowMonitor.Enabled()) {
            Write-Verbose "Window focus monitoring is already enabled."
        } else {
            $Global:ActiveWindowMonitor.enable()
            Write-Verbose "Enabling Window focus monitoring."
        }

    }

    End {   }
}