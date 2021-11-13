#########################################  Importing  modules #################################
module "instances"{
source = "./modules/instances"
#myregion = "${var.myregion}"
#myaccesskey = "${var.myaccesskey}"
#mysecretkey = "${var.mysecretkey}"
myamiid = "${var.myamiid}"
}

provider "aws"{
region = "${var.myregion}"
shared_credentials_file = "/home/centos/.aws/credentials"
#profile                 = "customprofile"
#access_key = "${var.myaccesskey}"
#secret_key = "${var.mysecretkey}"
}

