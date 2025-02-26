# Projeto final da Disciplina Computação em Nuvem - Engenharia de Software - UNIFOR 

## Equipe
- Arimatéia Júnior  - Matrícula: 2417061
- Karime Linhares   - Matrícula: 
- Bruno             - Matrícula: 2417061
- Pedro             - Matrícula: 2417061
- Anderson          - Matrícula: 2417061

## Descrição do Projeto

Este projeto é uma aplicação simples que simula o jogo Round 6. A aplicação está implantada via IaC (Infrastructure as Code) utilizando Terraform na AWS. Este projeto foi desenvolvido como atividade final da disicplina de Computação em Nuvem.

### Requisitos do Projeto

1. **Código-Fonte**: Utilizamos GitHub, segue link: [https://github.com/arijunior2020/round6-game]
2. **Construção da Aplicação**: Utilizamos AWS CodeBuild para compilar e criar a imagem Docker. Criamos dois arquivos `buildspec.yml` um na raiz que criar o build sem o uso do terraform (Estrutura que criamos sem uso do terraform) e criamos outro dentro de `codebuild`que esse é utilizado no pipeline do terraform.
3. **Registro da Imagem**: Armazenamos a imagem no Amazon ECR.
4. **Orquestração**: Utilizamos AWS ECS (Fargate) para implantar o container da aplicação.
5. **Implantação Automatizada**: Utilize AWS CodePipeline para automatizar o fluxo CI/CD.
6. **Monitoramento**: Configuramos CloudWatch Logs para armazenar logs da aplicação.

## Pipeline CI/CD na AWS com Terraform

O Objetivo é implementar toda infraestrutura e pipeline via Infraestrutura como código (IaC), no caso utilizamos Terraform como ferramenta.

### Requisitos da Automação

1. Criamos os arquivos `.tf` organizados (ex: `main.tf`, `variables.tf`, `outputs.tf`).
2. Utilizamos módulos para organizar os recursos (ex: cloudwatch, cloudbuild, codepipeline, codestar, ecr, ecs, elb e vpc).
3. Aplicamos as boas práticas de reutilização e versionamento.
4. Testamos a criação e destruição da infraestrutura com os comandos (`terraform apply` e `terraform destroy`).
5. A reutilização do código Terraform em diferentes ambientes pode ser feita de forma eficiente através da parametrização de variáveis e do uso de workspaces do Terraform. No nosso caso utilizamos um arquivo terraform.tfvars para guardar as variaveis de ambiente que são referenciadas dentros dos arquivos dos módulos, lembrando que esse arquivo não é commitado para o repositório, para utilização de demais ambientes, exemplo:
```
   terraform/
├── envs/
│   ├── dev.tfvars
│   ├── staging.tfvars
│   ├── prod.tfvars
```
### Variáveis de Ambiente

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

### Entregaveis

- Descrição do fluxo CI/CD e diagrama da arquitetura.
- Print das configurações do pipeline.
- Justificativa das escolhas dos serviços AWS.

### Entrega

- Código Terraform comentado e funcional.

### Explicação dos Módulos e Variáveis

#### Módulos

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

#### Variáveis

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


### Comprovação da Execução

- Comando `terraform apply` executado com sucesso.
- Comando `terraform destroy` executado com sucesso.


- Comprovação da execução (`terraform apply` e `terraform destroy`).

## Diagrama da Arquitetura

![Diagrama da Arquitetura](img/Diagrama%20Round6.drawio.png)

## Prints das Configurações do Pipeline

![Print 1](path/to/print1.png)
![Print 2](path/to/print2.png)

## Justificativa das Escolhas dos Serviços AWS

- **AWS CodeCommit/GitHub**: Escolhido pela integração nativa com outros serviços AWS e pela facilidade de uso.
- **AWS CodeBuild**: Permite a construção automatizada da aplicação e criação de imagens Docker.
- **Amazon ECR**: Serviço gerenciado de registro de contêineres, integrado com o AWS ECS.
- **AWS ECS (Fargate)**: Permite a execução de contêineres sem a necessidade de gerenciar servidores.
- **AWS CodePipeline**: Automatiza o fluxo de CI/CD, integrando todos os serviços mencionados.
- **CloudWatch Logs**: Facilita o monitoramento e a depuração da aplicação.

## Código Terraform

### Estrutura de Arquivos
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

