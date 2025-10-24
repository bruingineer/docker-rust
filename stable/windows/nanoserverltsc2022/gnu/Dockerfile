# escape=`

FROM mcr.microsoft.com/windows/nanoserver:ltsc2022

LABEL org.opencontainers.image.source=https://github.com/rust-lang/docker-rust

SHELL ["powershell.exe", "-NoLogo", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV RUSTUP_HOME=C:\rustup `
    CARGO_HOME=C:\cargo `
    RUST_VERSION=1.90.0

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; `
    $url = 'https://static.rust-lang.org/rustup/archive/1.28.2/x86_64-pc-windows-gnu/rustup-init.exe'; `
    $sha256 = 'ccbfd951d8024856043b3a0c3903a59f39937bce8d3074768b0d3da55f21e817'; `
    Invoke-WebRequest -Uri $url -OutFile C:\rustup-init.exe; `
    $actual256 = (Get-FileHash rustup-init.exe -Algorithm sha256).Hash; `
    if ($actual256 -ne $sha256) { `
       Write-Host 'FAILED!'; `
       Write-Host ('expected: {0}' -f $sha256); `
       Write-Host ('got:      {0}' -f $actual256); `
       exit 1; `
    }; `
    New-Item ${env:CARGO_HOME}\bin -type directory | Out-Null; `
    $newPath = ('{0}\bin;{1}' -f ${env:CARGO_HOME}, ${env:PATH}); `
    [Environment]::SetEnvironmentVariable('PATH', $newPath, [EnvironmentVariableTarget]::Machine); `
    [Environment]::SetEnvironmentVariable('PATH', $newPath, [EnvironmentVariableTarget]::Process); `
    C:\rustup-init.exe -y -v --no-modify-path --default-toolchain ${env:RUST_VERSION} --default-host x86_64-pc-windows-gnu; `
    Remove-Item C:\rustup-init.exe; `
    rustup -V; `
    cargo -V; `
    rustc -V

# install msys2
ENV MSYS2_HOME=C:\msys64

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; `
    $url = 'https://github.com/msys2/msys2-installer/releases/download/2025-08-30/msys2-x86_64-20250830.exe'; `
    $sha256 = 'b54705073678d32686a2cc356bb552363429e6ccbabbfeccb6d3cb7ec101e73b'; `
    Invoke-WebRequest -Uri $url -OutFile C:\msys2.exe; `
    $actual256 = (Get-FileHash msys2.exe -Algorithm sha256).Hash.toLower(); `
    if ($actual256 -ne $sha256) { `
       Write-Host 'FAILED!'; `
       Write-Host ('expected: {0}' -f $sha256); `
       Write-Host ('got:      {0}' -f $actual256); `
       exit 1; `
    }; `
    C:\msys2.exe in --confirm-command --accept-messages --root C:\msys64; `
    $newPath = ('{0};{0}\mingw64\bin;{0}\usr\bin;{1}' -f ${env:MSYS2_HOME}, ${env:PATH}); `
    [Environment]::SetEnvironmentVariable('PATH', $newPath, [EnvironmentVariableTarget]::Machine); `
    [Environment]::SetEnvironmentVariable('PATH', $newPath, [EnvironmentVariableTarget]::Process); `
    Remove-Item C:\msys2.exe; `
    Write-Host $env:PATH

RUN pacman --version; `
    pacman -Syuu --noconfirm; `
    pacman -Syuu --noconfirm; `
    pacman -Scc --noconfirm

RUN pacman -S --noconfirm --needed base-devel mingw-w64-x86_64-toolchain; `
    gcc --version; 