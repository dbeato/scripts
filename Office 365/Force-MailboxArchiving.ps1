while ($true) {
    try {
        Start-ManagedFolderAssistant -Identity "user@domain.com"
        Write-Host "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - ManagedFolderAssistant started successfully." -ForegroundColor Green
    }
    catch {
        Write-Host "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Error: $_" -ForegroundColor Red
    }

    Start-Sleep -Seconds 300
}
