param (
    [string]$VM = "TW-DEV1"
)


filter Import-CimXml
{
    $CimXml = [Xml]$_
    $CimObj = New-Object -TypeName System.Object
    foreach ($CimProperty in $CimXml.SelectNodes("/INSTANCE/PROPERTY"))
    {
 if ($CimProperty.Name -eq "Name" -or $CimProperty.Name -eq "Data")
 {
         $CimObj | Add-Member -MemberType NoteProperty -Name $CimProperty.NAME -Value $CimProperty.VALUE
 }
    }
    $CimObj
}

$VmObj = Get-WmiObject -Namespace root\virtualization\v2 -Query "Select * From Msvm_ComputerSystem Where ElementName='$VM'"
$KvpObj = Get-WmiObject -Namespace root\virtualization\v2 -Query "Associators of {$VmObj} Where AssocClass=Msvm_SystemDevice ResultClass=Msvm_KvpExchangeComponent"


# $KvpObj.GuestIntrinsicExchangeItems | Import-CimXml | where {$_.Name -eq "NetworkAddressIPv4" } | Foreach-Object {$_.Data}
$KvpObj.GuestIntrinsicExchangeItems | Import-CimXml | where {$_.Name -eq "RDPAddressIPv4" } | Foreach-Object {$_.Data}
