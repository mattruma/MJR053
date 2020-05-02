param (
    [string]$Name,
    [bool]$SkipBuild=$false
)

if ($Name.Trim() -eq "" ) {     
    throw "Name is required, either enter as a prompt or provide a value for the -Name argument"
}

$ResourceGroupName = "$($Name)-rg"

if ($SkipBuild -eq $false) {

    for ($Index = 1; $Index -le 2; $Index++) {
        $ProjectName = "WebApplication$($Index)"
        $WebAppName = "$($Name)-app-00$($Index)"

        Write-Host "Project : $($ProjectName)" -ForegroundColor Blue
        Write-Host "Web App : $($WebAppName)" -ForegroundColor Blue

        dotnet build ".\$($ProjectName)\" -c Release
        dotnet publish ".\$($ProjectName)\" -c Release

        $SourcePath = ".\$($ProjectName)\bin\Release\netcoreapp3.1\publish\*"
        $ArchiveFileName = ".\$($ProjectName)\bin\Release\netcoreapp3.1\$($ProjectName).zip"

        Compress-Archive -Path $SourcePath -DestinationPath $ArchiveFileName -Force

        Publish-AzWebapp -ResourceGroupName $ResourceGroupName -Name $WebAppName -ArchivePath $ArchiveFileName -Force
    }  

}

New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile ".\WebApplication1ApiManagementConfiguration.json"