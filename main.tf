
terraform {
  required_version = ">= 0.9.3"
}

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "us-west-2"
}

resource "aws_instance" "nginx_instance" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.nginx-sg.id}"]
    key_name = "kevin-sedemos-or"
    user_data = "${data.template_file.user_data.rendered}"

    tags = {
        Name = "kevin-temp-cc"
    }
}

resource "aws_security_group" "nginx-sg" {
    name = "nginx-sg"
    description = "nginx security group"
    vpc_id = "${data.aws_vpc.currentvpc.id}"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
