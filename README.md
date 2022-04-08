[![Typing SVG](https://readme-typing-svg.herokuapp.com?color=F76C00&lines=AWS+VPC+Deployment+with+Terraform)](https://git.io/typing-svg)

This repository provides AWS VPC service deployment with Terraform.

![](src/terraform.png) ![](src/aws.png)

### Parts of this repository ###
* [Main.tf](https://github.com/elif-apaydin/terraform-aws-vpc/tree/main/main.tf)
* [Bitbucket Pipeline](https://github.com/elif-apaydin/terraform-aws-vpc/tree/main/bitbucket-pipelines.yml)

This configuration will deploy VPC with 2 public subnet. Change these variables for deployment.


```
app_tags            = "value" (APP_TAGS value for the VPC)

region              = "value" (us-east-1 or eu-central-1)

vpc_cidr            = "value" (VPC CIDR Block. It has to be with subnet block. e.g. 10.10.10.0/24)

subnet1             = "value" (CIDR Block for the public subnet one. It has to be with subnet block. e.g. 10.10.10.1/25 )

subnet2             = "value" (CIDR Block for the public subnet two. It has to be with subnet block. e.g. 10.10.10.2/25 )
```