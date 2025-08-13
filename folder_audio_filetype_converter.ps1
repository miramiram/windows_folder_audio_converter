param (
        [string]$from            = "flac",
        [string]$to              = "mp3",
        [string]$in_path         = "",
        [string]$out_path        = "",
        [switch]$y               = $false,  # If set, skips confirmation dialog
        [switch]$dont_open_after = $false   # If set, doesn't open the converted folder after completing
      )


Function Get-Folder($initialDirector="")
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

        $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
            $foldername.Description = "Select a folder to flac-mp3 convert (placed in new subfolder)"
            $foldername.rootfolder = "MyComputer"
            $foldername.SelectedPath = $initialDirectory

            if($foldername.ShowDialog() -eq "OK")
            {
                return $foldername.SelectedPath 
            } else {
                return 1
            }
}


if($in_path -ne ""){
    Write-Path "the in_path arg feature is currently non-functional (at least for absolute paths), aborting."
    exit
    $folder = (Resolve-Path "$in_path").Path
    if (-not $?){
        $folder = (Resolve-Path -LiteralPath "$in_path").Path
        if (-not $?){
        exit
        }
    }
} else {
    $folder = Get-Folder $PsScriptRoot
        if($folder -eq 1){
            Write-Host "aborted"
            exit
        }
}

Write-Host "In folder:  $folder"

if(-not (Test-Path -LiteralPath "$folder")){
    Write-Host "Path wasn't valid, aborting"
    exit
}

if ($out_path -ne "") {
    $folder_out = (Resolve-Path "$out_path").Path
} else {
    $foldername = (($folder).Split("\")[-1])
    $outfoldername = "$($to)_$($foldername)"
    $folder_out = "$($folder)/$($outfoldername)"
}
Write-Host "Out folder: $folder_out"

$files = Get-ChildItem -LiteralPath "$folder" -Filter "*.$from"
if (-not $files) {
    Write-Host "No $from files found, aborting"
        exit
}

Write-Host "Files:"
foreach ($file in $files){
    Write-Host "    $file"
}

Write-Host "From type:  $($from)"
Write-Host "To type:    $($tO)"
Write-Host ""

if($y -ne $true){
    $confirmation = Read-Host "Proceed? [y/n] "
    if ($confirmation -notmatch "y") {
        Write-Host "aborted"
            exit
    }
}

New-Item -Path "$folder_out" -ItemType Directory

foreach ($file in $files){
    Write-Host "Converting: $($file)"
        $out_filepath = "$($folder_out)/$($file.Basename).$($to)"
        ffmpeg -i "$($file.FullName)" -ab 320k -map_metadata 0 -id3v2_version 3 "$($out_filepath)" -nostats -loglevel panic
}

if($dont_open_after -ne $true){
    explorer (Resolve-Path -LiteralPath "$folder").Path
}
Write-Host "Finished conversion"
