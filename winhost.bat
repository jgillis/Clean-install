@echo off

if exist "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" (
    set vboxpath = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
) else (
    rem file doesn't exist
)
if "%vboxpath%" == "" set /p vboxpath= Enter the full path to VBoxManage.exe:
 
set /p vboxname= Enter the name of your vbox: 

if exist "C:\gateway"
  rem do nothing
) else (
  mkdir "C:\gateway"
)
"%vboxpath%" sharedfolder add "%vboxname%" --name "gateway" --hostpath "C:\gateway"
echo "Created gateway"

"%vboxpath%" setextradata "%vboxname%" "VBoxInternal/Devices/e1000/0/LUN#0/Config/ssh/GuestPort" 22
"%vboxpath%" setextradata "%vboxname%" "VBoxInternal/Devices/e1000/0/LUN#0/Config/ssh/HostPort" 2223
"%vboxpath%" setextradata "%vboxname%" "VBoxInternal/Devices/e1000/0/LUN#0/Config/ssh/Protocol" TCP
echo "Mapped 2223 to 22"


