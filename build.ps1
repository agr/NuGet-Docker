param (
    [Parameter(Mandatory=$true)]
    $CertificateLocation,
    [Parameter(Mandatory=$true)]
    $CertificatePassword,
    [Parameter(Mandatory=$true)]
    $CertificateThumbprint
)

$root = $PSScriptRoot;
$build_output = Join-Path $root build_output;
$gallery_output = Join-Path $build_output NuGetGallery;

#Set-Location $root;
#New-Item -Type Directory -Name build_output -Force;
#Remove-Item build_output\* -Recurse;

#Set-Location build;
#docker.exe build -t gallery-build .;
#docker.exe run --rm -v "$($build_output):c:\output" gallery-build;

#Set-Location ..;
robocopy.exe /E $gallery_output gallery-standalone\in\NuGetGallery;
Set-Location gallery-standalone

Copy-Item $CertificateLocation in\;

$dockerfile = Get-Content .\Dockerfile.template;
$dockerfile = ($dockerfile -replace '<certificatePassword>',$CertificatePassword) -replace '<certificateThumbprint>',$CertificateThumbprint;

$dockerfile | Out-File Dockerfile -Encoding utf8

docker.exe build -t gallery-standalone .

Remove-Item Dockerfile

Set-Location ..