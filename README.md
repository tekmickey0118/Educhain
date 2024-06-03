



This project is to automate Publisher deployment with Ansible scripts.

## Setting Up Ansible

- On Ubuntu/Debian based systems:
```bash
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```
- On CentOS/RHEL based systems:
```bash
sudo yum install epel-release
sudo yum install ansible
```
 - On macOS:
```bash
brew install ansible
```

## Deployment
- Clone this project
```bash
git clone git@bitbucket.org:educhaininc/ansible-playbooks.git
```

- Navigate ansible-project folder
```bash
cd ansible-playbook
```

- Run Prerequisites Scripts
```bash
ansible-playbook playbooks/prerequisites.yml
```
 
- Run automation Publisher deployment
```bash
sudo su educhain
sudo ansible-playbook playbooks/site.yml
```

## Structure
```bash
├── ansible.cfg  				    # Ansible configuration file
├── hosts        					# Inventory file
├── roles        					# Directory for roles
│   ├── prerequisites
│   │   ├── tasks
│   │   ├── handlers
│   │   ├── files
│   │   ├── templates
│   │   ├── vars
│   │   ├── defaults
│   │   └── meta
│   ├── frontend				    # Role for frontend setup
│   │   ├── tasks
│   │   ├── handlers
│   │   ├── files
│   │   ├── templates
│   │   ├── vars
│   │   ├── defaults
│   │   └── meta
│   ├── backend				        # Role for backend setup
│   │   ├── tasks
│   │   ├── handlers
│   │   ├── files
│   │   ├── templates
│   │   ├── vars
│   │   ├── defaults
│   │   └── meta
│   ├── database				    # Role for database setup
│   │   ├── tasks
│   │   ├── handlers
│   │   ├── files
│   │   ├── templates
│   │   ├── vars
│   │   ├── defaults
│   │   └── meta
│   ├── docker   				    # Role for Docker setup
│   │   ├── tasks
│   │   ├── handlers
│   │   ├── files
│   │   ├── templates
│   │   ├── vars
│   │   ├── defaults
│   │   └── meta
│   ├── nginx   					# Role for Nginx setup
│   │   ├── tasks
│   │   ├── handlers
│   │   ├── files
│   │   ├── templates
│   │   ├── vars
│   │   ├── defaults
│   │   └── meta
├── playbooks   				    # Directory for playbooks
│   ├── site.yml   				    # Master playbook
│   └── prerequisites.yml
└── group_vars  				    # Variables defined here are
    └── all.yml   					# Apply to all hosts
```

