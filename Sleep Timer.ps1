# Docs here: https://docs.microsoft.com/en-us/sysinternals/downloads/psshutdown
# My intention is to make a thing I can interrupt or reset.
# If I interrupt, I can give a 1-9 selection of options immediately for new timer, and an exit.
# Can I show a countdown timer?
# Can I pop up a 2 min warning for 3 sec?
# psshutdown -d -t 10

# Needs admin priv
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

# Ask, how many minutes to shutdown?
[decimal]$SleepTimeInMins = Read-Host "How many minutes until you want to sleep?"
[int]$Time = [int][Math]::Ceiling($SleepTimeInMins * 60)
#[int]$Time = 1 # DEBUG
$Length = $Time / 100
For ($Time; $Time -gt 0; $Time--) {
$min = [int](([string]($Time/60)).split('.')[0])
$text = " " + $min + " minutes " + ($Time % 60) + " seconds left"
Write-Progress -Activity "Watiting for..." -Status $Text -PercentComplete ($Time / $Length)
Start-Sleep 1
}
#Read-Host -Prompt
# Create a new SpVoice objects
$voice = New-Object -ComObject Sapi.spvoice

# Set the speed - positive numbers are faster, negative numbers, slower
$voice.rate = 0
$voice.Volume = 20
foreach ($v in $voice.GetVoices()) {
$voice.Voice = $v;
}

# Say something
$voice.speak("Going to sleep")
psshutdown -d -c -t 15