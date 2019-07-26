
resource "aws_route_table" "demo-route-table-public" {
  vpc_id = "${aws_vpc.demo-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demo-internet-gateway.id}"
  }

  tags = "${merge(var.common_tags, map(
    "Name", "terraform-demo-eks-route-table-public",
    "kubernetes.io/cluster/${var.cluster-name}", "owned",
  ))}"
}

resource "aws_route_table_association" "demo-route-table-association-public" {
  count          = 2
  subnet_id      = "${element(aws_subnet.demo-subnet-public.*.id, count.index)}"
  route_table_id = "${aws_route_table.demo-route-table-public.id}"
}

resource "aws_route_table" "demo-route-table-private" {
  count  = 2
  vpc_id = "${aws_vpc.demo-vpc.id}"

  tags = "${merge(var.common_tags, map(
    "Name", "terraform-demo-eks-route-table-private-${count.index}",
    "kubernetes.io/cluster/${var.cluster-name}", "owned",
  ))}"
}

resource "aws_route_table_association" "demo-route-table-association-private" {
  count          = 2
  subnet_id      = "${element(aws_subnet.demo-subnet-private.*.id, count.index)}"
  route_table_id = "${aws_route_table.demo-route-table-private.*.id[count.index]}"
}

resource "aws_route" "demo-route-private" {
  count                  = 2
  route_table_id         = "${aws_route_table.demo-route-table-private.*.id[count.index]}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.demo-nat-gateway.*.id[count.index]}"
  depends_on             = ["aws_route_table.demo-route-table-private"]
}