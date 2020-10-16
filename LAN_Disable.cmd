@echo off
cls
netsh interface set interface "Ethernet 2" enable
netsh interface show interface
@echo off
pause