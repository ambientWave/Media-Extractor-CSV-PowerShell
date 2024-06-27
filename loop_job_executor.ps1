$CSVFiles =  Get-ChildItem | Sort-Object { [regex]::Replace($_.Name, '\d+', { $args[0].Value.PadLeft(20) }) } | Where-Object { $_.Name -match "Applicant \(hr\.applicant\)_\d*\.csv" } | Measure-Object
$FilesCount = $CSVFiles.Count
foreach ($i in 1..$FilesCount) {
    Write-Host "Loop $i"
    mkdir demo_$i
    cp ".\Applicant (hr.applicant)_$i.csv", .\csv_media_extractor.ps1 demo_$i
    # cd demo_$i
    Rename-Item -Path ".\demo_$i\Applicant (hr.applicant)_$i.csv" -NewName "Applicant (hr.applicant).csv"
    # cd ..
    New-Item -Type Directory ".\demo_$i\media"
    # Using multiprocessing or one can use Start-Job but that would be multithreading
    cd .\demo_$i\
    Start-Process powerShell.exe -ArgumentList "-ExecutionPolicy Bypass -File .\csv_media_extractor.ps1"
    cd ..
}