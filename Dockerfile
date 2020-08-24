FROM microsoft/iis:nanoserver

## New USER
RUN powershell -Command net user new-user-admin /ADD
RUN powershell -Command net localgroup administrators new-user-admin /a
USER new-user-admin

## Install .Net Core 3.1 SDK
WORKDIR /
COPY dotnet-install.ps1 .
RUN powershell -Command .\dotnet-install.ps1

## COPY Project Files
WORKDIR /WebAPI
COPY src .

## Build and Run Project
WORKDIR /WebAPI

# Set Path Temp
ENV ProgramFiles="C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Users\new-user-admin\AppData\Local\Microsoft\WindowsApps;C:\Users\new-user-admin\.dotnet\tools"

# Set the path Temp + Path dotnet
ENV PATH="${ProgramFiles};c:\Users\new-user-admin\AppData\Local\Microsoft\dotnet"

## Build Project
RUN powershell -Command dotnet build

## Run Project
ENTRYPOINT ["powershell", "-Command", "dotnet", "run"]
