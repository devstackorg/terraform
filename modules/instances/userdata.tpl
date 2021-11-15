#cloud-config
repo_update: true
repo_upgrade: all

write_files:
- path: /etc/csp/boot_config/metadata.json
  permissions: '0777'
  content: |
     {
     "meta": {
      "vm_role" : "${vm_role}"
     }
             }

- path: /etc/csp/boot_scripts/ssh_keys.sh
  permissions: '0755'
  content: |
     #!/bin/bash
     ssh-keygen -q -t rsa -N '' -f /home/centos/.ssh/id_rsa <<<y 2>&1 >/dev/null

     cat /home/centos/.ssh/id_rsa.pub >> /home/centos/.ssh/authorized_keys

     ssh -o StrictHostKeyChecking=no centos@localhost
     
- path: /etc/csp/boot_scripts/play-books.sh
  permissions: '0755'
  content: |
     #!/bin/bash
     git clone https://github.com/devstackorg/ansible.git

     cd ansible/plays

     ansible-playbook devstack.yml


runcmd:
# - [ sh, /etc/csp/boot_scripts/ssh_keys.sh ]
  - [ sh, /etc/csp/boot_scripts/play-books.sh ]

