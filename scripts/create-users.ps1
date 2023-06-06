$Username = 'usuario_local'
$Password = ConvertTo-SecureString 'zapatos.12345678' -AsPlainText -Force
$LocalUser = New-LocalUser -Name $Username -Password $Password -FullName 'Usuario Local' -Description 'Local user account'

if ($LocalUser) {
    Write-Host "Local user '$Username' created successfully."
} else {
    Write-Host "Failed to create local user '$Username'."
}
