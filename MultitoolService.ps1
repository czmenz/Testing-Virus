while ($true) {
    $keyword = "Multi Helper"

    # Získání všech procesů cmd.exe
    $processes = Get-Process -Name cmd -ErrorAction SilentlyContinue

    # Kontrola názvů oken (Titlu)
    $process_found = $false
    foreach ($process in $processes) {
        if ($process.MainWindowTitle -like "*$keyword*") {
            $process_found = $true
            break
        }
    }

    if (-not $process_found) {
        Write-Host "Batch soubor s klíčovým slovem '$keyword' neběží. Ukončuji skript."
        
        # Smazání složky %temp%\MultiTool
        $folder = [System.IO.Path]::Combine($env:TEMP, 'MultiTool')
        if (Test-Path -Path $folder) {
            Remove-Item -Path $folder -Recurse -Force
            Write-Host "Složka '$folder' byla smazána."
        } else {
            Write-Host "Složka '$folder' neexistuje."
        }
        
        # Ukončení skriptu
        break
    }

    # Pauza 5 sekund, aby skript nezahltil CPU
    Start-Sleep -Seconds 5
}

Write-Host "Skript byl úspěšně ukončen."
