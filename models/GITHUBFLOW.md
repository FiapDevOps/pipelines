# Uma demonstração do GitHub Flow:

Trata-se de uma das estratégias mais simples descrito muitas vezes como um “lightweight workflow” criado a partir de 2011;

Como o modelo baseia-se basicamente na configuração de fluxo com Pull Request e mecanismos de aprovação, neste laboratório sua implantação será executada adicionando a integração contínua entre o CI e o repositório da aplicação:

1. [Webhook](#Webhook)
2. [Configuração_Repo](#Configuração_Repo)
3. [Configuração_CI](#Configuração_CI)

---

## Webhook  <a name="Webhook"></a>

O Jenkins utiliza o modelo de webhooks, o que significa que pode ser configurado para escutar por POST em uma URL pré-definida, que será fornecida ao repositório no GitHub, dessa forma, sempre que o código for enviado para esse repositório, o GitHub enviará um POST para a URL do Hook e o Jenkins executará o job.

1.1 Para obter o URL do gancho do Jenkins, abra o Painel Jenkins.

1.2 Vá para: **Manage jenkins** > **Configure System**

1.3 Dentro da sessão GitHub Plugin clique na guia **'Advanced'**.

1.4 Uma caixa de texto será exibida com uma URL, Copie este URL e vá para a próxima etapa.

---

## Configuração_Repo  <a name="Configuração_Repo"></a>

**Configurando o repositório do GitHub**

2.1 Precisamos fornecer a URL do webhook do Jenkins coletada na etapa anterior;

2.2 Abra seu repositório no GitHub;

2.3 Clique em **'Configurações'** na barra de navegação no lado direito da tela;

2.4 Clique em **'Webhooks'** na barra de navegação no lado esquerdo da tela;

3.5 Clique em **'Adicionar webhook'** e coloque a URL;

> Você pode selecionar os eventos para os quais deseja que o job de Jenkins seja acionado. Selecionaremos "Apenas o evento de push";

---

## Configuração_CI  <a name="Configuração_CI"></a>

Para especificar quais construções de job precisam ser executadas a partir do webhook precisamos modificar a configuração do projeto:

3.1 No Jenkins, vá para a configuração do projeto que você deseja executar com base no webhook;

3.2 Na seção **‘Build Triggers’**, selecione **'Github hook trigger for GITScm Polling'**.

3.3 Clique em **‘Save’** para finalizar

3.4 **Opcional:** Se quiser você poderá configurar restrições forçando o processo de pull request para garantir a atuação no modelo proposto pelo GitHub Flow, para isso verifique como executar a alterações no SCM como no exemplo abaixo baseado em Git:
[Habilitar revisões obrigatórias para pull requests
](https://help.github.com/pt/github/administering-a-repository/enabling-required-reviews-for-pull-requests)

---

##### Fiap - MBA Full Stack Developer | DevOps
profhelder.pereira@fiap.com.br

**Free Software, Hell Yeah!**

