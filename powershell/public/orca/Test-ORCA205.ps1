<#
.SYNOPSIS
    Common attachment type filter is enabled

.DESCRIPTION
    Generated on 02/27/2025 08:31:23 by .\build\orca\Update-OrcaTests.ps1

.EXAMPLE
    Test-ORCA205

    Returns true or false

.LINK
    https://maester.dev/docs/commands/Test-ORCA205
#>
function Test-ORCA205{
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    Write-Verbose "Test-ORCA205"
    if(!(Test-MtConnection ExchangeOnline)){
        Add-MtTestResultDetail -SkippedBecause NotConnectedExchange
        return = $null
    }elseif(!(Test-MtConnection SecurityCompliance)){
        Add-MtTestResultDetail -SkippedBecause NotConnectedSecurityCompliance
        return = $null
    }

    if(($__MtSession.OrcaCache.Keys|Measure-Object).Count -eq 0){
        Write-Verbose "OrcaCache not set, Get-ORCACollection"
        $__MtSession.OrcaCache = Get-ORCACollection
    }
    $Collection = $__MtSession.OrcaCache
    $obj = New-Object -TypeName ORCA205
    $obj.Run($Collection)
    $testResult = ($obj.Completed -and $obj.ResultStandard -eq "Pass")

    $resultMarkdown = "Malware Filter Policy - Common Attachment Type Filter - `n`n"
    if($testResult){
        $resultMarkdown += "Well done. Common attachment type filter is enabled`n`n%ResultDetail%"
    }else{
        $resultMarkdown += "Your tenant did not pass. Enable common attachment type filter`n`n%ResultDetail%"
    }

    if (!$obj.ExpandResults) {
        Add-MtTestResultDetail -Result $resultMarkdown.TrimEnd("%ResultDetail%")
        return $testResult
    }

    $passResult = "`u{2705} Pass"
    $failResult = "`u{274C} Fail"
    $skipResult = "`u{1F5C4}  Skip"
    $resultDetail = "| $($obj.ItemName) | $($obj.DataType) | Result |`n"
    $resultDetail += "| --- | --- | --- |`n"
    foreach($config in $obj.Config){
        switch($config.ResultStandard){
            "Pass" {$itemResult = $passResult}
            "Informational" {$itemResult = $skipResult}
            "None" {$itemResult = $skipResult}
            "Fail" {$itemResult = $failResult}
        }
        $resultDetail += "| $($config.ConfigItem) | $($config.ConfigData) | $itemResult |`n"
    }

    $resultMarkdown = $resultMarkdown -replace "%ResultDetail%", $resultDetail

    Add-MtTestResultDetail -Result $resultMarkdown

    return $testResult
}
