# docker build -t rust:$RUST_VERSION-${{ matrix.name }} stable/${{ matrix.variant }}

$images = @(
    @{
        name    = 'windowsservercoreltsc2022-gnu'
        variant = 'windows/servercoreltsc2022/gnu'
    }
    @{   
        name    = 'windowsnanoserverltsc2022-gnu'
        variant = 'windows/nanoserverltsc2022/gnu'
    }
    @{
        name    = 'windowsservercoreltsc2025-gnu'
        variant = 'windows/servercoreltsc2025/gnu'
    }
    @{
        name    = 'windowsnanoserverltsc2025-gnu'
        variant = 'windows/nanoserverltsc2025/gnu'
    }
    @{
        name    = 'windowsservercoreltsc2019-17763-msvc'
        variant = 'windows/servercoreltsc2019/msvc'
    }
    @{
        name    = 'windowsservercoreltsc2022-20348-msvc'
        variant = 'windows/servercoreltsc2022/msvc'
    }
    @{
        name    = 'windowsservercoreltsc2025-22000-msvc'
        variant = 'windows/servercoreltsc2025/msvc'
    }
)

foreach ($img in $images) {
    $name = $img['name']
    $variant = $img['variant']
    docker build -t rust:1.90.0-$name .\stable\$variant
}

docker images