output "vpc_id" {
  value = "${aws_vpc.demo-vpc.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.demo-vpc.cidr_block}"
}

output "web_subnet_ids" {
  value = "${aws_subnet.demo-subnet-private.*.id}"
}

output "web_subnet_cidr_blocks" {
  value = "${aws_subnet.demo-subnet-private.*.cidr_block}"
}

output "public_subnet_ids" {
  value = "${aws_subnet.demo-subnet-public.*.id}"
}

output "public_subnet_cidr_blocks" {
  value = "${aws_subnet.demo-subnet-public.*.cidr_block}"
}

output "nat_gateway_ids" {
  value = "${aws_nat_gateway.demo-nat-gateway.*.id}"
}
