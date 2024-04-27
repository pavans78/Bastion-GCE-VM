# Bastion-GCE-VM

This repo contains how to create the compute instance, gke cluster, firewall rules and vpc network using the terraform.

The steps below will provision a private Kubernetes Engine cluster and a bastion host with which to access it. A bastion host provides a single host that has access to the cluster, which, when combined with a private kubernetes network ensures that the cluster isn't exposed to malicious behavior from the internet at large. Bastions are particularly useful when you do not have VPN access to the cloud network.

## Try it out

Before initialize the terraform, we have to enable the following Google Cloud Service APIs in the project:

* `compute.googleapis.com`
* `container.googleapis.com`
* `cloudbuild.googleapis.com`

1. Initialize your new Terraform configuration by running the terraform init command in the same directory as your main.tf file:

    ```sh
    terraform init
    ```
1. See the execution plan by running the terraform plan command with var-file, var-file is the inputs of the variables:

    ```sh
    terraform plan -var-file=_var.tfvars 
    ```
    The output has a + next to resources blocks , meaning that Terraform will create these resources. Beneath that, it shows the attributes that will be set. When the value displayed is (known after 
    apply), it means that the value won't be known until the resource is created.

    If anything in the plan seems incorrect, it is shows the error messages.

1. Apply you configuration now by running the command terraform apply:

    ```sh
    terraform apply plans.tfplan
    ```

1. Clean up after you’re done:

    ```sh
    terraform destroy -var-file=var.tfvars 
    ```

----
