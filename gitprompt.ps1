# Background colors
$GitPromptSettings.AfterStash.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.AfterStatus.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BeforeIndex.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BeforeStash.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BeforeStatus.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BranchAheadStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BranchBehindAndAheadStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BranchBehindStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BranchColor.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BranchGoneStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.BranchIdenticalStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.DefaultColor.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.DelimStatus.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.ErrorColor.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.IndexColor.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.LocalDefaultStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.LocalStagedStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.LocalWorkingStatusSymbol.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.StashColor.BackgroundColor = [ConsoleColor]::DarkBlue
$GitPromptSettings.WorkingColor.BackgroundColor = [ConsoleColor]::DarkBlue

# Foreground colors
$GitPromptSettings.AfterStatus.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.BeforeStatus.ForegroundColor = [ConsoleColor]::White
$GitPromptSettings.BranchColor.ForegroundColor = [ConsoleColor]::White
$GitPromptSettings.BranchGoneStatusSymbol.ForegroundColor = [ConsoleColor]::Red
$GitPromptSettings.BranchIdenticalStatusSymbol.ForegroundColor = [ConsoleColor]::White
$GitPromptSettings.DefaultColor.ForegroundColor = [ConsoleColor]::Gray
$GitPromptSettings.DelimStatus.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.IndexColor.ForegroundColor = [ConsoleColor]::Green
$GitPromptSettings.WorkingColor.ForegroundColor = [ConsoleColor]::Yellow

# Prompt shape
$GitPromptSettings.AfterStatus.Text = " "
$GitPromptSettings.BeforeStatus.Text = "  "
$GitPromptSettings.BranchAheadStatusSymbol.Text = ""
$GitPromptSettings.BranchBehindStatusSymbol.Text = ""
$GitPromptSettings.BranchBehindAndAheadStatusSymbol.Text = "⇕"
$GitPromptSettings.BranchGoneStatusSymbol.Text = ""
$GitPromptSettings.BranchIdenticalStatusSymbol.Text = ""
$GitPromptSettings.BranchUntrackedText = "※"
$GitPromptSettings.DelimStatus.Text = " ॥"
$GitPromptSettings.LocalStagedStatusSymbol.Text = "$"
$GitPromptSettings.LocalWorkingStatusSymbol.Text = ""
$GitPromptSettings.PathStatusSeparator = ""

$GitPromptSettings.EnableStashStatus = $false
$GitPromptSettings.ShowStatusWhenZero = $false