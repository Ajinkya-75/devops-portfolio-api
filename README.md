# Serverless DevOps API with CI/CD 🚀

A high-performance, serverless REST API built with **FastAPI**, containerized with **Docker**, and deployed to **AWS Lambda** using **Terraform** (Infrastructure as Code).

The project features a fully automated **CI/CD pipeline** via **GitHub Actions** that builds, tests, and deploys the application to the cloud on every code change.

![Build Status](https://img.shields.io/badge/build-passing-brightgreen) ![Terraform](https://img.shields.io/badge/terraform-v1.0+-623CE4) ![AWS](https://img.shields.io/badge/AWS-Serverless-orange)

---

## 🏗 Architecture Overview

The infrastructure is designed to be **serverless**, meaning zero server management and automatic scaling.

1.  **Code Push:** Developer commits code to the `master` branch.
2.  **GitHub Actions:** The CI/CD pipeline triggers automatically.
3.  **Docker Build:** The application is packaged into a lightweight container.
4.  **Registry Push:** The container image is pushed to **AWS ECR** (Elastic Container Registry).
5.  **Deployment:** **AWS Lambda** is updated to pull the new image, making the changes live instantly.

---

## 🛠 Tech Stack

| Component | Technology | Description |
| :--- | :--- | :--- |
| **Backend Framework** | Python (FastAPI) | High-performance, async-ready web framework. |
| **Containerization** | Docker | Ensures the app runs reliably in any environment. |
| **Infrastructure as Code** | Terraform | Provisions AWS resources (ECR, Lambda, IAM) programmatically. |
| **Cloud Provider** | AWS | Hosting using Lambda (Compute) and ECR (Storage). |
| **CI/CD** | GitHub Actions | Automates the build and deployment workflow. |

---

## ⚡ Key Features

* **Zero-Downtime Deployment:** Updates are rolled out seamlessly via AWS Lambda.
* **Infrastructure as Code:** The entire cloud environment can be destroyed and recreated with a single command (`terraform apply`).
* **Cost Efficient:** Uses AWS Free Tier eligible resources.
* **Secure by Design:** Uses IAM Roles with least-privilege permissions.

---

## 🚀 How to Run Locally

If you want to test the application on your own machine without AWS:

1.  **Clone the Repository**
    ```bash
    git clone [https://github.com/Ajinkya-75/devops-portfolio-api.git](https://github.com/Ajinkya-75/devops-portfolio-api.git)
    cd devops-portfolio-api
    ```

2.  **Build the Docker Image**
    ```bash
    docker build -t devops-api .
    ```

3.  **Run the Container**
    ```bash
    docker run -p 9000:8080 devops-api
    ```

4.  **Test the Endpoint**
    Open your browser to: `http://localhost:9000`
    * *You should see: `{"Hello": "From GitHub Actions!..."}`*

---

## ☁️ How to Deploy (Infrastructure as Code)

**Prerequisites:**
* AWS CLI configured with credentials.
* Terraform installed.

**Steps:**
1.  **Navigate to the Terraform directory:**
    ```bash
    cd terraform
    ```

2.  **Initialize Terraform:**
    ```bash
    terraform init
    ```

3.  **Plan and Apply:**
    ```bash
    terraform apply
    # Type 'yes' when prompted
    ```

4.  **View Output:**
    Terraform will output your public API URL at the end:
    `function_url = "https://<your-url>.lambda-url.ap-south-1.on.aws/"`

---

## 🤖 CI/CD Setup (GitHub Actions)

This project includes a pre-configured pipeline in `.github/workflows/deploy.yml`.

To enable it for your own fork:
1.  Go to your GitHub Repo -> **Settings** -> **Secrets and variables** -> **Actions**.
2.  Add the following repository secrets:
    * `AWS_ACCESS_KEY_ID`
    * `AWS_SECRET_ACCESS_KEY`

Once added, any push to the `master` branch will automatically deploy your code to AWS.

---

## 📄 License
This project is open-source and available under the MIT License.