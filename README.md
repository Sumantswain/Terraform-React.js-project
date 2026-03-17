# 🚀 CloudDeployed – Production-Ready React App on AWS

## 📌 Project Overview

CloudDeployed is a production-ready cloud project where a React.js application is deployed on AWS using a scalable, highly available, and fault-tolerant architecture.

The application is served using Nginx on EC2 instances, distributed through an Application Load Balancer, and automatically scaled using Auto Scaling Groups. The entire infrastructure is provisioned using Terraform and monitored using CloudWatch.

---

## 🧱 Architecture Diagram

<img width="2528" height="1393" alt="Screenshot 2026-03-17 183224" src="https://github.com/user-attachments/assets/7ea03743-6595-4520-87d2-bcac0699c564" />
<img width="1246" height="543" alt="Screenshot 2026-02-13 171726" src="https://github.com/user-attachments/assets/ab2af019-c966-456e-bf94-c6ce8e325934" />

---

## ⚙️ Tech Stack

* **Frontend:** React.js
* **Web Server:** Nginx
* **Cloud Platform:** AWS
* **Compute:** EC2
* **Load Balancer:** Application Load Balancer (ALB)
* **Scaling:** Auto Scaling Group (ASG)
* **Monitoring:** CloudWatch
* **Infrastructure as Code:** Terraform

---

## 🚀 Key Features

* ✅ Production-ready deployment of React app
* ✅ Load balancing using Application Load Balancer
* ✅ Automatic scaling with Auto Scaling Groups
* ✅ High availability across multiple Availability Zones
* ✅ Infrastructure fully automated using Terraform
* ✅ Centralized logging and monitoring using CloudWatch
* ✅ Fault-tolerant architecture

---

## 🏗️ Architecture Flow

1. User sends request to Application Load Balancer
2. ALB distributes traffic across EC2 instances
3. EC2 instances serve React app via Nginx
4. Auto Scaling Group adjusts number of instances based on load
5. CloudWatch monitors logs, metrics, and triggers scaling

---

## 📸 Screenshots

### 🔹 React Application

<img width="2528" height="1393" alt="Screenshot 2026-03-17 183224" src="https://github.com/user-attachments/assets/6551e5e6-563b-4fca-b5a3-c2e099f6c243" />

### 🔹 EC2 Instances

<img width="2534" height="1519" alt="Screenshot 2026-02-14 162330" src="https://github.com/user-attachments/assets/f13624b3-0a43-4426-83a7-9b8996220bca" />

### 🔹 Application Load Balancer

<img width="2535" height="1514" alt="Screenshot 2026-02-14 162427" src="https://github.com/user-attachments/assets/2157e730-d552-4ea2-acb1-90980b929309" />

### 🔹 Target Group Health Check

<img width="2543" height="1529" alt="Screenshot 2026-02-14 162459" src="https://github.com/user-attachments/assets/29e1e89b-97c6-4bc6-a920-c19c7f760469" />

### 🔹 Auto Scaling Group

<img width="2534" height="1379" alt="Screenshot 2026-02-14 162408" src="https://github.com/user-attachments/assets/26ae56ad-5286-4c78-8fc1-9ee9244f018e" />

### 🔹 Terraform Deployment


## 📁 Project Structure

```
CloudDeployed/
│── terraform/
│   ├── main.tf
│   ├── provider.tf
│   
│
│── app/
│   ├── build/
│
│── screenshots/
│
│── README.md
```

---

## ⚙️ Terraform Configuration Overview

### 🔹 VPC & Subnets

* Uses default AWS VPC and subnets

### 🔹 Security Group

* Allows:

  * Port 22 (SSH)
  * Port 80 (HTTP)

### 🔹 Launch Template

* EC2 configuration with:

  * Ubuntu AMI
  * Nginx + Node.js setup
  * React app build & deployment using user data

### 🔹 Application Load Balancer

* Public-facing ALB
* Routes traffic to EC2 instances

### 🔹 Target Group

* Registers EC2 instances
* Performs health checks

### 🔹 Auto Scaling Group

* Minimum: 1 instance
* Maximum: 3 instances
* Automatically scales based on load

### 🔹 Scaling Policy

* CPU-based scaling
* Automatically adds/removes instances

---

## ⚡ Deployment Steps

### 1️⃣ Clone Repository

```bash
git clone https://github.com/your-username/clouddeployed.git
cd clouddeployed
```
----React Application github link-----
https://github.com/Sumantswain/React.js-project.git

### 2️⃣ Initialize Terraform

```bash
cd terraform
terraform init
```

### 3️⃣ Deploy Infrastructure

```bash
terraform apply
```

### 4️⃣ Access Application

* Copy the **Load Balancer DNS**
* Open in browser

---

## 🔐 Security Considerations

* Restrict SSH access to specific IP (recommended)
* Use IAM roles instead of access keys
* Avoid exposing sensitive ports publicly

---

## 📈 Future Enhancements

* 🔹 Add HTTPS using AWS ACM
* 🔹 Integrate CI/CD (GitHub Actions)
* 🔹 Use S3 + CloudFront for frontend hosting
* 🔹 Implement private subnets and bastion host

---

## 👨‍💻 Author

**Sumant Swain**

---

## ⭐ Support

If you found this project helpful, please give it a ⭐ on GitHub!
