Write-Output "+++ Installing Git… +++"
choco install git --yes

Write-Output "+++ Installing jq… +++"
choco install jq --yes

Write-Output "+++ Installing 7zip… +++"
choco install 7zip --yes

Write-Output "+++ Installing Visual Studio Build Tools - (version 2019)… +++"
choco install visualstudio2019-workload-vctools --yes

Write-Output "+++ Installing Python - (version 3.9.13)… +++"
choco install python --version = 3.9.13 --yes

Write-Output "+++ Installing Windows SDK - (version 10)… +++"
choco install windows-sdk-10.1 --yes

Write-Output "+++ Installing Java Runtime Environment - (version 11)… +++"
choco install temurin11jre --yes

Write-Output "+++ Installing Allure… +++"
scoop install allure