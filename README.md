<h1>🧱 Task 3: Infrastructure as Code (IaC) with Terraform - Provision Docker Container</h1>
<h2>📌 Objective</h2>
Provision a local Docker container (NGINX) using Terraform, applying Infrastructure as Code (IaC) principles.

<h2>📚 Table of Contents</h2>
* Tools Used

* Project Structure

* Prerequisites

* Step-by-Step Workflow

* Output

* Cleanup

* Outcome

<h2>🧰 Tools Used</h2>
|    Tool	   |           Description                  |
|Terraform	   |  IaC tool to provision infrastructure  |
|Docker	       |  Containerization platform             |
|Provider	   |  kreuzwerker/docker for Docker control |

<h2>📁 Project Structure</h2>

```
terraform-docker-container/ ├── main.tf ├── terraform.tfstate ├── README.md └── logs/ ├── terraform-init.log ├── terraform-plan.log ├── terraform-apply.log ├── terraform-state.log └── terraform-destroy.log
```

<h2>⚙️ Prerequisites</h2>
Install the following:

* Terraform: https://developer.hashicorp.com/terraform/downloads
* Docker: https://docs.docker.com/get-docker/
Verify installations: terraform -version docker --version docker info

<h2>🚀 Step-by-Step Workflow</h2>
<h3>1️⃣ Create Terraform Configuration (main.tf)</h3>

```
terraform { required_providers { docker = { source = "kreuzwerker/docker" version = "~> 3.0.2" } } }

provider "docker" {}

resource "docker_image" "nginx_image" { name = "nginx:latest" keep_locally = true }

resource "docker_container" "nginx_container" { name = "my-nginx" image = docker_image.nginx_image.name ports { internal = 80 external = 8080 } }
```

<h3>2️⃣ Initialize Terraform</h3>

```
terraform init | tee logs/terraform-init.log
```

<h3>3️⃣ Preview Plan</h3>

```
terraform plan | tee logs/terraform-plan.log
```

<h3>4️⃣ Apply Configuration</h3>

```
terraform apply -auto-approve | tee logs/terraform-apply.log
```

<h3>5️⃣ Verify Container</h3>

```
docker ps Visit: http://localhost:8080
```

<h3>6️⃣ Check Terraform State</h3>

```
terraform state list | tee logs/terraform-state.log
```

<h2>📸 Output</h2>

```
Container: nginx:latest Port Mapping: 8080:80 Browser: http://localhost:8080 (NGINX welcome page)
```

<h2>🧹 Cleanup</h2>

```
terraform destroy -auto-approve | tee logs/terraform-destroy.log
```

<h2>✅ Outcome</h2>
* Used Terraform as IaC
* Pulled and deployed Docker image
* Managed infrastructure lifecycle using Terraform
