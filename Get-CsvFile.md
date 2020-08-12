# Powershell function: Get-CsvFiles

### This function performs the following tasks 
1. For every file in the path, create corresponding short versions, with only first 6 lines of the original file.
2. Rename all the newly created files as *_head into a separate folder called data_head

```powershell
function Get-CsvFiles {
      
        # get the list of CSV files
        $filename = Get-ChildItem -File | ForEach-Object {$_.Name} | select -First 2


        # for each csv file select the first 5 lines and copy the new files to /data_head folder
        foreach ($element in $filename) { 
                Import-Csv ./$element -Delimiter "," | select * -First 5 | Out-File ./data_head/$element 
        }


        # Rename each of the new files as *_head.csv 
        Set-Location ./data_head/
        $list = Get-ChildItem -Name
        foreach ($file in $list) {
                Rename-Item $file ((Get-Item $file).BaseName+"_head.csv")  
        }
}
```
### Here is the output
```powershell
PS /root/shruti/pokedex/pokedex/data/csv/data_head> ls
PS /root/shruti/pokedex/pokedex/data/csv/data_head> cd ..
PS /root/shruti/pokedex/pokedex/data/csv> Get-CsvFiles
PS /root/shruti/pokedex/pokedex/data/csv/data_head> ls
abilities_head.csv  ability_changelog_prose_head.csv
PS /root/shruti/pokedex/pokedex/data/csv/data_head> cat ./abilities_head.csv

id identifier   generation_id is_main_series
-- ----------   ------------- --------------
1  stench       3             1
2  drizzle      3             1
3  speed-boost  3             1
4  battle-armor 3             1
5  sturdy       3             1

PS /root/shruti/pokedex/pokedex/data/csv/data_head> cat ./ability_changelog_prose_head.csv

ability_changelog_id local_language_id effect
-------------------- ----------------- ------
1                    6                 Hat im Kampf keinen Effekt.
1                    9                 Has no effect in battle.
2                    6                 Verhindert keine regulären K.O. bei vollen []{mechanic:hp}.
2                    9                 Does not prevent regular KOs from full [HP]{mechanic:hp}.
3                    6                 Hat außerhalb vom Kampf keinen Effekt.

PS /root/shruti/pokedex/pokedex/data/csv/data_head>
```
