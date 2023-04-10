# Install ansible
```bash
./install
```
# Run ansible script
```bash
ansible-playbook local.yml --ask-become-pass --vault-password-file=.pass
```

# Vault
Encrypt:
```bash
ansible-vault encrypt <file>
```
Decrypt:
```bash
ansible-vault decrypt <file>
```

glorious
