write-output "Running Licensing Script ..."
$computer = $env:computername

write-output "$computer"
if ($computer -eq "HOST01"){
  $ProductKey = $env:HOST01
}
if ($computer -eq "HOST02"){
  $ProductKey = $env:HOST02
}


if ($ProductKey) {
    write-output "Activate License Key on $computer"
    $service = get-wmiObject -query "select * from SoftwareLicensingService" -computername $computer
    $service.InstallProductKey($ProductKey )
    $service.RefreshLicenseStatus()
    $service.RefreshLicenseStatus()
    write-output "done"
}else{
	write-output 'Key not found!'
}
