# Variables
$sourceFile = "/Transfert/fichier.tar.gz"
$destinationFile = "C:\Program Files\TRANSFERT DEBIAN\fichier.tar.gz"
$ftpServer = "ftp://10.10.121.21/Transfert/fichier.tar.gz"
$ftpUsername = "SEB"
$ftpPassword = "Root1234"
$emailFrom = "morganedag22@gmail.com"
$emailTo = "morganedag22@gmail.com"
$smtpServer = "smtp.gmail.com"
$smtpUsername = "morganedag22@gmail.com"
$smtpPassword = "ibmm khoi temj frmz"  # Utilisez le mot de passe d'application ici

# Téléchargement du fichier via FTP
try {
    Write-Host "Téléchargement du fichier en cours..."
    $webClient = New-Object System.Net.WebClient
    $webClient.Credentials = New-Object System.Net.NetworkCredential($ftpUsername, $ftpPassword)
    $webClient.DownloadFile($ftpServer, $destinationFile)
    Write-Host "Téléchargement réussi."

    # Envoi d'un email de succès
    $subject = "Transfert réussi"
    $body = "Le fichier $sourceFile a été transféré avec succès vers $destinationFile."
    Send-MailMessage -From $emailFrom -To $emailTo -Subject $subject -Body $body -SmtpServer $smtpServer -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $smtpUsername, (ConvertTo-SecureString $smtpPassword -AsPlainText -Force)) -Port 587
} catch {
    Write-Host "Le transfert a échoué."

    # Envoi d'un email d'échec
    $subject = "Échec du transfert"
    $body = "Le transfert du fichier $sourceFile vers $destinationFile a échoué. Erreur : $_"
    Send-MailMessage -From $emailFrom -To $emailTo -Subject $subject -Body $body -SmtpServer $smtpServer -UseSsl -Credential (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $smtpUsername, (ConvertTo-SecureString $smtpPassword -AsPlainText -Force)) -Port 587
}