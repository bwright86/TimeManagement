

Function Enable-EventFocusMonitor {
    [CmdletBinding()]
    Param (    )

    Begin {   }

    Process {

        if ($Global:ActiveWindowMonitor.Enabled()) {
            $Global:ActiveWindowMonitor.Disable()
            Write-Verbose "Window focus monitoring has been disabled."
        } else {

            Write-Verbose "Window focus monitor is already disabled."
        }

    }

    End {   }
}