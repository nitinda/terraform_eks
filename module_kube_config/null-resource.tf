resource "null_resource" "demo-null-resource-kubconfig" {
    triggers {
        build_number = "${timestamp()}"
    }
    provisioner "local-exec" {
        command = "export KUBECONFIG=${local_file.demo-local-file-kubconfig.filename} && kubectl get nodes -A"
    }
    depends_on = ["local_file.demo-local-file-kubconfig"]
}

resource "null_resource" "demo-null-resource-config-map-aws-auth" {
    provisioner "local-exec" {
        command = "export KUBECONFIG=${local_file.demo-local-file-kubconfig.filename} && kubectl apply -f ${local_file.demo-local-file-config-map-aws-auth.filename}"
    }
    depends_on = ["local_file.demo-local-file-kubconfig","local_file.demo-local-file-config-map-aws-auth","null_resource.demo-null-resource-kubconfig"]
}

resource "null_resource" "demo-null-resource-eks-admin-service-account" {
    provisioner "local-exec" {
        command = "export KUBECONFIG=${local_file.demo-local-file-kubconfig.filename} && kubectl apply -f ${local_file.demo-local-file-eks-admin-service-account.filename}"
    }
    depends_on = ["local_file.demo-local-file-kubconfig","local_file.demo-local-file-config-map-aws-auth","local_file.demo-local-file-eks-admin-service-account","null_resource.demo-null-resource-kubconfig"]
}



#### Deploy the Kubernetes dashboard to your cluster

resource "null_resource" "demo-null-resource-kubernetes-dashboard" {
    provisioner "local-exec" {
        command = "export KUBECONFIG=${local_file.demo-local-file-kubconfig.filename} && kubectl apply -f ${var.kubernetes_dashboard_url}"
    }
    depends_on = ["local_file.demo-local-file-kubconfig","local_file.demo-local-file-config-map-aws-auth","null_resource.demo-null-resource-kubconfig"]
}