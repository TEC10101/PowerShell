$username = 'REDACTED'

$apps = @(
    [pscustomobject]@{Name = 'chrome'; Loc = "C:\Program Files\Google\Chrome\Application\chrome.exe"}
    [pscustomobject]@{Name = 'outlook'; Loc = "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"}
    [pscustomobject]@{Name = 'code'; Loc = "C:\Users\'+$username+'\AppData\Local\Programs\Microsoft VS Code\bin\code.cmd"}
    [pscustomobject]@{Name = 'devenv'; Loc = "C:\Users\'+$username+'\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Visual Studio 2019.lnk"}
    [pscustomobject]@{Name = 'teams'; Loc = "C:\Users\'+$username+'\AppData\Local\Microsoft\Teams\Update.exe"}
    [pscustomobject]@{Name = 'microsoft.notes'; Loc = "C:\Program Files\WindowsApps\Microsoft.MicrosoftStickyNotes_4.2.2.0_x64__8wekyb3d8bbwe\Microsoft.Notes.exe"}
    [pscustomobject]@{Name = 'onenote'; Loc = "C:\Program Files\Microsoft Office\root\Office16\ONENOTE.EXE"}
 )

 for ($i = 0; $i -lt $apps.Count; $i++) {
    $app = Get-Process $apps[$i].Name -ErrorAction SilentlyContinue
    if (!$app) {
        start $apps[$i].Loc
        $apps[$i].Name + " starting up..."
    } else {
        $apps[$i].Name + " already running..."
    }
}

Start-Sleep -Seconds 3

Remove-Variable apps