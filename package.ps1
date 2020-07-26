param($release_version=$(throw "You must specify a release version (see https://github.com/bblanchon/pdfium-binaries/releases), e.g. 4194"))
$spArgs = @{
      "FilePath" = "$env:ChocolateyInstall\bin\choco.exe"
      "ArgumentList" = "install 7zip"
      "NoNewWindow" = $true
      "Wait" = $true
}
Start-Process @spArgs
$spArgs = @{
      "FilePath" = "$env:ChocolateyInstall\bin\choco.exe"
      "ArgumentList" = "install curl"
      "NoNewWindow" = $true
      "Wait" = $true
}
Start-Process @spArgs
$spArgs = @{
      "FilePath" = "$env:ChocolateyInstall\bin\choco.exe"
      "ArgumentList" = "nuget.commandline"
      "NoNewWindow" = $true
      "Wait" = $true
}
Start-Process @spArgs
Set-Variable -Name "base_url" -Value "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/$release_version/"
$releases = @('pdfium-windows-x64-v8','pdfium-windows-x64','pdfium-windows-x86-v8','pdfium-windows-x86')
$nuget = @('x86_64.v8-xfa','x86_64.no_v8-no_xfa','x86.v8-xfa','x86.no_v8-no_xfa')
Remove-Item –path pack –recurse
new-item pack -itemtype directory
Set-Location pack
for($i = 0; $i -lt $releases.length; $i++)
{
    Set-Variable -Name "release" -Value $releases[$i]
    Set-Variable -Name "release_url" -Value $base_url$release.zip
    Write-Host "Downloading $release_url"
    $spArgs = @{
      "FilePath" = "$env:ChocolateyInstall\bin\curl.exe"
      "ArgumentList" = "-L -O $release_url"
      "NoNewWindow" = $true
      "Wait" = $true
    }
    Start-Process @spArgs
    new-item $release -itemtype directory
    Set-Location $release
    Write-Host "Expanding $release"
    $spArgs = @{
      "FilePath" = "$env:ChocolateyInstall\bin\7z.exe"
      "ArgumentList" = "x ..\$release.zip"
      "NoNewWindow" = $true
      "Wait" = $true
    }
    Start-Process @spArgs
    Set-Variable -Name "nuspec" -Value $nuget[$i]
    Write-Host "Packaging $nuspec"

    Write-Host "pack ..\..\nuget\PdfiumViewer.Native.$nuspec.nuspec -version $release_version -NoPackageAnalysis -NonInteractive -OutputDirectory .."

    $spArgs = @{
      "FilePath" = "$env:ChocolateyInstall\bin\nuget.exe"
      "ArgumentList" = "pack ..\..\nuget\PdfiumViewer.Native.$nuspec.nuspec -version $release_version -NoPackageAnalysis -NonInteractive -OutputDirectory .."
      "NoNewWindow" = $true
      "Wait" = $true
    }
    Start-Process @spArgs
    Set-Location ..
}
Set-Location ..