# A function to display a small unobtrusive form to capture context.

function Show-ContextWindow {
    [CmdletBinding()]
    Param (    )

    Begin {   }

    Process {

        $Script:TMOptions.Runspaces | Where-Object {$_.Type -eq "Form" -and $_.Status -ne "Running" } |
            ForEach-Object {
                $_.Pipe.EndInvoke($_.Status)
                $_.Pipe.Dispose()
            }

        $runspace = [powershell]::Create()
        $runspace.AddScript($scriptblock)
        $runspace.AddArgument($script:ContextData)
        $runspace.AddArgument($script:ActivityContext)

        $Script:TMOptions.Runspaces += [PSCustomObject]@{
            Pipe = $runspace
            Status = $runspace.BeginInvoke()
            Type = "Form"
        }
    }

    End {   }
}


$scriptblock = {

    param(
        [ref]
        $ContextData,
        [ref]
        $ActivityContext
    )

    Import-Module TimeManagement



    function Initialize-Form {

        param(
            [system.Windows.Forms.Form]
            $Form = $(New-Object system.Windows.Forms.Form)
        )

        $Form.Text = "Context Picker - Time Management"
        $Form.Size = [System.Drawing.Size]::new(320,65)
        $Form.ShowIcon = $false
        $Form.MinimizeBox = $false
        $Form.MaximizeBox = $false
        $Form.SetDesktopLocation(0,0)
        $Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle

        return $Form
    }

    function Initialize-ComboBox {

        param (
            [System.Windows.Forms.ComboBox]
            $ComboBox = $(New-Object System.Windows.Forms.ComboBox),
            [Parameter(Mandatory=$true,
                    Position=0)]
            $Form
        )

        $ComboBox.Size = [System.Drawing.Size]::new(300,21)

        # Show about 8 lines of options.
        $ComboBox.DropDownHeight = 120

        # Make the font a litle bigger.
        $ComboBox.font = [System.Drawing.Font]::new("Microsoft Sans Serif",9)

        Register-ObjectEvent -InputObject $ComboBox -EventName "SelectedValueChanged" -Action { Receive-SelectedValueChangedComboBox -Object $_ -EventObj $Event }

        Register-ObjectEvent -InputObject $ComboBox -EventName "DrawItem" -Action { Receive-DrawItemComboBox -Object $_ -EventObj $Event}

        $Script:ContextData | ForEach-Object {
            $ComboBox.Items.Add($_)
        }

        # Show values in the Context property.
        $ComboBox.DisplayMember = "Context"

        $Form.Controls.Add($ComboBox)

    }

    function Receive-DrawItemComboBox {
        param (
            $Object,
            [System.Windows.Forms.DrawItemEventArgs]
            $EventObj
        )

        $EventObj.DrawBackground()

        $contextLastUsed = ( $(Get-Date) - ([datetime]$Object.Items[$EventObj.Index].LastUsed) )

        $text = $object.Items[$EventObj.Index].Context

        $brush = New-Object System.Drawing.Brush
        if ( $contextLastUsed -gt $Script:TMOptions.HideContextOlderThanDays ) {
            $brush = [System.Drawing.Brushes]::DarkGray
        } else {
            $brush = [System.Drawing.Brushes]::Black
        }

        $EventObj.Graphics.DrawString($text, $Object.Font, $brush, $EventObj.Bounds.X, $EventObj.Bounds.Y)

    }

    function Receive-SelectedValueChangedComboBox {
        param (
            $Object,
            [System.EventArgs]
            $EventObj
        )

        $global:ComboBoxObject = $Object
        $global:ComboBoxEvent = $EventObj

        # Check if custom text has been entered.
        # A new context will be created then.
        if ($EventObj.Sender.SelectedIndex -eq -1) {

            $Script:ContextData.Add([PSCustomObject]@{
                Context = $EventObj.Sender.Text
                Type = $($EventObj.Sender.Text -split " " | Select-Object -First 1)
                LastUsed = $(Get-Date)
            })

        } else {
            $Script:ActivityContext = $EventObj.Sender.SelectedItem
        }


        "Item Selection - Index: {0}; Text: {1}; Value: {2};" -f $Object.SelectedIndex, $Object.SelectedText, $Object.SelectedValue
    }


    # Prepare the form.
    $Script:AWMContextForm = Initialize-Form
    Initialize-ComboBox -Form ($Script:AWMContextForm)

    # Display the form.
    $Script:AWMContextForm.ShowDialog()

    $Script:AWMContextForm.Dispose()
}

