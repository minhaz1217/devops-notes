@echo off 
@REM The absolute path the git directory is in
set git_directory=D:\MyComputer\website\c#\simple dotnet app

@REM The relative directory from the git diretory to the project diretory
@REM relative diretory of project to build
set project_to_build_relative_path=\simple dotnet app

set project_to_build=%git_directory%%project_to_build_relative_path%
set output_directory=%git_directory%%project_to_build_relative_path%\publish\output

echo %project_to_build_path%
@REM echo %git_directory% %project_to_build_path%
echo %output_directory%


@REM @REM Change git branch

@REM @REM Build the project
dotnet publish -c Release --no-self-contained -r linux-x64 -o "%output_directory%" "%project_to_build%"

@REM dotnet publish -c Release -f netcoreapp3.1 --no-self-contained -r linux-x64 -o %output_directory% %project_to_build%


@REM @REM Copy additional files
@REM @REM xcopy /E /Y %inputDir%\Views %outputDir%\Views

@REM Upload the project
wsl.exe -d Ubuntu -u root sudo rsync -avzh -e "ssh -i \"/mnt/c/Users/HA HA/amazon_key\"" "/mnt/d/MyComputer/website/c#/simple dotnet app/simple dotnet app/publish/output/" ubuntu@65.0.181.197:"~/project"

@REM Working directly from the wsl
@REM rsync -avzh -e "ssh -i \"/mnt/c/Users/HA HA/amazon_key\"" "/mnt/d/MyComputer/website/c#/simple dotnet app/simple dotnet app/publish/output/" ubuntu@65.0.181.197:"~/project"

@REM ssh -i "/mnt/c/Users/HA HA/amazon_key" ubuntu@65.0.181.197:~/project
@REM chmod 400 amazon_key -f
@REM Start or restart the app