# A function to display a small unobtrusive form to capture context.

function Show-ContextWindow {
    [CmdletBinding()]
    Param (
        # Help description for Param 1.
        [Parameter(Mandatory=$true,
                   Position=1,
                   ValueFromPipeline=$true)]
        $Param1,
        # Help description for Param 2.
        [int]
        $Param2
    )

    Begin {   }

    Process {



        $Global:AWMContextForm = New-Object system.Windows.Forms.Form

        $Global:AWMContextForm.Size =

        $Form.ShowDialog()

    }

    End {   }
}