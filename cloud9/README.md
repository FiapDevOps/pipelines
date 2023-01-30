# Fiaplabs

Nesta configuração você fará a preparação da instância que utilizaremos para os laboratórios envolvendo o ambiente AWS;

## 1. Processo de configuração via automação:

1.1. Para configurar automaticamente faça o login na conta da AWS e perfil indicados pelo Professor e em seguida clique no link abaixo para disparar o template de automação:

[![cf-template](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/new?stackName=sandbox&templateURL=https://s3.us-east-1.amazonaws.com/cf-templates-fiaplabs-automation/cloud9-ide-with-ec2-small-instance.template.yaml)

Um exemplo mais complexo com configuração de vpc dentro do processo pode ser consultado neste [template de cloudformation](https://aws-quickstart.s3.amazonaws.com/quickstart-cloud9-ide/doc/aws-cloud9-cloud-based-ide.pdf)

---

## 2. Configuração do repositórios e feramentas de trabalho;

Nesta etapa faremos algumas configurações na instância de onde partirá as automações dos laboratórios práticos;

2.1. Após finalizar o processo anterior um terminal será exibido dentro do Cloud9, acesse e execute o script de instalção das ferramentas que serão usadas durante os laboratórios:


```sh
cd ~/environment
git clone https://github.com/fiapdevops/pipelines

# Execute o script de instalção das ferramentas que serão usadas durante os laboratórios:
chmod +x ~/environment/fiapdevops/pipelines/cloud9/scripts/*.sh
~/environment/fiapdevops/pipelines/cloud9/scripts/config.sh
```

---

##### Fiap - MBA
profhelder.pereira@fiap.com.br

**Free Software, Hell Yeah!**