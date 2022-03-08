dnf install dnf-plugins-core -y
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee /etc/yum.repos.d/azure-cli.repo
dnf install terraform python3 azure-cli epel-release -y
dnf install ansible tree -y
ansible-galaxy collection install ansible.posix community.general
