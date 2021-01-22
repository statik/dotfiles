# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme KindlyOps
# . (Join-Path -Path (Split-Path -Parent -Path $PROFILE) -ChildPath 'Set-SolarizedDarkColorDefaults.ps1')
if ($env:AWS_VAULT) {
  $prompt += Write-Prompt $env:AWS_VAULT -ForegroundColor White -BackgroundColor DarkMagenta
}