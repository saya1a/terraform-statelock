provider aws {
  region = "us-east-1"

}

# created workspace and reffered the local varible via workspace
locals {

  instance_name = "${terraform.workspace}-instance"     
}

resource "aws_instance" "ec2-example" {

  ami = "ami-0b5eea76982371e91"

  instance_type = var.instance_type


  tags = {
    Name = local.instance_name
  }

}

terraform {
  backend "s3" {
    bucket = "sat-remote-test-env-bkt"
    key = "root/module/terraform.tfstate"
    encrypt = true
    region = "us-east-1"
    dynamodb_table = "dynamodb-state.locking"
  }
}
