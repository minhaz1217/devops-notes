@echo off 
@REM The branch we will be building and publishing.
set git_branch=staging

@REM Setting up the git location + csproj location + output location
set git_directory_drive=D:
set git_directory_drive_wsl=/mnt/d
set project_relative_path_to_drive=\MyComputer\website\c#\simple dotnet app
set project_to_build_relative_path=\simple dotnet app
set output_relative_path=/bin/publish


set git_directory=%git_directory_drive%%project_relative_path_to_drive%


set project_relative_path_to_drive_wsl=%project_relative_path_to_drive:\=/%
set project_to_build_relative_path_wsl=%project_to_build_relative_path:\=/%
set relative_output_directory_wsl=%relative_output_directory:\=/%
set output_relative_path_wsl=%output_relative_path:\=/%
set published_folder_wsl="%git_directory_drive_wsl%%project_relative_path_to_drive_wsl%%project_to_build_relative_path_wsl%%output_relative_path_wsl%"

set private_key_drive_wsl=/mnt/c
set private_key_relative_location_to_drive=\Users\HA HA\amazon_key
set private_key_relative_location_to_drive_wsl=%private_key_relative_location_to_drive:\=/%
set private_key_wsl_location=%private_key_drive_wsl%%private_key_relative_location_to_drive_wsl%

set remote_host=15.207.249.72
set remote_user=ubuntu
set remote_location="~/project"

set app_dll_file=simple dotnet app.dll
set app_port=5000


set project_to_build=%git_directory%%project_to_build_relative_path%
set output_directory=%git_directory%%project_to_build_relative_path%%output_relative_path_wsl%

echo %project_to_build_path%
@REM echo %git_directory% %project_to_build_path%
echo %output_directory%

@REM At first stash all current changes, if needed.
@REM git -C "%git_directory%" stash

@REM @REM Change git branch
git -C "%git_directory%" checkout %git_branch%

git -C "%git_directory%" pull origin %git_branch%

@REM @REM Build the project
echo "Building the project: %project_to_build%"
@REM dotnet publish -c Release --no-self-contained -r linux-x64 -o "%output_directory%" "%project_to_build%"

@REM dotnet publish -c Release -f netcoreapp3.1 --no-self-contained -r linux-x64 -o %output_directory% %project_to_build%


@REM @REM Copy additional files
@REM @REM xcopy /E /Y %inputDir%\Views %outputDir%\Views

@REM Upload the project
wsl.exe -d Ubuntu -u root sudo rsync -avzh -e "ssh -i \"%private_key_wsl_location%\"" %published_folder_wsl% %remote_user%@%remote_host%:%remote_location%

@REM Working directly from the wsl
@REM rsync -avzh -e "ssh -i \"/mnt/c/Users/HA HA/amazon_key\"" "/mnt/d/MyComputer/website/c#/simple dotnet app/simple dotnet app/publish/output/" ubuntu@65.0.181.197:"~/project"

@REM ssh -i "/mnt/c/Users/HA HA/amazon_key" ubuntu@65.0.181.197:~/project
@REM chmod 400 amazon_key -f
@REM Stop the app 
wsl.exe -d Ubuntu -u root sudo ssh -i "%private_key_wsl_location%" %remote_user%@%remote_host% "sudo lsof -ti:%app_port% | sudo xargs kill -9"


@REM Start the app
wsl.exe -d Ubuntu -u root sudo ssh -i "%private_key_wsl_location%" %remote_user%@%remote_host% "cd %remote_location%; /snap/dotnet-sdk/current/dotnet \"%app_dll_file%\""

@REM If added via apt install
@REM wsl.exe -d Ubuntu -u root sudo ssh -i "%private_key_wsl_location%" %remote_user%@%remote_host% "cd ~/project; /bin/dotnet \"%app_dll_file%\""


@REM another way to execute remote command
@REM wsl.exe -d Ubuntu -u root sudo ssh -i "%private_key_wsl_location%" %remote_user%@%remote_host% 'bash -i -c "cd %remote_location%;npm run start"'


@REM Now get out of the console via CTRL + C, and the server will be running.