@echo off

if "%1" == "" (
	set dest="%cd%\out"
) else (
	set dest=%1
)

if not exist %dest% (
	md %dest%
)

docker container run --rm -d -v "%dest%":"c:\wd" iankoulski/do-git /gitcp.sh https://github.com/iankoulski/depend-on-docker/tree/to/windows "c:\wd"

