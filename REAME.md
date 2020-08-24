# Project dotnet WebAPI - Docker on Windows Server 2016 Standard

## Requirements

### SO Windows Server: 2016 Standard
#### Command Line:
```bash
systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
```
- OS Name:                   Microsoft Windows Server 2016 Standard
- OS Version:                10.0.14393 N/A Build 14393

#### Install Docker: version 19.03.11
```bash
# Instalar característica Containers y reiniciar
Install-WindowsFeature containers
Restart-Computer -Force

# Instalar Docker
Install-Module DockerMsftProvider -Force
Install-Package Docker -ProviderName DockerMsftProvider –Force

# Registrar Servicio e iniciarlo
dockerd --register-service
Start-Service docker

# Reiniciar maquina
Restart-Computer -Force
```

#### Docker Compose: version 1.26.2
```bash
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Invoke-WebRequest "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile $Env:ProgramFiles\Docker\docker-compose.exe
```

## Run
```bash
docker-compose up -d
```

#### Resultado
```bash
webapi-dotnet-core    | info: Microsoft.Hosting.Lifetime[0]
webapi-dotnet-core    |       Now listening on: http://0.0.0.0:5000
webapi-dotnet-core    | info: Microsoft.Hosting.Lifetime[0]
webapi-dotnet-core    |       Application started. Press Ctrl+C to shut down.
webapi-dotnet-core    | info: Microsoft.Hosting.Lifetime[0]
webapi-dotnet-core    |       Hosting environment: Development
webapi-dotnet-core    | info: Microsoft.Hosting.Lifetime[0]
webapi-dotnet-core    |       Content root path: C:\WebAPI
```

## Render WebAPI
Open Browser [http://localhost:5000/WeatherForecast](http://localhost:5000/WeatherForecast)

## Errors
### Error in line: "RUN powershell -Command .\dotnet-install.ps1".
Execute:
```bash
Stop-service docker
Get-ContainerNetwork | Remove-ContainerNetwork -Force
Start-service docker
```