# Import the LocalAccounts module
Import-Module Microsoft.PowerShell.LocalAccounts

# Define the user name
$User = "USERNAME"

# Define the function to generate a random password
function Generate-RandomPassword {
    $AllowedCharacters = 'ABCDEFGHJKLMNOPQRSTUVWXYZabcdefghijkmnxyz0123456789!@#$%&*+.?'
    $Length = 12

    # Add at least 1 uppercase letter
    $Password = -join ($AllowedCharacters.ToCharArray() | Where-Object { $_ -match '[A-Z]' } | Get-Random)

    # Add at least 1 number
    $Password += -join ($AllowedCharacters.ToCharArray() | Where-Object { $_ -match '[0-9]' } | Get-Random)

    # Add at least 1 special character
    $Password += -join ($AllowedCharacters.ToCharArray() | Where-Object { $_ -match '[!@#$%*+.]' } | Get-Random)

    # Generate the rest of the password
    for ($i = 0; $i -lt ($Length - 3); $i++) {
        $Password += $AllowedCharacters[(Get-Random -Minimum 0 -Maximum $AllowedCharacters.Length)]
    }

    return $Password
}

# Generate a random password
$GeneratedPassword = Generate-RandomPassword

# Convert the password to SecureString
$SecurePassword = ConvertTo-SecureString $GeneratedPassword -AsPlainText -Force

# Change the local user's password
try {
    Set-LocalUser -Name $User -Password $SecurePassword
    Write-Host "The password was successfully changed for user '$User'."
    Write-Host "The new password is: $GeneratedPassword"
    exit 0 # Exit code 0 to indicate success
} catch {
    Write-Host "Error changing the password: $_"
    exit 1 # Exit code 1 to indicate error
} 
