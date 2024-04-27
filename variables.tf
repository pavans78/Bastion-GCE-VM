variable "main" {
  type = object({
    project = string
    region  = string
    zone    = string
  })
}


# Defaults will be used for these, if not overridden at runtime.

variable "bastion_machine_type" {
  description = "The instance size to use for your bastion instance."
  type        = string
  default     =  "e2-standard-1"
}

variable "bastion_name" {
  type    = string
  default = "bastion"
}

variable "cluster_name" {
  description = "The name to give the new Kubernetes cluster."
  type        = string
  default     = "gke-cluster"
}

variable "initial_node_count" {
  description = "The number of nodes initially provisioned in the cluster"
  type        = string
  default     = "3"
}

variable "ip_range" {
  description = "The CIDR from which to allocate cluster node IPs"
  type        = string
  default     = "10.0.96.0/22"
}

variable "master_cidr_block" {
  description = "The CIDR from which to allocate master IPs"
  type        = string
  default     = "10.0.90.0/28"
}

variable "node_machine_type" {
  description = "The instance to use for your node instances"
  type        = string
  default     = "n1-standard-1"
}

variable "node_tags" {
  description = "A list of tags applied to your node instances."
  type        = list(string)
  default     = ["poc"]
}

variable "secondary_ip_range" {
  description = "The CIDR from which to allocate pod IPs for IP Aliasing."
  type        = string
  default     = "10.0.92.0/22"
}

variable "secondary_subnet_name" {
  description = "The name to give the secondary subnet."
  type        = string
  default     = "network-secondary-sub"
}

variable "subnet_name" {
  description = "The name to give the primary subnet"
  type        = string
  default     = "network-subnet"
}

variable "vpc_name" {
  description = "The name to give the virtual network"
  type        = string
  default     = "network"
}

variable "ssh_user_bastion" {
  description = "ssh user for bastion server"
  type        = string
  default     = "admin"
}

