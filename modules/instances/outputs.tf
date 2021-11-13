output "webserver_publicip" {
value = "${aws_instance.webserver.public_ip}"
}
#output "appserver_publicip" {
#value = "${aws_instance.appserver.public_ip}"
#}
#output "dbserver_publicip" {
#value = "${aws_instance.dbserver.public_ip}"
#}
