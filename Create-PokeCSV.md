# Powershell function: 
Create-PokeCSV to deal with one CSV at a time

```powershell
<#
.SYNOPSIS
This is a function to create a new csv file with only first few lines of the original file.
.DESCRIPTION
The input parameter must be a filename of type string.
.EXAMPLE
PS /root> Create-PokeCSV abilities.csv
#>

function Create-PokeCSV {
        [Cmdletbinding()]
        param(
                [Parameter(Mandatory=$true)]
                [String]$fileName
        )
	# Get the file name without extention, to rename the newly created file
	$baseName = (Get-Item $filename).Basename
	$newFile = $baseName+"_head.csv"

	Import-Csv ./$fileName -Delimiter "`t" | Select-Object * -First 5 | Out-File ./data_head/$newFile
}
```
### Added some comments to show the output

```powershell
PS /Users/ashwarybhatt/powershell/pokecsv> Create-PokeCSV ./abilities.csv
Trimming the file - DONE
Verify the newly created file

id identifier   generation_id is_main_series
-- ----------   ------------- --------------
1  stench       3             1
2  drizzle      3             1
3  speed-boost  3             1
4  battle-armor 3             1
5  sturdy       3             1

PS /Users/ashwarybhatt/powershell/pokecsv>
```
