function encrypt
    echo "Encrypting $argv[2]..."
    openssl aes-256-cbc -iter $argv[1] -salt -a -e -in $argv[2] -out $argv[3] || echo "File not found"
end
