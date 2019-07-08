# A helper function to be ran during an event notification.
# The current window is captured, and held until the next window is activated.
# When the current window is changed, the previous window has the time spent added, and then added to the activity logging queue.

function Receive-EventFocusActivity {
    [CmdletBinding()]
    Param (
        # The object with details of the event
        [Parameter(Mandatory=$false,
                   Position=0)]
        $CurrentEvent

    )

    Begin {   }

    Process {

        # Use ModuleName if WindowTitle is not available.
        # Applications with this issue: Explorer.exe
        if ( $CurrentEvent.Sender.WindowTitle -eq "" ) {

            $WindowTitle = $CurrentEvent.Sender.ModuleName

        # If Explorer is showing current folder name, include "Windows Explorer" after the title.
        #TODO: Move this step to post processing.
        } elseif ( $currentEvent.Sender.ModuleName -eq "Explorer.EXE" ) {

            $WindowTitle = "{0} - Windows Explorer" -f $CurrentEvent.Sender.WindowTitle

        } else {

            $WindowTitle = $CurrentEvent.Sender.WindowTitle

        }

        if ( $WindowTitle -in @("Task Switching", "SearchUI.exe") ) {
            # Do nothing, don't count time towards switching applicaitons via Task Switcher.
        } elseif ( $CurrentEvent.Sender.ProcessID -eq $Script:rawPreviousEvent.Sender.ProcessID ) {
            # Do nothing, duplicate process captured...
        } else {

            # Capture the current window information.
            $currentWindow = [PSCustomObject]@{
                Start       = $CurrentEvent.TimeGenerated
                ProcessID   = $CurrentEvent.Sender.ProcessID
                ModuleName  = $CurrentEvent.Sender.ModuleName
                WindowTitle = $WindowTitle
                Context     = $Script:ActivityContext
            }

            # If there was a previous window captured, add time spend active, then add to the activity logging queue.
            if ( $null -ne $Script:previousWindow ) {

                # Add the time spent on the previous window.
                $Script:previousWindow | Add-Member -Name Timespan -Value $($currentWindow.Start - $Script:previousWindow.Start) -MemberType NoteProperty
                $Script:previousWindow | Add-Member -Name Stop -Value $($currentWindow.Start) -MemberType NoteProperty

                # Queue the object for logging.
                $Global:ActivityQueue.enqueue( $Script:previousWindow )

                "{0} - ({1:N2} Secs) - Previous Window: {2}" -f $Script:previousWindow.Start, $Script:previousWindow.Timespan.TotalSeconds, $Script:previousWindow.WindowTitle |
                Write-Verbose

            } else {
                $Script:previousWindow | Add-Member -Name Timespan -Value $([timespan]"00:00") -MemberType NoteProperty
            }

            # Prepare the current window to be the new previous window.
            $Script:previousWindow = $currentWindow

            # Perform a deep copy of the event and store as previous event.
            $Script:rawPreviousEvent = $CurrentEvent | ConvertTo-Json | ConvertFrom-Json

            # Add the recent event to the recent event queue.
            $Global:RecentEventObj.enqueue( $Script:rawPreviousEvent )

            # Keep only the most recent 5 events, pop the 6th one off.
            if ( $Global:RecentEventObj.count -gt 5 ) {
                $Global:RecentEventObj.dequeue() | Out-Null
            }

        }

    }

    End {   }
}