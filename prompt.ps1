$global:lastColor = ""

$defaultBackground = "Black"
$defaultFore = "White"
$adminColor = "Red"
$nonAdminColor = "Green"
$location = "Cyan"
$locationFore = "Black"
$errorFore = "Yellow"
$errorBack = "DarkRed"

$usePoshGit = [bool](Get-Module posh-git)
$useVSTeam = [bool](Get-Module vsteam)

function prompt {
    [Console]::ResetColor()
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    function Write-Title() {
        $title = (get-location).Path.replace($home, "~")
        $idx = $title.IndexOf("::")
        if ($idx -gt -1) { $title = $title.Substring($idx + 2) }
        $host.UI.RawUI.WindowTitle = $title
    }

    function Write-Segment() {
        param($value, $back = $defaultBackground, $fore = $defaultFore)

        if ($global:lastColor -eq "") {
            $global:lastColor = $back
        }
        Write-Host "" -NoNewline -BackgroundColor $back -ForegroundColor $global:lastColor

        if ($null -ne $back) {
            Write-Host "$value" -NoNewLine -ForegroundColor $fore -BackgroundColor $back
        }
        else {
            Write-Host "$value" -NoNewLine -ForegroundColor $fore
        }

        $global:lastColor = $back
    }

    function Write-User() {
        $windowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
        $windowsPrincipal = new-object 'System.Security.Principal.WindowsPrincipal' $windowsIdentity
        if ($windowsPrincipal.IsInRole("Administrators") -eq 1) { $color = $adminColor; }
        else { $color = $nonAdminColor; }
        #Write-Segment $env:UserName@$env:computername $color Black
        Write-Segment $env:UserName $color Black
    }

    function Write-GitStatus() {
        if ($usePoshGit) {
            if (Get-GitStatus -ne $null) {
                Write-Segment "" $GitPromptSettings.AfterBackgroundColor
                Write-VcsStatus
                $global:lastColor = $GitPromptSettings.AfterBackgroundColor
            }
        }
        else {
            $exitCode = $global:LASTEXITCODE
            $inGitRepo = (git rev-parse --is-inside-work-tree)
            $global:LASTEXITCODE = $exitCode
            if ($inGitRepo) {
                $status = git status --porcelain --ignore-submodules
                $dirty = $status.Length -ne 0
                $branch = git rev-parse --abbrev-ref HEAD
                if ($dirty) {    
                    $back = "DarkRed"
                }
                else { 
                    $back = "DarkBlue"
                }
                Write-Segment " $branch " $back
            }
        }
    }

    function Write-Location() {
        Write-Segment " $pwd " $location $locationFore
    }

    function Write-OpenPullRequests() {
        if ($useVSTeam) {
            $count = (Get-VSTeamPullRequest | Where-Object {$_.reviewstatus -eq 'Pending'} | Measure).Count
            Write-Segment "  $count " $errorFore $locationFore
        }
    }

    function Write-SystemStatus() {
        if ($LASTEXITCODE -ne 0) {
            Write-Segment "  $LASTEXITCODE " $errorBack $errorFore
        }

        if ($null -ne $PromptEnvironment) {
            Write-Segment $PromptEnvironment DarkMagenta
        }

        $global:LASTEXITCODE = 0

        if ((get-location -stack).Count -gt 0) {
            Write-Segment (("+" * ((get-location -stack).Count))) DarkGray $location
        }
    }

    function Write-End() {
        Write-Segment
    }

    Write-Title
    Write-User
    Write-SystemStatus
    Write-Location
    Write-OpenPullRequests
    Write-GitStatus
    Write-End

    $global:lastColor = ""

    return " "
}