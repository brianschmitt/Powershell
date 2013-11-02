## =====================================================================
## Title       : Execute-Query
## Description : Executes a query on the supplied databases
## Author      : Brian Schmitt
## Date        : 7/2/2013
## Input       : -sqlQuery
## Output      : Produces a result of the query
## Usage       : PS> . Execute-Query "select sysdate from dual"
## Notes       : This is a self contained script and contains various helper
##                 methods to support performing the analysis
##               ServerFile is used to obtain login information
##               This file contain 1 or more lines in the below format
##               ENV:DB:SCHEMA:PASSWORD
## Tag         : PowerShell, Oracle
## Change log  : 1.0 - Initial Version
## =====================================================================
$scriptRoot = Split-Path (Resolve-Path $myInvocation.MyCommand.Path)
$serverfile = . (join-path $scriptRoot "/servers.txt")

function Execute-Query ($filter, $sqlQuery) {

    function Execute-OracleQuery($connectstring, $Query) {
        $private:tmp = [System.Reflection.Assembly]::LoadWithPartialName("System.Data.OracleClient")
        $private:ad = New-Object System.Data.OracleClient.OracleDataAdapter($query,$connectstring)
        $private:dt = New-Object System.Data.DataTable
        $private:tmp = $ad.Fill($dt)
        return $dt
    }
	
    $databases = @{}
	Get-Content $serverfile | foreach {
		if ($_.ToString().Contains($filter)) {
            $line = $_.split(":")
            $schemaname = $line[2]
            $connectstring = "data source={0};user id={1};password={2};"
            $connectstringcomplete = $connectstring -F $line[1], $line[2], $line[3]
            $databases.add($schemaname,$connectstringcomplete)
        }
	}

    function Get-OracleData ($sql) {
        $result = New-Object System.Data.datatable

        foreach ($schema in $databases.keys)
        {
            $connString = $databases[$schema]
            $dt = Execute-OracleQuery $connString $sql
            $result += $dt
        }
        return $result
    }

    if (!$sqlQuery) {
        $sqlQuery = Read-Host "What is the query?"
    }
    return Get-OracleData $sqlQuery
}

# This utilizes the execute-query function to perform an impact analysis across all databases
function Get-ImpactAnalysis
    {
    Param([Parameter(Mandatory=$true, HelpMessage="Enter a database object name")] $dbobjectName)

        $qry= @"
                select owner impacted_object_owner,
                    name impacted_object,
                    type impacted_object_type,
                    referenced_owner changed_object_owner,
                    referenced_name changed_object,
                    referenced_type changed_object_type,
                    dependency_type,
                    referenced_link_name
                from all_dependencies
                WHERE referenced_owner NOT IN ('SYS', 'SYSTEM')
                    AND upper(referenced_name) LIKE '{0}'
"@

        $fullQuery = $qry -F $dbobjectName.trim().toupper()
	    # due to connecting to multiple schemas we will frequently have duplicates
	    # after getting results, we need to sort and then filter them out
        $sortedresult = Execute-Query "PT" $fullQuery | Sort-Object impacted_object_owner, impacted_object, changed_object_owner, changed_object, changed_object_type  -unique
        return $sortedresult
}