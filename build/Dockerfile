FROM mcr.microsoft.com/dotnet/framework/sdk:4.7.2

WORKDIR /install
ADD https://download.microsoft.com/download/4/B/7/4B7786CE-86E8-44C0-8FAD-5DB0BE3181B1/MicrosoftAzureLibsForNet-x64.msi MicrosoftAzureLibsForNet-x64.msi
ADD https://download.microsoft.com/download/4/B/7/4B7786CE-86E8-44C0-8FAD-5DB0BE3181B1/MicrosoftAzureAuthoringTools-x64.msi MicrosoftAzureAuthoringTools-x64.msi
ADD https://github.com/git-for-windows/git/releases/download/v2.21.0.windows.1/MinGit-2.21.0-64-bit.zip minigit.zip
RUN .\MicrosoftAzureLibsForNet-x64.msi /qn; Get-Process msiexec | Wait-Process; \
    Remove-Item .\MicrosoftAzureLibsForNet-x64.msi; \
    .\MicrosoftAzureAuthoringTools-x64.msi /qn; Get-Process msiexec | Wait-Process; \
    Remove-Item .\MicrosoftAzureAuthoringTools-x64.msi; \
    $path=$env:path + ';c:\git\cmd'; \
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $path; \
    Add-Type -AssemblyName System.IO.Compression.FileSystem; \
    [System.IO.Compression.ZipFile]::ExtractToDirectory('c:\install\minigit.zip', 'c:\git'); \
    Remove-Item .\minigit.zip; \
    cd \; \
    New-Item -Type Directory output;

ENTRYPOINT git.exe clone https://github.com/NuGet/NuGetGallery.git NuGetGallery; \
    cd NuGetGallery; \
    ((Get-Content .\build.ps1) -replace "2d8feecabe3aeaed7f5b4d50b9be78c94faf39ec","9952c2914a9ba2f31b5c4fba963ee989f59363bb") -replace '"15"','"16"' | Out-File -Encoding utf8 .\build.ps1; \
    .\build.cmd; \
    Remove-Item c:\output\* -Recurse; \
    robocopy.exe /E C:\install\NuGetGallery\src\NuGetGallery\api C:\output\NuGetGallery\api; \
    robocopy.exe /E C:\install\NuGetGallery\src\NuGetGallery\App_Code C:\output\NuGetGallery\App_Code; \
    robocopy.exe /E C:\install\NuGetGallery\src\NuGetGallery\App_Data C:\output\NuGetGallery\App_Data; \
    robocopy.exe /E C:\install\NuGetGallery\src\NuGetGallery\bin C:\output\NuGetGallery\bin; \
    robocopy.exe /E C:\install\NuGetGallery\src\NuGetGallery\Branding C:\output\NuGetGallery\Branding; \
    robocopy.exe /E C:\install\NuGetGallery\src\NuGetGallery\Content C:\output\NuGetGallery\Content; \
    robocopy.exe /E C:\install\NuGetGallery\src\NuGetGallery\Public C:\output\NuGetGallery\Public; \
    robocopy.exe /E C:\install\NuGetGallery\src\NuGetGallery\Scripts C:\output\NuGetGallery\Scripts; \
    robocopy.exe /E C:\install\NuGetGallery\src\NuGetGallery\Views C:\output\NuGetGallery\Views; \
    Copy-Item C:\install\NuGetGallery\src\NuGetGallery\Web.config C:\output\NuGetGallery\Web.config;
