
# Windows SOC - Failed Login Monitoring
# Project: Windows Security Log Monitoring

Write-Host "===================================="
Write-Host "   SOC FAILED LOGIN MONITORING"
Write-Host "===================================="

# Collect the latest 50 failed login events
$events = Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    Id = 4625
} -MaxEvents 50 -ErrorAction SilentlyContinue

if (!$events) {
    Write-Host "No failed login events found."
    exit
}

# Extract event details
$results = foreach ($event in $events) {

    [xml]$xml = $event.ToXml()

    $data = @{}

    foreach ($item in $xml.Event.EventData.Data) {
        $data[$item.GetAttribute('Name')] = $item.InnerText
    }

    [PSCustomObject]@{
        Time        = $event.TimeCreated
        Username    = $data['TargetUserName']
        LogonType   = $data['LogonType']
        IPAddress   = $data['IpAddress']
        Status      = $data['Status']
        ProcessName = $data['ProcessName']
    }
}

# Display collected events
Write-Host "`nFAILED LOGIN EVENTS:"
$results | Format-Table -AutoSize

# Detect repeated failures by username
Write-Host "`nSUSPICIOUS LOGIN ACTIVITY:"
$alerts = @(
    $results |
    Where-Object {
        $_.Username -and $_.Username -ne '-'
    } |
    Group-Object Username |
    Where-Object {
        $_.Count -ge 5
    }
)

if ($alerts.Count -gt 0) {
    foreach ($alert in $alerts) {
        Write-Host "WARNING: Repeated failed login attempts!"
        Write-Host "Username:" $alert.Name
        Write-Host "Failed Attempts:" $alert.Count
    }
}
else {
    Write-Host "No repeated failures detected for named accounts."
}


# Export investigation results to CSV

$reportPath = "$HOME\Desktop\SOC-Project\Reports\FailedLoginReport.csv"

$results | Export-Csv -Path $reportPath -NoTypeInformation

Write-Host "`n===================================="
Write-Host "Total Failed Login Events:" @($results).Count
Write-Host "Report saved to:" $reportPath
Write-Host "===================================="
