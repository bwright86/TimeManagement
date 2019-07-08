

Function Disable-EventFocusMonitor {
    [CmdletBinding()]
    Param (    )

    Begin {   }

    Process {

        if ($Script:ActiveWindowMonitor.Enabled) {
            $Script:ActiveWindowMonitor.Disable()
            Write-Verbose "Window focus monitoring has been disabled."
        } else {

            Write-Verbose "Window focus monitor is already disabled."
        }

    }

    End {   }
}