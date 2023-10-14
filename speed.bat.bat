@echo off

rem Collect the MAC address and IP address of the Ethernet over Ethernet adapter
for /f "tokens=2 delims=:" %%a in ('getmac ^| find "Ethernet over Ethernet"') do set mac=%%a
for /f "tokens=2 delims=() " %%a in ('arp -a ^| find "Ethernet over Ethernet"') do set ip=%%a

rem Run the ping, traceroute, and pathping commands
echo Running ping, traceroute, and pathping...
ping -n 100 180.181.127.100 > ping_180.181.127.100.txt
tracert 180.181.127.100 > tracert_180.181.127.100.txt
ping -n 100 google.com > ping_google.com.txt
pathping 180.181.127.100 > pathping_180.181.127.100.txt

rem Create a directory on the desktop and save the output to a text file
md %userprofile%\Desktop\Output
echo MAC address: %mac% > %userprofile%\Desktop\Output\output.txt
echo IP address: %ip% >> %userprofile%\Desktop\Output\output.txt
echo. >> %userprofile%\Desktop\Output\output.txt
type ping_180.181.127.100.txt >> %userprofile%\Desktop\Output\output.txt
echo. >> %userprofile%\Desktop\Output\output.txt
type tracert_180.181.127.100.txt >> %userprofile%\Desktop\Output\output.txt
echo. >> %userprofile%\Desktop\Output\output.txt
type ping_google.com.txt >> %userprofile%\Desktop\Output\output.txt
echo. >> %userprofile%\Desktop\Output\output.txt
type pathping_180.181.127.100.txt >> %userprofile%\Desktop\Output\output.txt

echo Done!