


function Unregister-EventFocusMonitor {
    [CmdletBinding()]
    Param (   )

    Begin {   }

    Process {

        if ($null -ne $Script:ActiveWindowMonitor) {

            Try {
                "WatcherJob count: $($Script:TMOptions.WatcherJob.count)" | Write-Verbose

                Get-EventSubscriber | Where-Object {$_.SourceIdentifier -in $Script:TMOptions.WatcherJob.Name} | Unregister-Event -Force
                "WatcherJob count(After Unregister): $($Script:TMOptions.WatcherJob.count)" | Write-Verbose
                #$Script:TMOptions.WatcherJob = $null


                $Script:ActiveWindowMonitor.Dispose()
            } catch {
                throw $_
            }

        } else {
            Write-Warning "A Window Focus monitor does not currently exist. Maybe you forgot to Start-TMWatcher?"
        }

    }

    End {   }
}

