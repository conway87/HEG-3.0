# Resize Logs to 1MB

$Logs = "System", "Application", "Security"
foreach ($log in $Logs) {
    Limit-EventLog -LogName $log -MaximumSize 1MB
}