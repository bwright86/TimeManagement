


function Register-EventFocusMonitor {
    [CmdletBinding()]
    Param (
        [switch]
        $Force
    )

    Begin {   }

    Process {

        if ($null -ne $Script:ActiveWindowMonitor) {

            $registerParams = @{
                InputObject = $Script:ActiveWindowMonitor
                EventName   = "Changed"
                Action      = { Receive-EventFocusActivity -CurrentEvent $Event }
            }
            $Script:TMOptions.WatcherJob = $(Register-ObjectEvent @registerParams)

            "WatcherJob count: $($Script:TMOptions.WatcherJob.count)" | Write-Verbose

        } else {
            Write-Warning "An Active Window Focus monitor was already created. If there is an issue, use -Force to create a new one."
        }

    }

    End {   }
}

