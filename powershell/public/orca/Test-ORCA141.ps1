<#
.SYNOPSIS
    Bulk action set to Move message to Junk Email Folder

.DESCRIPTION
    Generated on 02/27/2025 08:51:02 by .\build\orca\Update-OrcaTests.ps1

.EXAMPLE
    Test-ORCA141

    Returns true or false

.LINK
    https://maester.dev/docs/commands/Test-ORCA141
#>
function Test-ORCA141{
    [CmdletBinding()]
    [OutputType([bool])]
    param()

    Write-Verbose "Test-ORCA141"
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
    $obj = New-Object -TypeName ORCA141
    $obj.Run($Collection)
    $testResult = ($obj.Completed -and $obj.ResultStandard -eq "Pass")

    $resultMarkdown = "Anti-Spam Policies - Bulk Action - 141`n`n"
    if($testResult){
        $resultMarkdown += "Well done. Bulk action set to Move message to Junk Email Folder`n`n%ResultDetail%"
    }else{
        $resultMarkdown += "Your tenant did not pass. Change bulk action to move messages to junk mail folder`n`n%ResultDetail%"
    }

    if (!$obj.ExpandResults) {
        Add-MtTestResultDetail -Result $resultMarkdown.TrimEnd("%ResultDetail%")
        return $testResult
    }

    $passResult = "`u{2705} Pass"
    $failResult = "`u{274C} Fail"
    $skipResult = "`u{1F5C4} Skip"
    $showObject = ""+$obj.CheckType -eq "ObjectPropertyValue"
    $resultDetail = ""

    if ($showObject) { $resultDetail += "| $($obj.ObjectType) " }
    $resultDetail += "| $($obj.ItemName) | $($obj.DataType) | Result |`n"

    if ($showObject) { $resultDetail += "| --- " }
    $resultDetail += "| --- | --- | --- |`n"
    foreach($config in $obj.Config){
        switch($config.ResultStandard){
            "Pass" {$itemResult = $passResult}
            "Informational" {$itemResult = $skipResult}
            "None" {$itemResult = $skipResult}
            "Fail" {$itemResult = $failResult}
        }

        if ($showObject) { $resultDetail += "| $($config.Object) " }
        $resultDetail += "| $($config.ConfigItem) | $($config.ConfigData) | $itemResult |`n"
    }

    $resultMarkdown = $resultMarkdown -replace "%ResultDetail%", $resultDetail

    Add-MtTestResultDetail -Result $resultMarkdown

    return $testResult
}
