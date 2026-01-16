#!/bin/bash

# --- Colors for Professional Output ---
GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'

# --- Banner ---
echo "=========================================="
echo "    CYBER SECURITY ENCRYPTION TOOL v1.0"
echo "    (AES-256-CBC | PBKDF2 Protection)"
echo "=========================================="

echo "1. Encrypt File (Lock)"
echo "2. Decrypt File (Unlock)"
read -p "Select an option (1 or 2): " choice
read -p "Enter filename: " infile

# --- Step 1: Check if file exists (Error Handling) ---
if [ ! -f "$infile" ]; then
    echo -e "${RED}[ERROR] File '$infile' not found! Please check the name.${RESET}"
    exit 1
fi

# --- Step 2: Processing ---
if [ "$choice" == "1" ]; then
    # Encryption Logic
    # Auto-name the output (e.g., data.txt -> data.txt.enc)
    outfile="${infile}.enc"
    
    echo "🔒 Encrypting..."
    if openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -salt -in "$infile" -out "$outfile"; then
        echo -e "${GREEN}[SUCCESS] File encrypted and saved as: $outfile${RESET}"
    else
        echo -e "${RED}[FAIL] Encryption failed.${RESET}"
    fi

elif [ "$choice" == "2" ]; then
    # Decryption Logic
    # Auto-name output (Remove .enc from name)
    outfile="${infile%.enc}"
    
    # If file didn't have .enc, add .restored to avoid overwrite
    if [ "$infile" == "$outfile" ]; then
        outfile="${infile}.restored"
    fi

    echo "🔓 Decrypting..."
    if openssl enc -d -aes-256-cbc -pbkdf2 -iter 100000 -in "$infile" -out "$outfile"; then
        echo -e "${GREEN}[SUCCESS] File decrypted and saved as: $outfile${RESET}"
    else
        echo -e "${RED}[FAIL] Decryption failed. Wrong password?${RESET}"
    fi

else
    echo -e "${RED}Invalid Option Selected.${RESET}"
fi
