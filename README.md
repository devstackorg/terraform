$git clone https://github.com/devstackorg/terraform.git

$cd terraform

$vi config.json

"mykeypair" : ""

myamiid : ""

$terraform init .

$terraform validate -var-file=config.json

$terraform apply -var-file=config.json
