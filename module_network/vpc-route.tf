
resource "aws_route_table" "demo-route-table-public" {
  vpc_id = "${aws_vpc.demo-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demo-internet-gateway.id}"
  }

  tags {
    Name = "terraform-demo-eks-route-table-public"
    owned = "kubernetes.io/cluster/${var.cluster-name}"
    Project = "${local.Project}"
    Owner = "${local.Owner}"
    Environment = "${local.Environment}"
    BusinessUnit = "${local.BusinessUnit}"
  }
}

resource "aws_route_table_association" "demo-route-table-association-public" {
  count          = 2
  subnet_id      = "${element(aws_subnet.demo-subnet-public.*.id, count.index)}"
  route_table_id = "${aws_route_table.demo-route-table-public.id}"
}

resource "aws_route_table" "demo-route-table-private" {
  count  = 2
  vpc_id = "${aws_vpc.demo-vpc.id}"

  tags {
    Name = "terraform-demo-eks-route-table-private-${count.index}"
    owned = "kubernetes.io/cluster/${var.cluster-name}"
    Project = "${local.Project}"
    Owner = "${local.Owner}"
    Environment = "${local.Environment}"
    BusinessUnit = "${local.BusinessUnit}"
  }
}

resource "aws_route_table_association" "demo-route-table-association-private" {
  count          = 2
  subnet_id      = "${element(aws_subnet.demo-subnet-private.*.id, count.index)}"
  route_table_id = "${aws_route_table.demo-route-table-private.*.id[count.index]}"
  # route_table_id = "${aws_route_table.demo-route-table-public.id}"
}

resource "aws_route" "demo-route-private" {
  count                  = 2
  route_table_id         = "${aws_route_table.demo-route-table-private.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.demo-nat-gateway.*.id[count.index]}"
  depends_on             = ["aws_route_table.demo-route-table-private"]
}

# resource "aws_route" "privdmz_routes" {
#   count                  = 2
#   route_table_id         = "${aws_route_table.privdmz.*.id[count.index]}"
#   destination_cidr_block = "10.33.0.0/16"
#   gateway_id             = "${aws_vpn_gateway.demo.id}"
#   depends_on             = ["aws_route_table.privdmz"]
# }