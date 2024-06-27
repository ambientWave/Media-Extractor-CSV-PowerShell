$csvPath = ".\Applicant (hr.applicant).csv"
$csvData = Import-Csv -Path $csvPath  # You can specify your column names by adding this parameter: -Header "Applicant's Name", "national Id Photo", "Grade Photo"
foreach ($row in $csvData) {
    foreach ($field in $row.PSObject.Properties) {
        $base64String = $field.Value
        # Process the base64 string (e.g., convert to PDF)
        Write-Host $base64String
        # Convert base64 string to bytes
        $bytes = [System.Convert]::FromBase64String($base64String)
        if($base64String -like 'iVBOR*') {
            if($field.Name -eq 'national Id Photo') {
                $pngPath = ".\media\" + ($row | Select-Object -ExpandProperty "Applicant's Name") + " - ID" + ".png"
                [System.IO.File]::WriteAllBytes($pngPath, $bytes)
            }
            if($field.Name -eq 'Grade Photo') {
                $pngPath = ".\media\" + ($row | Select-Object -ExpandProperty "Applicant's Name") + " - Certificate" + ".png"
                [System.IO.File]::WriteAllBytes($pngPath, $bytes)
            }
        }
        if($base64String -like '/9j/4*') {
            if($field.Name -eq 'national Id Photo') {
                $jpgPath = ".\media\" + ($row | Select-Object -ExpandProperty "Applicant's Name") + " - ID" + ".jpeg"
                [System.IO.File]::WriteAllBytes($jpgPath, $bytes)
            }
            if($field.Name -eq 'Grade Photo') {
                $jpgPath = ".\media\" + ($row | Select-Object -ExpandProperty "Applicant's Name") + " - Certificate" + ".jpeg"
                [System.IO.File]::WriteAllBytes($jpgPath, $bytes)
            }
        }
        
        if($base64String -like 'JVBER*'){
            # Define the path for the PDF output
            if($field.Name -eq 'national Id Photo') {
                $pdfPath = ".\media\" + ($row | Select-Object -ExpandProperty "Applicant's Name") + " - ID" + ".pdf"
                # Write the bytes to the PDF file
                [System.IO.File]::WriteAllBytes($pdfPath, $bytes)
            }
            if($field.Name -eq 'Grade Photo') {
                $pdfPath = ".\media\" + ($row | Select-Object -ExpandProperty "Applicant's Name") + " - Certificate" + ".pdf"
                # Write the bytes to the PDF file
                [System.IO.File]::WriteAllBytes($pdfPath, $bytes)
            }
        }
    }
}