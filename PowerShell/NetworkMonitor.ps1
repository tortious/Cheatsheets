### Use this script to map interaction between you local host with external systems/ endpoints/ ports and protocols
$currentIp = Test-Connection -ComputerName $env:computername -Count 1 | Select IPV4Address
$logFile = "$((Get-Location).path)\NetworkConnectionsLog-$($env:computername)_$($currentIp.IPV4Address.IPAddressToString ).csv"

$intervalBetweenCollectsInSeconds = 15
$howManyCollects = 5

while ($i -lt $howManyCollects) { 
   
    Write-Output "`n[   Starting the collection: $($i + 1) of $howManyCollects   ]`n"
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $excludedIPs = @("0.0.0.0", "127.0.0.1", "::", "::1")
    
    # More details about connection states: https://maxnilz.com/docs/004-network/003-tcp-connection-state/
    $connections = Get-NetTCPConnection -State Listen, Established, TimeWait -ErrorAction SilentlyContinue | 
        Where-Object LocalAddress -notin $excludedIPs | 
        Select LocalAddress, LocalPort, RemoteAddress, RemotePort, OwningProcess, State  
    
    ### Adding extended fields to collect, like DNS Name and Proccess Name
    foreach ($item in $connections){
        Write-Output "Getting extendend info - $([array]::IndexOf($connections, $item)) of $($connections.Length)"
        if(!([string]::IsNullOrEmpty($item.RemoteAddress)) -and ($item.RemoteAddress -notin $excludedIPs)){
            $dnsName = (Get-DnsClientCache | Where-Object { $_.data -eq $item.RemoteAddress }).Entry
            if (-not $dnsName) {
                ### May slow down...
                # $dnsName = (Resolve-DnsName -ErrorAction SilentlyContinue -Name $item.RemoteAddress).NameHost
                # if (-not $dnsName) {
                    $dnsName = "DNS name not found"
                # }
            } else {
                if ($dnsName.Length -gt 1){
                    $dnsName = $dnsName -join ","
                }
            }
        } else {
            $dnsName = "Not Applicable"
        }
        # Write-Output "[x] DNS extended info done!"

        $processItem = Get-Process -Id $item.OwningProcess -ErrorAction SilentlyContinue
        if (-not $processItem) {
            $processName = "Process not found"
            $processName = "Process not found"
        } else {
            $processName = $processItem.Name
            $processPath = $processItem.Path
                if (-not $processPath) {
                    $processPath = "Internal process"
                }
        }   
        
        # Write-Output "[x] Process extended info done!"
       
        $item | Add-Member -MemberType NoteProperty -Name RemoteAddress_DNS -Value $dnsName
        $item | Add-Member -MemberType NoteProperty -Name Timestamp -Value $timestamp
        $item | Add-Member -MemberType NoteProperty -Name ProcessName -Value $processName
        $item | Add-Member -MemberType NoteProperty -Name ProcessPath -Value $processPath
    }

    $connections | 
        Select Timestamp, LocalAddress, LocalPort, RemoteAddress, RemoteAddress_DNS, RemotePort, State, OwningProcess, ProcessName, ProcessPath | 
        Sort-Object -Property State -Descending |
        Export-Csv -Path $logFile -NoTypeInformation -Append

    Write-Output "Waiting $($intervalBetweenCollectsInSeconds) seconds for the next run!"
    Start-Sleep -Seconds $intervalBetweenCollectsInSeconds
    $i++
}

Write-Output "`nDiscovery completed. Results saved to ${logFile}."
