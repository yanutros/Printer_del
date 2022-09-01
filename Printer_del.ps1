function CheckPrinter {

    param (
        $nomImp

    )
    $print = Get-Printer
    $print2 = ($print | select name)
    foreach($printer in $print2)
    {
        $printername = $printer.name
        if ($printername -eq $nomImp)
            {return $true}        
    }
    return $false
}

$PrinterXPS = CheckPrinter "Microsoft XPS Document Writer"
$PrinterONE = CheckPrinter "OneNote for Windows 10"
$PrinterFAX = CheckPrinter "Fax"
$PrinterPDF = CheckPrinter "Microsoft Print to PDF"

# Lancer le script en mode administrateur
function Test-Administrator  
{  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}

if (-not (Test-Administrator))
{	
	$CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    if ( Test-Path "$psHome\pwsh.exe")
        {
        Write-Host "pwsh présent"
		Start-Process -FilePath "$psHome\pwsh.exe" -Verb Runas -ArgumentList $CommandLine
		Exit
        }
    else
    {
        Start-Process "$psHome\powershell.exe" -Verb Runas -ArgumentList $CommandLine
		Exit
    }
}

#  Regarder si l'imprimante Microsoft XPS Document Writer est presente sur le poste, sinon la desinstalle

if (-not $PrinterXPS) 
{
    echo "l'imprimante Microsoft XPS Document Writer n'est pas presente sur le poste"
}
else
{
    Remove-Printer -Name "Microsoft XPS Document Writer"
    Write-Output "Supression de l'imprimante Microsoft XPS Document Writer"
}

# Regarder si l'imprimante OneNote for Windows 10 est presente sur le poste, sinon la desinstalle

if (-not $PrinterONE) 
{
    echo "l'imprimante OneNote for Windows 10 n'est pas presente sur le poste"
}
else
{
    Remove-Printer -Name "OneNote for Windows 10"
    Write-Output "Supression de l'imprimante OneNote for Windows 10"
}

# Regarder si l'imprimante Fax est presente sur le poste, sinon la desinstalle

if (-not $PrinterFAX) 
{
    echo "l'imprimante Fax n'est pas presente sur le poste"
}
else
{
    Remove-Printer -Name "Fax"
    Write-Output "Supression de l'imprimante Fax"
}

# Regarder si l'imprimante Microsoft Print to PDF est presente sur le poste, sinon la desinstalle

if (-not $PrinterPDF) 
{
    echo "l'imprimante Microsoft Print to PDF n'est pas presente sur le poste"
}
else
{
    Remove-Printer -Name "Microsoft Print to PDF"
    Write-Output "Supression de l'imprimante Microsoft Print to PDF"
}
