#cloud-config
repo_update: true
repo_upgrade: all

write_files:
- path: /home/centos/ssh_keys.sh
  permissions: '0755'
  content: |
     #!/bin/bash
     ssh-keygen -q -t rsa -N '' -f /home/centos/.ssh/id_rsa <<<y 2>&1 >/dev/null

     cat /home/centos/.ssh/id_rsa.pub >> /home/centos/.ssh/authorized_keys

     ssh -o StrictHostKeyChecking=no centos@localhost
     
- path: /home/centos/play-books.sh
  permissions: '0755'
  content: |
     #!/bin/bash
     git clone https://github.com/krishnamaram2/configuration-manager.git

     cd configuration-manager/src/devstack/plays

     ansible-playbook -i hosts devstack.yml


runcmd:
# - [ sh, /home/centos/ssh_keys.sh ]
# - [ sh, /home/centos/play_books.sh ]

