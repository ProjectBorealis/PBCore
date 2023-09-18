param (
  $version = "patch"
)

Push-Location $PSScriptRoot\..

try { Remove-Item -Path Binaries -Recurse -ErrorAction stop }
catch [System.Management.Automation.ItemNotFoundException] { $null }

git pull

.\PBSync.exe --autoversion $version --build source --build package

.\PBSync.exe --sync engine

$commitHash = git rev-parse --short HEAD | Out-String
git add .checksum
git commit -am "chore(version): $version release from $commitHash"

git pull
git push

.\PBSync.exe --build release

Pop-Location
