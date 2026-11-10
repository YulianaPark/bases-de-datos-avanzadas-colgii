$ErrorActionPreference = 'Stop'
$xmlPath = Join-Path $PSScriptRoot 'empleados.xml'
$xsdPath = Join-Path $PSScriptRoot 'empleados.xsd'

if (-not (Test-Path -LiteralPath $xmlPath)) {
    Write-Host "No se encuentra: $xmlPath" -ForegroundColor Red
    exit 1
}
if (-not (Test-Path -LiteralPath $xsdPath)) {
    Write-Host "No se encuentra: $xsdPath" -ForegroundColor Red
    exit 1
}

$script:validationErrors = 0
$settings = New-Object System.Xml.XmlReaderSettings
$settings.ValidationType = [System.Xml.ValidationType]::Schema
[void]$settings.Schemas.Add($null, $xsdPath)
$handler = [System.Xml.Schema.ValidationEventHandler]{
    param($sender, $eventArgs)
    $script:validationErrors++
    Write-Host ("{0}: {1}" -f $eventArgs.Severity, $eventArgs.Message) -ForegroundColor Red
}
$settings.add_ValidationEventHandler($handler)

$reader = $null
try {
    $reader = [System.Xml.XmlReader]::Create($xmlPath, $settings)
    while ($reader.Read()) { }
}
catch {
    $script:validationErrors++
    Write-Host ("Error al procesar XML/XSD: {0}" -f $_.Exception.Message) -ForegroundColor Red
}
finally {
    if ($null -ne $reader) { $reader.Close() }
}

if ($script:validationErrors -eq 0) {
    Write-Host 'VALIDACION CORRECTA: empleados.xml cumple empleados.xsd.' -ForegroundColor Green
    exit 0
}
else {
    Write-Host ("VALIDACION CON ERRORES: se encontraron {0} problema(s)." -f $script:validationErrors) -ForegroundColor Red
    exit 1
}
