function decrypt
    echo "Dencrypting $argv[3]..."
    openssl aes-256-cbc -iter $argv[1] -salt -a -d -in $argv[2] -out $argv[3] || echo "File not found"
end
