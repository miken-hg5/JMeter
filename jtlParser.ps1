# powershell jtl parser

#--------------------CONFIGURABLE VARIABLES---------------------------------------------

$input_jtl_filename_to_strip = "C:\results.jtl"
$output_jtl_filename = "C:\results_TRANSACTIONS_ONLY.jtl"

[regex]$header_recognition_regex = "[^\d+]"  # header does not start with digits
[regex]$transaction_match_regex = 'Number of samples' # regex matching rows that you want to keep (in this case transactions)

$batch_line_count = 1000

#----------------------------------------------------------------------------------------

# Reading header and saving it to output file
(Select-String -Path $input_jtl_filename_to_strip -Pattern $header_recognition_regex -list).line |
    Out-File -Append $output_jtl_filename -Encoding ascii

# Parsing input file and saving transactions to output
Write-Host "Starting parsing file"

Get-Content $input_jtl_filename_to_strip -ReadCount $batch_line_count |
    ForEach {
             $_ -match $transaction_match_regex | Out-File -Append $output_jtl_filename -Encoding ascii
    }

Write-Host "Finished extracting to " $output_jtl_filename
