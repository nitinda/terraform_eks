#!/bin/bash
set -o xtrace

yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
yum install -y nfs-utils

AVAILABILITY_ZONE=`curl -sf http://169.254.169.254/latest/meta-data/placement/availability-zone/`
efs_mount_targets_ips=(${EFS_ENDPOINT})

if [ "$${AVAILABILITY_ZONE}" == "eu-central-1a" ]; then
 EFS_ENDPOINT_IP="$${efs_mount_targets_ips[0]}"
elif [ "$${AVAILABILITY_ZONE}" == "eu-central-1b" ]; then
 EFS_ENDPOINT_IP="$${efs_mount_targets_ips[1]}"
fi

mkdir -p /mnt/efs
chmod 777 /mnt /mnt/efs
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $${EFS_ENDPOINT_IP}:/ /mnt/efs

/etc/eks/bootstrap.sh --apiserver-endpoint "${EKS_ENDPOINT}" --b64-cluster-ca "${EKS_CA}" "${EKS_CLUSTER_NAME}" --cloud-provider=aws