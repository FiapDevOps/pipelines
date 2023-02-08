
#!/bin/bash

# ==============================================================================================================================

resize () {
# Resizing para o disco local do ambiente:
sh $HOME/environment/pipelines/cloud9/scripts/resize.sh 20 > /dev/null
}

configure_deps () {

test -d $HOME/environment/info || install -d -m 0700 -o $(whoami) -g $(whoami) $HOME/environment/info

# Identificando o endereco pub da instancia:
curl -s http://169.254.169.254/latest/meta-data/public-ipv4 -o $HOME/environment/info/PUBLIC_IP.txt && chown ec2-user: $HOME/environment/info/PUBLIC_IP.txt
curl -s http://169.254.169.254/latest/meta-data/public-hostname -o $HOME/environment/info/PUBLIC_DNS.txt && chown ec2-user: $HOME/environment/info/PUBLIC_DNS.txt

# Instalação de componentes:
printf "\n Configurando Dependencias \n"
sudo yum install -y tmux jq

printf "\n Instalando o docker-compose \n"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Download e instalação do kubectl
printf "\n Instalando o cliente do Kubernetes \n"
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

printf "\n Gravando alterações no .bashrc \n"
echo "export AWS_REGION=$(curl --silent http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)" >> $HOME/.bashrc
echo "export ANSIBLE_HOST_KEY_CHECKING=False" >> $HOME/.bashrc
}

configure_access () {

export PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
export PUBLIC_DNS=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)

printf "Identificando o SecurityGroup do projeto"
aws ec2 describe-security-groups --filters Name=group-name,Values=*aws-cloud9* --query "SecurityGroups[*].[GroupName]" --output table

# Definindo o SECURITY GROUP atual
CURRENT_SG=$(aws ec2 describe-security-groups --filters Name=group-name,Values=*aws-cloud9* --query "SecurityGroups[*].[GroupId]" --output text)

# Autorizando acessos
for GROUP_ID in $(aws ec2 describe-security-groups --filters Name=group-name,Values=default --query "SecurityGroups[*].[GroupId]" --output text)
do
aws ec2 authorize-security-group-ingress --group-id $GROUP_ID --protocol tcp --port 0-65535 --source-group $CURRENT_SG
aws ec2 authorize-security-group-ingress --group-id $GROUP_ID --protocol icmp --port -1 --source-group $CURRENT_SG
aws ec2 authorize-security-group-ingress --group-id $GROUP_ID --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $GROUP_ID --protocol tcp --port 443 --cidr 0.0.0.0/0
done

aws ec2 authorize-security-group-ingress --group-id $CURRENT_SG --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $CURRENT_SG --protocol tcp --port 443 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $CURRENT_SG --protocol tcp --port 8080 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $CURRENT_SG --protocol tcp --port 3000 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $CURRENT_SG --protocol tcp --port 5000 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $CURRENT_SG --protocol tcp --port 9090 --cidr 0.0.0.0/0

}

# ==============================================================================================================================

resize
configure_deps
configure_access

printf "\n Configurando Enviroment Env \n"
bash
