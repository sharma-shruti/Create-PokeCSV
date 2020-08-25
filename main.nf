#!/usr/bin/env nextflow

Channel.fromPath('./*.csv')
        .into { ch_in_CsvFiles }
        
/*
#==============================================
createPokeCSV
#==============================================
*/

process createPokeCSV {

  publishDir 'results/data_head'

  input:
   path pokecsv from ch_in_CsvFiles
  
  output:
    file '*_head.csv' into ch_out_CsvFiles

  shell:
    """
    #!/usr/bin/env pwsh
    function Create-PokeCSV {
        [Cmdletbinding()]
        param(
                [Parameter(Mandatory=\$true)]
                [String]\$fileName
        )
        # Get the file name without extention, to rename the newly created file
        \$baseName = (Get-Item \$filename).Basename
        \$newFile = \$baseName+"_head.csv"

        Import-Csv ./\$fileName -Delimiter "`t" | Select-Object * -First 5 | Out-File ./\$newFile
    }    

    Create-PokeCSV $pokecsv
  
    """
}

