#########################################  Importing  modules #################################
module "instances"{
source = "./modules/instances"
myamiid = "${var.myamiid}"
mykeypair = "${var.mykeypair}"
}

