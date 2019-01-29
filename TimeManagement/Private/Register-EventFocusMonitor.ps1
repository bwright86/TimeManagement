


function Register-EventFocusMonitor {
    [CmdletBinding()]
    Param (
        [switch]
        $Force
    )

    Begin {   }

    Process {

        if ($global:ActiveWindowMonitor -eq $null -or $Force) {

            # Instantiate object to monitor active windows, store in the global variable.
            $global:ActiveWindowMonitor = New-Object System.Diagnostics.ActiveWindowWatcher

            $registerParams = @{
                InputObject = $global:ActiveWindowMonitor
                EventName   = "Changed"
                Action      = { Receive-EventFocusActivity $global:ActiveWindowMonitor }
            }
            $job = Register-ObjectEvent @registerParams

        } else {
            Write-Verbose "A Window Focus monitor was already created. Set it to `$null or use -Force to overwrite it."
        }

    }

    End {   }
}

