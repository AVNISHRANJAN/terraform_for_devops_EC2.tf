# 🚀 Terraform AWS EC2 Auto Setup (Beginner Friendly)

This project helps you **create and manage 3 AWS EC2 instances automatically** using Terraform — even if you don’t know coding.

---

## 📌 What This Project Does

✅ Creates 3 EC2 servers
✅ Opens SSH (22) and HTTP (80) ports
✅ Uses default AWS VPC
✅ Allows you to **START / STOP instances (without deleting)**
✅ Fully automated using Terraform

---

## 🧰 Requirements (Before You Start)

You need:

* AWS Account (Free Tier works)
* AWS CLI installed
* Terraform installed

---

## ⚙️ Step 1: Install Tools

### Install Terraform

Download from: https://developer.hashicorp.com/terraform/downloads

### Install AWS CLI

```bash
sudo apt update
sudo apt install awscli -y
```

---

## 🔑 Step 2: Configure AWS

Run this command:

```bash
aws configure
```

Enter:

* AWS Access Key
* AWS Secret Key
* Region → `us-east-1`
* Output → `json`

---

## 📂 Step 3: Clone This Project

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
cd YOUR_REPO_NAME
```

---

## 🚀 Step 4: Run Terraform

### Initialize

```bash
terraform init
```

### Create 3 EC2 Instances

```bash
terraform apply -auto-approve
```

---

## 🟢 Step 5: Start / Stop Instances

### ▶️ Start Instances

```bash
terraform apply -var="instance_state=running" -auto-approve
```

### ⏹️ Stop Instances (Save Money 💰)

```bash
terraform apply -var="instance_state=stopped" -auto-approve
```

---

## 🧹 Step 6: Delete Everything (Optional)

If you want to remove all resources:

```bash
terraform destroy -auto-approve
```

---

## 📊 What You Will See in AWS

* 3 EC2 instances running
* Security group with:

  * Port 22 (SSH)
  * Port 80 (HTTP)

---

## ⚠️ Important Notes

* Default region: `us-east-1`
* Free tier recommended (t3.micro)
* Always stop instances to avoid charges 💰

---

## 🧠 How This Works (Simple Explanation)

Terraform is a tool that:
👉 Reads configuration
👉 Creates resources in AWS
👉 Manages everything automatically

No manual clicking needed!

---

## 👨‍💻 Author

Avnish Ranjan
DevOps | AWS | Terraform

---

## ⭐ Support

If this helped you:
👉 Star ⭐ this repository
👉 Share with friends

---

## 🚀 Future Improvements

* Load Balancer setup
* Auto install Docker
* CI/CD using GitHub Actions
* Auto shutdown using scheduler

---
