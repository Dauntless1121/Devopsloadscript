#!/bin/bash
sudo apt-get update
apt-get install ca-certificates wget curl apt-transport-https lsb-release gnupg
mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null
chmod go+r /etc/apt/keyrings/microsoft.gpg
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
dpkg -i packages-microsoft-prod.deb
apt-get update
apt-get install -y azure-cli powershell
pwsh -command Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
apt-get install -y python3 python3-pip nano git jq lsb-release python3-apt python3-distutils ansible nano git iputils-ping software-properties-common apt-utils
ansible-galaxy collection install ansible.windows
ansible-galaxy collection install azure.azcollection
curl -s https://api.github.com/repos/bcicen/ctop/releases/latest | grep browser_download_url|grep linux-amd64 | cut -d '"' -f 4 | wget -i -
chmod +x ctop-*-linux-amd64
mv ctop-*-linux-amd64 /usr/local/bin/ctop
