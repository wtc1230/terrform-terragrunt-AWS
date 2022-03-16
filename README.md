# Terraform-Terragrunt IaC deployment on AWS

* `Sydney`: folder contains the terragrunt.hcl file for resources will create in Sydney(ap-southeast-2) region
* `Tokyo`: folder contains the terragrunt.hcl file for resources will create in Tokyo(ap-northeast-1) region
* `modules`: folder contains the terraform modules for aws resourses provisioning

## Requirments

### Build with Terraform & Terragrunt:

```
Scenario:

Company Alpha is a global company that has two regional offices - Sydney and Tokyo. 
The CTO of the company would like to migrate their on-premises application to AWS Cloud. 
He would like to have an ALB and an Auto Scaling Group Empty LAMP Server. 
He wants to also have a customized VPC instead of the default one. 

```

## Architechture
<a href="https://ibb.co/yYn2bGJ"><img src="https://i.ibb.co/D8DdSsn/Screenshot-2022-02-18-at-10-24-38-AM.png" alt="Screenshot-2022-02-18-at-10-24-38-AM" border="0"></a>
