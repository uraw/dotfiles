# keychain
if [[ -x "${commands[keychain]}" ]]; then
    for f in id_rsa id_ecdsa; do
        if [[ -e ~/.ssh/$f ]]; then
            eval `keychain --agents ssh --eval ~/.ssh/$f`
        fi
    done
fi
