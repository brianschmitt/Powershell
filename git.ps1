# Requires my version of PoshGit to work properly https://github.com/brianschmitt/posh-git
# this version supports passing a folder to the various commands
function Write-FolderStatus {
	param([Parameter(Mandatory=$true, HelpMessage="Folders to process")]$folder)
	$status = Get-GitStatus $folder
	if ($status.HasWorking -or $status.HasIndex -or $status.AheadBy -ne 0 -or $status.BehindBy -ne 0) {
		Write-Host $folder -NoNewline
		Write-GitStatus $status
		Write-Host
	}
}

function Get-Origin {
	param([Parameter(Mandatory=$true, HelpMessage="Folders to process")]$folder)
	git -C $folder fetch origin --quiet # *> $nul
}

function Get-GitFolders() {
	return Get-ChildItem -Directory -Filter .git -Hidden -Recurse -ErrorAction SilentlyContinue | select -expand parent | select -ExpandProperty fullname
}

function Find-Unsynced() {
	Get-GitFolders | % { Get-Origin $_; Write-FolderStatus $_ }
}