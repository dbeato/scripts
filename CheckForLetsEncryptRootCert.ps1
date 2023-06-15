$hosts = @("host1", "host2", "host3", "etc")

foreach ($h in $hosts){

`$Status = invoke-command -ComputerName $h -ScriptBlock { get-childitem -path Cert:\CurrentUser\AuthRoot } | Select Subject | Select-String -Pattern 'ISRG' -Quiet`
`write-host "$h - $Status"`

}