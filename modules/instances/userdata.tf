provider "template"{

}

data "template_file" "jenkinsserver-userdata" {
  template = "${file("${path.module}/userdata.tpl")}"
  vars = {
   vm_role = "cicd"
  }
}
data "template_file" "artifactoryserver-userdata" {
  template = "${file("${path.module}/userdata.tpl")}"
  vars = {
   vm_role = "binary"
  }
}
