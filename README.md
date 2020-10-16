# NUCPC

NUC PC
​
 
PC Name – SiteCodeTRSRoomName


Make sure you the Time/Date correct and Timezone is updated
Change NTP Server - 172.17.32.253 or 132.189.40.119
 
Install Logitech Sync – Link

Install VNC Viewer

Enable Remote Desktop


Execute this command in NUC PC

Commands in the elevated Powershell:

Enable-PSRemoting -SkipNetworkProfileCheck -Force
Set-Item WSMan:\localhost\Client\TrustedHosts * -Force
Restart-Service WinRM
Get-Item WSMan:\localhost\Client\TrustedHosts
 
Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private
Set-NetFirewallProfile -Profile Private -Enabled False


Test-WSMan {enter ComputerName or IP Address}
winrs -r:IP Address or Computername -u:Computername\admin -p:password cmd or powershell

Commands in the elevated command prompt:
netsh advfirewall firewall add rule name="ICMP allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow

This command will stop windows update
net stop wuauserv
net stop bits
net stop dosvc
sc config wuauserv start=disabled

If you want to re-enable the Windows updates at any later time, then give these commands in the elevated command prompt:
sc config wuauserv start=auto
sc start wuauserv
net start wuauserv
net start bits
net start dosvc

Schedule automatic restart
schtasks /create /sc daily /tn "Daily auto force reboot" /tr "c:\windows\system32\shutdown.exe /t 0 /r /f" /st 23:59

shutdown /t 0 /r /f

FFMPEG command
Logitech Rally System
ffmpeg -f dshow -i video="Logi Rally Camera":audio="Echo Cancelling Speakerphone (3- Logi Rally Audio)" LRally.mp4

Logitech Meetup System
ffmpeg -f dshow -i video="Logitech MeetUp":audio="Echo Cancelling Speakerphone (Logitech MeetUp Speakerphone)" LMeetup.mp4

TRS.BAT
@echo off
rem net use x: \\fileserver\Sharefolder /user:domain\username password-here
c:
mkdir c:\ffmpeg
cd\ffmpeg
curl https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-20200324-e5d25d1-win64-static.zip -O ffmpeg
powershell expand-archive -path "c:\ffmpeg\ffmpeg-20200324-e5d25d1-win64-static.zip" -DestinationPath c:\ffmpeg\
copy c:\ffmpeg\ffmpeg-20200324-e5d25d1-win64-static\bin\*.* c:\ffmpeg\
ffmpeg -list_devices true -f dshow -i dummy
Rem  the command below will only record meetup camera without audio.
ffmpeg -f dshow -i video="Logitech MeetUp" meetupcam.mp4
Rem this will only record video without audio.  => ffmpeg -f dshow -i video="Logi Rally Camera" Rallycam.mp4
copy webcam.mp4 x:\it\filename

 
Sample command for capturing Video and Audio with Logitech Rally Plus System

                               [ Using Logitech Rally       ]                     [Using Logitech Rally Plus Microphones                             ]  Filename 4 output         
ffmpeg -f dshow -i video="Logi Rally Camera" -f dshow -i audio="Echo Cancelling Speakerphone (Logi Rally Audio)" output.mp4


Manually update MTR apps via Powershell command
 
See section (Software updates) via Powershell
https://docs.microsoft.com/en-us/microsoftteams/rooms/rooms-operations
 
Note the trick is to download the updated MSI from the endpoint itself, while logged in with admin.

After you download the latest MSI install it, leave it as default location for installation folder. (Microsoft Teams Room App v4.5.35.0)
Once installation is complete then create new share, follow the instruction below
    Open Explorer in C:\Program Files (x86)
    Now select and right click on “Skype Room System Deployment Kit” folder, select properties, click tab Sharing, click Advanced Sharing.
    Click Share this folder, in Share name: called it MTR, click permissions, check allow for Full control, change and read. Click Apply, ok, apply.
Now right click windows logo in the lower left corner, select Windows Powershell(admin).
In the Powershell Window Terminal, create new map to x by using net use example below

Just copy and paste the command below to your powershell window
 
copy and paste the command, then press enter to execute it.
 
Net use x: \\localhost\mtr

Now let’s do the update by copying the command below and pasting it to your powershell window
 
copy and paste the command, then press enter to execute it.

Add-AppxPackage  -ForceApplicationShutdown -Path 'x:\$oem$\$1\Rigel\x64\Ship\AppPackages\*\*.appx' -DependencyPath (Get-ChildItem 'x:\$oem$\$1\Rigel\x64\Ship\AppPackages\*\Dependencies\x64\*.appx' | Foreach-Object {$_.FullName})
 

Once it’s complete reboot the MTR system, it will reboot twice 
That’s it, you done.

Logitech Recommended NUC updates process.

There are a few primary things that need to be done to alleviate this situation but I am going to provide you the recommended list of NUC updates that are recommended to minimize Teams related system issues.

Recommended NUC updates process
On the NUC PC perform the following steps: (We recommend that the NUC power settings be set to always On never shutdown due to Tap Screen going to sleep and not waking due to Intel Power management of the internal motherboard USB/HDMI ports.

A. Boot into the Windows Admin account and change the Power setting (see attached) Note the power settings may be different depending on the version of Windows 10 your are using. The Intel Motherboard has power save options enabled that reduce power to sections of the circuits which cause issues with the displays and USB connections. So all power save options must be disabled.

In addition to the power setting changes on the attached document Microsoft has recently recommended going into the Device Manager and  then disable the "turn this device off to save power" feature on all USB Root Hubs on a given device. Select the USB Controllers - Root Hub device then right click then select "Properties" then select the "Power management" tab and un-check " Allow computer to turn this device off to save power".

Boot into Windows
To boot into Windows connect a Keyboard to the NUC then reboot it while it is coming up tap the Windows Key over and over until the Windows Login comes up on the screen. The select the Teams Admin account - password is sfb once completed with changes logout then login to the User account same password.

B.. Install the intel driver and support assistant (Intel DSA) in the Windows Admin account and run the Intel Device Driver Assistant to ensure that the NUC is running the most updated versions of all required drivers.

Link - https://www.intel.com/content/www/us/en/support/detect.html

C. Update the NUC HDMI driver: (alleviates Teams related display issues)

https://downloadcenter.intel.com/download/29472/HDMI-Firmware-Update-Tool-for-NUC8i3BE-NUC8i5BE-NUC8i7BE?v=t

Note - Please ensure ALL instructions for followed when updating the HDMI drivers. Specifically, an HDMI device must be connected to the NUC HDMI port and powered on. These instructions can be found in the extracted driver folder or at this link.

D. Update the Displaylink device drivers https://www.displaylink.com/downloads/windows then select "DisplayLink USB Graphics Software for Windows" Download and install these make sure the Tap is connected and functional as these manage the Tap display.

E: Update the Intel NUC BIOS:

https://downloadcenter.intel.com/product/126148/Intel-NUC-Kit-NUC8i5BEH

F: Setup a second nightly reboot to ensure the Teams Room is up and ready after any windows/teams updates occurring during the night. As an example, if the Teams nightly reboot is set for 2 or 3 AM, adding one at 7 AM shortly before the office opens should ensure stability. I've also include the steps below to add another reboot task.

Press WinKey+R > type taskschd.msc and press Enter (it will launch Task Scheduler)
Left click from the right pane on the Task Scheduler Library > open Action from the top menu > New Folder... > name it MyTasks > click OK
Left click on the MyTasks > choose Action from menu > Create Basic Task... (it will open task wizard)
You can enter the Name , for example "Restart", and press Next
In Trigger section you can specify when you want to run your task, for example:
Select Daily , and press Next
Now you can specify the day, the hour and set to recur every day, after that press Next
In Action section you can choose what you want to run, for example restart your system, to do this:
choose Start a program , and press Next
in the Program/script field type shutdown /r , and press Next
And that's all, you can press Finish
