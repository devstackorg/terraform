################################################  Jenkins server ####
resource "aws_instance" "jenkins" {
ami = "${var.myamiid}"
instance_type = "t2.medium"
subnet_id = "${aws_subnet.publicsubnet.id}"
private_ip = "172.31.1.5"
vpc_security_group_ids = ["${aws_security_group.websg.id}"]
key_name = "${var.mykeypair}"
user_data = "${data.template_file.jenkinsserver-userdata.rendered}"
tags = {
Name = "jenkins"
}
}

################################################  Artifactory server ################
resource "aws_instance" "artifactory" {
ami = "${var.myamiid}"
instance_type = "t2.medium"
subnet_id = "${aws_subnet.publicsubnet.id}"
private_ip = "172.31.1.6"
vpc_security_group_ids = ["${aws_security_group.websg.id}"]
key_name = "${var.mykeypair}"
user_data = "${data.template_file.artifactoryserver-userdata.rendered}"
tags = {
Name = "artifactory"
}
}

############################################ Networking modules ######################
resource "aws_eip" "jenkinseip"{
instance = "${aws_instance.jenkins.id}"
}

resource "aws_eip" "artifactoryeip"{
instance = "${aws_instance.artifactory.id}"
}

resource "aws_vpc" "myvpc"{
cidr_block = "172.31.0.0/16"
tags ={
Name = "myvpc"
}
}

resource "aws_internet_gateway" "myigw"{
vpc_id = "${aws_vpc.myvpc.id}"
tags={
Name = "myigw"
}
}

resource "aws_subnet" "publicsubnet"{
vpc_id = "${aws_vpc.myvpc.id}"
cidr_block = "172.31.1.0/24"
tags={
Name = "publicsubnet"
}
}

resource "aws_route_table" "publicrtb"{
vpc_id = "${aws_vpc.myvpc.id}"
tags = {
Name = "publicrtb"
}
}

resource "aws_route" "publicrt"{
route_table_id = "${aws_route_table.publicrtb.id}"
destination_cidr_block = "0.0.0.0/0"
gateway_id = "${aws_internet_gateway.myigw.id}"
}
 
resource "aws_route_table_association" "publicrtba"{
route_table_id = "${aws_route_table.publicrtb.id}"
subnet_id = "${aws_subnet.publicsubnet.id}"
}

##############################################  Security Modules ########################

resource "aws_security_group" "websg" {
  name        = "websg"
  description = "Allow all traffic"
  vpc_id ="${aws_vpc.myvpc.id}"
  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "websg"
  }
}

