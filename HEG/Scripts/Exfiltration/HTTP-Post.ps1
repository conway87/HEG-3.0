# API key was generated soley for this project 
# If abused by others, it could be revoked, in which case, please generate your own private api key and use that.

$apiKey = "6nxrBm7UIJuaEuPOkH5Z8I7SvCLN3OP0"

$filePath = ".\Tools\Random_Data.txt"
$content = Get-Content $filePath -Raw
$url = "https://pastebin.com/api/api_post.php"
$postData = @{
  api_dev_key   = $apiKey
  api_option    = "paste"
  api_paste_code = $content
}
$response = Invoke-RestMethod -Uri $url -Method Post -Body $postData
Write-Host "            * Your paste URL: $response"

