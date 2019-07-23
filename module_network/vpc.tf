data "aws_availability_zones" "available" {}

resource "aws_vpc" "demo-vpc" {
  cidr_block = "172.16.0.0/16"
  enable_dns_hostnames = true

  tags = "${
    map(
     "Name", "terraform-demo-eks-vpc",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
     "Project", "${local.Project}",
     "Owner", "${local.Owner}",
     "Environment", "${local.Environment}",
     "BusinessUnit", "${local.BusinessUnit}"
    )
  }"
}

resource "aws_subnet" "demo-subnet-public" {
  count             = 2
  vpc_id            = "${aws_vpc.demo-vpc.id}"
  cidr_block        = "172.16.${count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags = "${
    map(
     "Name", "terraform-demo-eks-subnet-public-${count.index}",
     "kubernetes.io/role/elb", "${count.index}",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
     "Project", "${local.Project}",
     "Owner", "${local.Owner}",
     "Environment", "${local.Environment}",
     "BusinessUnit", "${local.BusinessUnit}"
    )
  }"
}

resource "aws_subnet" "demo-subnet-private" {
  count             = 2
  vpc_id            = "${aws_vpc.demo-vpc.id}"
  cidr_block        = "172.16.${count.index+2}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags = "${
    map(
     "Name", "terraform-demo-eks-subnet-private-${count.index}",
     "kubernetes.io/role/internal-elb", "${count.index}",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
     "Project", "${local.Project}",
     "Owner", "${local.Owner}",
     "Environment", "${local.Environment}",
     "BusinessUnit", "${local.BusinessUnit}"
    )
  }"
}

resource "aws_internet_gateway" "demo-internet-gateway" {
  vpc_id = "${aws_vpc.demo-vpc.id}"

  tags = {
    Name = "terraform-demo-eks-internet-gateway"
    Project = "${local.Project}"
    Owner = "${local.Owner}"
    Environment = "${local.Environment}"
    BusinessUnit = "${local.BusinessUnit}"
  }
}

resource "aws_eip" "demo-epi" {
  count = 2
  vpc   = true
  tags = {
    Name = "terraform-demo-eks-epi"
    Project = "${local.Project}"
    Owner = "${local.Owner}"
    Environment = "${local.Environment}"
    BusinessUnit = "${local.BusinessUnit}"
  }
}

resource "aws_nat_gateway" "demo-nat-gateway" {
  count = 2
  allocation_id = "${aws_eip.demo-epi.*.id[count.index]}"
  subnet_id     = "${aws_subnet.demo-subnet-public.*.id[count.index]}"
  depends_on    = ["aws_internet_gateway.demo-internet-gateway"]

  tags = {
    Name = "terraform-demo-eks-nat-gateway-${count.index}"
    Project = "${local.Project}"
    Owner = "${local.Owner}"
    Environment = "${local.Environment}"
    BusinessUnit = "${local.BusinessUnit}"
  }
}

# resource "aws_vpn_gateway" "demo-vpn-gateway" {
#   vpc_id = "${aws_vpc.demo-vpc.id}"

#   tags = {
#     Name = "terraform-demo-eks-vpn-gateway"
#   }
# }