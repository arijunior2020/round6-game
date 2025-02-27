### 🚀 Projeto Final - Computação em Nuvem | Engenharia de Software - UNIFOR

### 👥 Equipe

- Arimatéia Júnior - Matrícula: 2417061
- Karime Linhares - Matrícula: 2416877
- Bruno Negreiros - Matrícula: 2419432
- Pedro Henrique - Matrícula: 2325859
- Anderson Karl - Matrícula: 2417571

### 📝 Descrição do Projeto

Este projeto consiste em uma aplicação inspirada na série _Round 6_, implantada por meio de _Infrastructure as Code_ (**IaC**) utilizando **Terraform na AWS**.

Desenvolvido como atividade final da disicplina de Computação em Nuvem, o projeto tem como objetivo demonstrar a implantação automatizada de um infraestrutura escalável na nuvem.

#

### 🛠️ Tecnologias e Ferramentas Utilizadas

- **Terraform** 🏗️ - Provisionamento de infraestrutura

- **AWS ECS (Fargate)** 🚢 - Orquestração de containers
- **Amazon ECR** 📦 - Armazenamento de imagens Docker
- **AWS CodeBuild** 🔨 - Construção de aplicação
- **AWS CodePipeline** 🔄 - Orquestração de pipeline de entrega contínua
- **AWS CloudWatch** 📊 - Monitoramento de Logs

#

### ✅ Requisitos do Projeto

1. **Código-Fonte**: Foi utilizado GitHub como repositório, está disponível em: [GitHub](https://github.com/arijunior2020/round6-game)

2. **Construção da Aplicação**: O AWS CodeBuild compila a aplicação e gera a imagem Docker, contando com dois arquivos `buildspec.yml`:

   - Um localizado na raiz do projeto, responsável por compilar a estrutura manualmente;
   - E outro localizado dentro da pasta `codebuild`, integrado no pipeline do Terraform.

3. **Registro da Imagem**: A imagem Docker é armazenada no Amazon ECR.

4. **Orquestração**: O AWS ECS (Fargate) gerencia a implantação do container.

5. **Implantação Automatizada**: O fluxo CI/CD é orquestrado pelo AWS CodePipeline.

6. **Monitoramento**: Os Logs da aplicação são gerenciados pelo CloudWatch Logs.

#

### ⚙️ Infraestrutura e Automação

A infraestrutura foi definida via _IaC_ e organizada em arquivos Terraform bem estruturados, garantindo modularidade e reaproveitamento do código.

### 🔍 Requisitos da Automação

**1.** Organização dos arquivos `.tf` de forma estruturada (por exemplo: `main.tf`, `variables.tf`, `outputs.tf`).

**2.** Adoção de módulos para estruturar os recursos (exemplos: cloudwatch, codebuild, codepipeline, codestar, ecr, ecs, elb e vpc).

**3.** Aplicação das melhores práticas de reutilização e versionamento.

**4.** Validação da criação e destruição da infraestrutura com os comandos `terraform apply` e `terraform destroy`.

**5.** Reuso do código Terraform em diferentes ambientes por meio da parametrização de variáveis e do emprego de workspaces. Um arquivo `terraform.tfvars` armazena as variáveis de ambiente referenciadas nos módulos, sendo este excluído do commit para manter a segregação entre ambientes, conforme exemplo:

```
   terraform/
├── envs/
│   ├── dev.tfvars
│   ├── staging.tfvars
│   ├── prod.tfvars
```

### 🔹Estrutura de Código

- Arquivos `.tf` organizados em módulos:

  - `vpc` - Configuração de redes e sub-redes
  - `ecs` - Cluster e serviços para a execução dos containers
  - `ecr` - Registro de imagens Docker
  - `codebuild` - Compilação e criação de imagens Docker
  - `codepipeline` - Pipeline de _CI/CD_ completo
  - `cloudwatch` - Monitoramento e armazenamento de logs

#

### ♾️ Pipeline CI/CD na AWS com Terraform

O Objetivo foi a implementação toda a infraestrutura e pipeline via Infraestrutura como código (_IaC_), tendo o Terraform como ferramenta.

### 🎈 Variáveis de Ambiente

As variáveis podem ser definidas em arquivos separados para cada ambiente, como `dev.tfvars` e `prod.tfvars`, permitindo fácil troca de configurações entre os ambientes.

```terraform
# Exemplo de dev.tfvars
aws_region     = "us-east-1"
github_owner   = "arijunior2020"
github_repo    = "round6-game"
github_token   = "your_github_token"
vpc_cidr       = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["us-east-1a", "us-east-1b"]
dockerhub_username = "your_dockerhub_username"
dockerhub_password = "your_dockerhub_password"
codebuild_project_name = "round6-game-build-terraform"
ecs_cluster_name = "round6-game-cluster-terraform"
ecs_service_name = "round6-game-service-terraform"
ecr_repository_name = "round6-game-terraform"
```

### Exemplo de Uso de Workspaces

O código Terraform pode ser reutilizado em diferentes ambientes (dev, staging, prod) através da parametrização das variáveis e da utilização de workspaces do Terraform. Isso permite que a mesma configuração de infraestrutura seja aplicada em diferentes contextos, garantindo consistência e facilidade de manutenção.

```sh
# Criar e selecionar o workspace de desenvolvimento
terraform workspace new dev
terraform workspace select dev

# Aplicar a infraestrutura no ambiente de desenvolvimento
terraform apply -var-file="dev.tfvars"

# Criar e selecionar o workspace de produção
terraform workspace new prod
terraform workspace select prod

# Aplicar a infraestrutura no ambiente de produção
terraform apply -var-file="prod.tfvars"
```

#

### ✅ Entregáveis

- Descrição do fluxo CI/CD e diagrama da arquitetura.
Passo a Passo do Fluxo CI/CD
1.	Commit no GitHub: O desenvolvedor faz um commit no repositório GitHub.
2.	AWS CodePipeline: Detecta o commit e inicia o pipeline.
3.	AWS CodeStar: Conecta o CodePipeline ao repositório GitHub.
4.	AWS CodeBuild: Compila o código e cria a imagem Docker.
5.	Amazon ECR: Armazena a imagem Docker criada.
6.	AWS ECS (Fargate): Implanta a imagem Docker em contêineres.
7.	Elastic Load Balancer (ELB): Distribui o tráfego para os contêineres ECS.
8.	Amazon CloudWatch Logs: Coleta e armazena os logs da aplicação.

- Print das configurações do pipeline.
- 
- Justificativa das escolhas dos serviços AWS.

### 🔹Entrega

- Código Terraform comentado e funcional.

### ✏️ Módulos e Variáveis

#### 🔹 Módulos

- **modules/**: Contém módulos reutilizáveis para diferentes recursos.

- **vpc**: Configura a VPC, sub-redes públicas e privadas, e grupos de segurança.

  - **main.tf**: Define a VPC, sub-redes e grupos de segurança.
  - **variables.tf**: Define as variáveis necessárias para configurar a VPC.
  - **outputs.tf**: Define as saídas, como IDs da VPC e sub-redes.

- **ecr**: Configura o repositório do Amazon ECR para armazenar as imagens Docker.

  - **main.tf**: Define o repositório ECR.
  - **variables.tf**: Define as variáveis necessárias para configurar o ECR.
  - **outputs.tf**: Define as saídas, como o URL do repositório ECR.

- **codebuild**: Configura o projeto do AWS CodeBuild para construir a aplicação e criar a imagem Docker.

  - **main.tf**: Define o projeto CodeBuild e suas configurações.
  - **variables.tf**: Define as variáveis necessárias para configurar o CodeBuild.
  - **outputs.tf**: Define as saídas, como o nome do projeto CodeBuild.

- **ecs**: Configura o cluster do ECS (Fargate) e os serviços necessários para rodar o container.

  - **main.tf**: Define o cluster ECS, tarefas e serviços.
  - **variables.tf**: Define as variáveis necessárias para configurar o ECS.
  - **outputs.tf**: Define as saídas, como o nome do cluster ECS e o ARN do serviço.

- **codestar**: Configura a conexão do CodeStar para integração com o GitHub.

  - **main.tf**: Define a conexão CodeStar.
  - **variables.tf**: Define as variáveis necessárias para configurar o CodeStar.
  - **outputs.tf**: Define as saídas, como o ARN da conexão CodeStar.

- **codepipeline**: Configura o pipeline do AWS CodePipeline para automatizar o fluxo CI/CD.

  - **main.tf**: Define o pipeline CodePipeline e suas etapas.
  - **variables.tf**: Define as variáveis necessárias para configurar o CodePipeline.
  - **outputs.tf**: Define as saídas, como o nome do pipeline CodePipeline.

- **cloudwatch**: Configura o CloudWatch Logs para monitoramento e depuração da aplicação.

  - **main.tf**: Define os grupos de logs do CloudWatch.
  - **variables.tf**: Define as variáveis necessárias para configurar o CloudWatch.
  - **outputs.tf**: Define as saídas, como o ARN dos grupos de logs.

- **elb**: Configura o Elastic Load Balancer para distribuir o tráfego para os containers.
  - **main.tf**: Define o Load Balancer e suas configurações.
  - **variables.tf**: Define as variáveis necessárias para configurar o Load Balancer.
  - **outputs.tf**: Define as saídas, como o DNS do Load Balancer.

#### 🔹 Variáveis

- **aws_region**: Região da AWS onde os recursos serão criados.
- **github_owner**: Dono do repositório GitHub.
- **github_repo**: Nome do repositório GitHub.
- **github_token**: Token de acesso ao GitHub.
- **vpc_cidr**: CIDR da VPC.
- **public_subnets**: Lista de sub-redes públicas.
- **private_subnets**: Lista de sub-redes privadas.
- **availability_zones**: Lista de zonas de disponibilidade.
- **dockerhub_username**: Nome de usuário do DockerHub.
- **dockerhub_password**: Senha do DockerHub.
- **codebuild_project_name**: Nome do projeto CodeBuild.
- **ecs_cluster_name**: Nome do cluster ECS.
- **ecs_service_name**: Nome do serviço ECS.
- **ecr_repository_name**: Nome do repositório ECR.
- **codestar_connection_arn**: ARN da conexão CodeStar.

#

### 📊 Diagrama da Arquitetura

![Diagrama da Arquitetura](img/Diagrama%20Round6%20Atualizado.drawio.png)

#

### 📸 Prints do Pipeline

![Captura de tela 2025-02-27 202053](https://github.com/user-attachments/assets/17bf4893-1e99-4b5f-ab68-0c8136d44171)

### AWS CodeBuild
![Captura de tela 2025-02-26 212423](https://github.com/user-attachments/assets/9dcd23cf-0178-4228-9957-d820056f6abf)

* Pipeline sem o Terraform
![Captura de tela 2025-02-26 212752](https://github.com/user-attachments/assets/0a36ccf9-f413-472b-8c43-9bad868455cd)
![Captura de tela 2025-02-26 212834](https://github.com/user-attachments/assets/dad3d474-5303-4af9-8c9b-2bc4625ca3a1)
![Captura de tela 2025-02-26 212851](https://github.com/user-attachments/assets/9c3bcaa3-ebf3-4be0-9ba7-649e5337c499)

* Pipeline com o Terraform
![Captura de tela 2025-02-26 212942](https://github.com/user-attachments/assets/60d36159-a910-4917-a334-ff1e2802d32d)
![Captura de tela 2025-02-26 212916](https://github.com/user-attachments/assets/1f83aed6-fb47-4d78-8704-e3f4ca0f54ab)
![Captura de tela 2025-02-26 212930](https://github.com/user-attachments/assets/a0dcb338-2426-4406-969c-15b09bb9d5c2)

### AWS ECR
![Captura de tela 2025-02-26 213032](https://github.com/user-attachments/assets/f84b0ca8-14bc-405c-b834-7cbd1b95019a)

* Pipeline sem o Terraform
![Captura de tela 2025-02-26 213047](https://github.com/user-attachments/assets/f1e792f8-8c08-4b3c-93c7-92efba7bd5fe)
![Captura de tela 2025-02-26 213100](https://github.com/user-attachments/assets/1d428cdb-2825-4a92-8706-5922443338b9)
![Captura de tela 2025-02-26 213231](https://github.com/user-attachments/assets/0836dd26-8c32-4444-af87-61b0014ba5ce)

* Pipeline com o Terraform
![Captura de tela 2025-02-26 213139](https://github.com/user-attachments/assets/c43d01ed-f11c-4cdd-94b0-d66ecadabc1c)
![Captura de tela 2025-02-26 213151](https://github.com/user-attachments/assets/60173622-7d80-4257-a89a-1e46e5e67eda)
![Captura de tela 2025-02-26 213214](https://github.com/user-attachments/assets/50f3581b-107b-4295-873f-4f256b32e98f)

### AWS ECS
![Captura de tela 2025-02-26 213300](https://github.com/user-attachments/assets/c81dba32-f699-4b60-b751-252041a47f5c)

* Pipeline sem o Terraform
![Captura de tela 2025-02-26 213312](https://github.com/user-attachments/assets/d645f500-9265-4fd0-9656-7dc23bb5ed81)
![Captura de tela 2025-02-26 213324](https://github.com/user-attachments/assets/96185569-bafd-4a00-8030-1026fdf4b57b)
![Captura de tela 2025-02-26 213338](https://github.com/user-attachments/assets/ecbfb283-fdaf-4b3d-a73d-e0c80cd1894d)
![Captura de tela 2025-02-26 213358](https://github.com/user-attachments/assets/6f0af173-ba9b-4159-9aa4-c8729d193e65)
![Captura de tela 2025-02-26 213413](https://github.com/user-attachments/assets/0da780b5-774d-431d-baf6-448973506eac)
![Captura de tela 2025-02-26 213453](https://github.com/user-attachments/assets/337275c2-877c-4f3b-bcea-c27bb07361f9)
![Captura de tela 2025-02-26 213511](https://github.com/user-attachments/assets/69f9601f-0cc6-4b6c-89fb-4b9c3be7eebb)
![Captura de tela 2025-02-26 213529](https://github.com/user-attachments/assets/b7a6f46d-89be-4ad0-b636-d2a30782cd49)
![Captura de tela 2025-02-26 213545](https://github.com/user-attachments/assets/6d7c8405-92f9-4114-8f64-a9fa835cd69d)
![Captura de tela 2025-02-26 213613](https://github.com/user-attachments/assets/7817f83d-62e6-4d65-91ac-2f9a95b6b686)
![Captura de tela 2025-02-26 213634](https://github.com/user-attachments/assets/2b152342-3015-4b5c-94cf-347aa5cd4732)

* Pipeline com o Terraform
![Captura de tela 2025-02-26 213724](https://github.com/user-attachments/assets/16987748-f129-4f00-b209-6f2bc271f3e8)
![Captura de tela 2025-02-26 213740](https://github.com/user-attachments/assets/60113e80-5023-4938-890d-a715e57c3479)
![Captura de tela 2025-02-26 213811](https://github.com/user-attachments/assets/0188a2d6-50dd-45e0-a930-687a7f221fdc)
![Captura de tela 2025-02-26 213822](https://github.com/user-attachments/assets/1e2f5725-3bea-4cac-a5a0-d88fb75a0362)
![Captura de tela 2025-02-26 213831](https://github.com/user-attachments/assets/aa815594-ec38-4714-8898-bc81bde71dd6)
![Captura de tela 2025-02-26 213847](https://github.com/user-attachments/assets/27535833-40a2-410d-a411-dc639c2f1b30)
![Captura de tela 2025-02-26 213902](https://github.com/user-attachments/assets/58ef6e9b-d6ee-47a3-98cb-136adc4180f3)
![Captura de tela 2025-02-26 213914](https://github.com/user-attachments/assets/4006c359-2ed4-446a-a44f-6aebb1bdc196)
![Captura de tela 2025-02-26 213928](https://github.com/user-attachments/assets/84172fea-09a5-4fcd-b6c8-a753496ca4c4)
![Captura de tela 2025-02-26 213935](https://github.com/user-attachments/assets/94ebb2f2-1401-461a-aa90-eecfe4757bac)
![Captura de tela 2025-02-26 213953](https://github.com/user-attachments/assets/51bf5f6b-e2c8-4c34-bd0d-db7d0cd9075f)
![Captura de tela 2025-02-26 214002](https://github.com/user-attachments/assets/97791896-244f-40d6-900c-9aa0bc0d50a0)

### AWS CodePipeline
![Captura de tela 2025-02-26 214029](https://github.com/user-attachments/assets/bc14155f-e881-4376-86fa-1c9c364976d5)

* Pipeline sem o Terraform
![Captura de tela 2025-02-26 214040](https://github.com/user-attachments/assets/389e901d-ce9c-4345-b90c-be1462b7c5b3)
![Captura de tela 2025-02-26 214156](https://github.com/user-attachments/assets/69a91cd6-bceb-4b9c-b81e-65d13a74be01)
![Captura de tela 2025-02-26 214216](https://github.com/user-attachments/assets/56a952b5-15fb-46de-beed-0c3833f10359)
![Captura de tela 2025-02-26 214256](https://github.com/user-attachments/assets/4c564fa7-6916-4818-a3d3-1931fc2ea863)
![Captura de tela 2025-02-26 214306](https://github.com/user-attachments/assets/e321a36e-4540-4b4f-b3cd-5ee033f6e954)
![Captura de tela 2025-02-26 214320](https://github.com/user-attachments/assets/bbc4680a-b0df-44e6-a9f3-5f32da0c1d59)
![Captura de tela 2025-02-26 214348](https://github.com/user-attachments/assets/eeb01660-137f-4f0e-8998-339019e61f7e)

* Pipeline com o Terraform
![Captura de tela 2025-02-26 214414](https://github.com/user-attachments/assets/25ac5087-d176-4591-bd4b-c73cfb34ca4c)
![Captura de tela 2025-02-26 214428](https://github.com/user-attachments/assets/4c98a30c-9dd9-49e3-972e-184c1b5a0312)
![Captura de tela 2025-02-26 214453](https://github.com/user-attachments/assets/c4b96c8e-d048-49f6-868a-4a4123f11396)
![Captura de tela 2025-02-26 214504](https://github.com/user-attachments/assets/e73b4f42-fa7f-462a-95f1-274bb99a201e)
![Captura de tela 2025-02-26 214517](https://github.com/user-attachments/assets/2e4c9fee-66c9-4c84-a2a8-332c0535af56)
![Captura de tela 2025-02-26 214527](https://github.com/user-attachments/assets/eefc2248-dc9d-47c4-9f11-959aaa78043d)

### AWS CloudWatch
![Captura de tela 2025-02-26 214644](https://github.com/user-attachments/assets/b8030b77-592f-4c3c-9fd5-5008deae2c0c)
![Captura de tela 2025-02-26 214705](https://github.com/user-attachments/assets/ea1331ba-0cd5-4e09-9cda-2dc644ec29d7)
![Captura de tela 2025-02-26 214730](https://github.com/user-attachments/assets/730c66a2-d674-4fbf-9acf-3183afe75d38)
![Captura de tela 2025-02-26 214825](https://github.com/user-attachments/assets/b2ab5447-9490-4e60-98d4-b55c3b956990)
![Captura de tela 2025-02-26 214851](https://github.com/user-attachments/assets/03c70f40-5bc9-4cf8-b2f0-61b802e02361)

- Comando `terraform apply` executado com sucesso.
![Imagem do WhatsApp de 2025-02-27 à(s) 20 09 23_a5cb306e](https://github.com/user-attachments/assets/6b9d318c-b469-417c-bd00-b9ddff66301d)
![Imagem do WhatsApp de 2025-02-27 à(s) 20 10 54_4415852e](https://github.com/user-attachments/assets/209f2f49-b726-461c-8ebd-0e7b354dda08)
![Imagem do WhatsApp de 2025-02-27 à(s) 20 13 42_fc9b35b8](https://github.com/user-attachments/assets/b68cc295-ee44-46cc-9b5a-4cb92e923b71)

- Comando `terraform destroy` executado com sucesso.
![Imagem do WhatsApp de 2025-02-27 à(s) 20 05 11_1246b7db](https://github.com/user-attachments/assets/8ddb2632-4bb7-4d76-98d6-e0793eec5459)
![Imagem do WhatsApp de 2025-02-27 à(s) 20 07 25_27029412](https://github.com/user-attachments/assets/681a9f21-df49-4dda-b423-335beb8b9519)

#

### 📈 Justificativa das Escolhas dos Serviços AWS

- **AWS CodeCommit/GitHub**: Escolhido pela integração nativa com outros serviços AWS e pela facilidade de uso.
- **AWS CodeBuild**: Permite a construção automatizada da aplicação e criação de imagens Docker.
- **Amazon ECR**: Serviço gerenciado de registro de contêineres, integrado com o AWS ECS.
- **AWS ECS (Fargate)**: Permite a execução de contêineres sem a necessidade de gerenciar servidores.
- **AWS CodePipeline**: Automatiza o fluxo de CI/CD, integrando todos os serviços mencionados.
- **CloudWatch Logs**: Facilita o monitoramento e a depuração da aplicação.

#

### 💻 Código Terraform

#### 🔹 Estrutura de Arquivos

```
terraform/
├── envs/
│   ├── dev.tfvars
│   ├── staging.tfvars
│   ├── prod.tfvars
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── ecr/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── codebuild/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── ecs/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── codestar/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── codepipeline/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── cloudwatch/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── elb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
├── main.tf
├── variables.tf
├── outputs.tf
```
