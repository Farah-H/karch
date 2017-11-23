variable "aws-region" {
  description = "The AWS region in which to deploy your cluster & VPC."
  type        = "string"
}

# Networking & Security
variable "vpc-id" {
  description = "ID of existing VPC which should be used for a cluster"
  type        = "string"
}

variable "vpc-cidr-block" {
  description = "CIDR block of existing VPC which should be used for a cluster"
  type        = "string"
}

variable "availability-zones" {
  type        = "list"
  description = "Availability zones to span (for HA master deployments, see master-availability-zones)"
}

variable "kops-topology" {
  type        = "string"
  description = "Kops topolopy (public|private), (default: private)"
  default     = "private"
}

variable "trusted-cidrs" {
  type        = "list"
  description = "CIDR whitelist for Kubernetes master HTTPs & bastion SSH access (default: 0.0.0.0/0)"

  default = ["0.0.0.0/0"]
}

variable "admin-ssh-public-key-path" {
  type        = "string"
  description = "Path to the cluster admin's public SSH key (default: ~/.ssh/id_rsa.pub)"

  default = "~/.ssh/id_rsa.pub"
}

## DNS
variable "main-zone-id" {
  description = "Route53 main zone ID"
  type        = "string"
}

variable "cluster-name" {
  description = "Cluster domain name (i.e. mycluster.example.com)"
  type        = "string"
}

variable "kube-dns-domain" {
  type        = "string"
  description = "Domain enforced in our cluster by kube-dns (default: cluster.local)."

  default = "cluster.local"
}

# Kops & Kubernetes
variable "kops-state-bucket" {
  type        = "string"
  description = "Name of the bucket in which kops stores its state (must be created prior to cluster turnup)"
}

variable "disable-sg-ingress" {
  type        = "string"
  description = "Boolean that indicates wether or not to create and attach a security group to instance nodes and load balancers for each LoadBalancer service (default: false)"

  default = "false"
}

variable "rbac" {
  type        = "string"
  description = "Boolean indicating whether to enable RBAC authorization (default: false)"

  default = "false"
}

variable "rbac-super-user" {
  type        = "string"
  description = "Name of the RBAC super user"

  default = "admin"
}

variable "apiserver-runtime-flags" {
  type        = "map"
  description = "Map describing the --runtime-config parameter passed to the API server, useful to enable certain alphav2 APIs that aren't integrated in the API server by default, such a batch/v1alpha2 that introduces CronJobs (default: {}). Note: the RBAC flag is automatically set if you enabled RBAC with the 'rbac' variable above"

  default = {}
}

variable "oidc-issuer-url" {
  type        = "string"
  description = "Setting this to an OIDC Issuer URL will enable OpenID auth with the configured provider"

  default = ""
}

variable "oidc-ca-file" {
  type        = "string"
  description = "If using OpendID Connect, the oidc CA file on the APIServer pod"

  default = "/srv/kubernetes/ca.crt"
}

variable "oidc-client-id" {
  type        = "string"
  description = "If using OpendID Connect, the oidc client ID"

  default = "example-app"
}

variable "oidc-username-claim" {
  type        = "string"
  description = "If using OpendID Connect, the oidc username claim"

  default = "email"
}

variable "oidc-groups-claim" {
  type        = "string"
  description = "If using OpendID Connect, the oidc group claim"

  default = "groups"
}

variable "channel" {
  type        = "string"
  description = "Channel to use for our Kops cluster (default stable)"
  default     = "stable"
}

variable "kubernetes-version" {
  type        = "string"
  description = "Kubernetes version to use for Core components (default: v1.7.4)"
  default     = "v1.7.4"
}

variable "cloud-labels" {
  type        = "map"
  description = "(Flat) map of kops cloud labels to apply to all resource in cluster"

  default = {}
}

# Resource reservation on our nodes for Kubernetes daemons & the OS
variable "kubelet-eviction-flag" {
  type        = "string"
  description = "Kubelet flag that configure node memory/storage pod eviction threshold"

  default = "memory.available<100Mi,nodefs.available<10%,nodefs.inodesFree<5%,imagefs.available<10%,imagefs.inodesFree<5%"
}

variable "kube-reserved-cpu" {
  type        = "string"
  description = "Amount of CPU reserved for the container runtime & kubelet (default: 50m)"

  default = "50m"
}

variable "kube-reserved-memory" {
  type        = "string"
  description = "Amount of CPU reserved for the container runtime & kubelet (default: 256Mi)"

  default = "256Mi"
}

variable "system-reserved-cpu" {
  type        = "string"
  description = "Amount of CPU reserved for the operating system (default: 50m)"

  default = "50m"
}

variable "system-reserved-memory" {
  type        = "string"
  description = "Amount of CPU reserved for the operating system (default: 100Mi)"

  default = "256Mi"
}

# Master instance group(s)
variable "master-availability-zones" {
  type        = "list"
  description = "Availability zones in which to create master instance groups"
}

variable "master-lb-visibility" {
  type        = "string"
  description = "Visibility (Public|Private) for our Kubernetes masters' ELB (default: Public)"

  default = "Public"
}

variable "master-lb-idle-timeout" {
  type        = "string"
  description = "Idle timeout for Kubernetes masters' ELB (default: 300s), in seconds"
  default     = 300
}

variable "master-image" {
  type        = "string"
  description = "AMI id to use for the master nodes"
}

variable "master-machine-type" {
  type        = "string"
  description = "EC2 instance type to run our masters onto (default: m3.medium)"

  default = "m3.medium"
}

variable "master-volume-size" {
  type        = "string"
  description = "Size of our master's root volume, in GB (default: 10)"

  default = "10"
}

variable "master-volume-provisioned-iops" {
  type        = "string"
  description = "Master volume provisioned IOPS, if applicable"

  default = ""
}

variable "master-volume-type" {
  type        = "string"
  description = "Master volume type (io1/gp2), defaults to gp2"

  default = "gp2"
}

variable "master-ebs-optimized" {
  type        = "string"
  description = "Boolean (true or false) indicating whether our masters should be EBS optimized"
  default     = "false"
}

variable "master-update-interval" {
  type        = "string"
  description = "Interval (in minutes) between rolling updates of master nodes (default: 8)"

  default = "8"
}

variable "master-cloud-labels" {
  type        = "map"
  description = "(Flat) map of EC2 tags to add to master instances"

  default = {}
}

variable "master-node-labels" {
  type        = "map"
  description = "(Flat) map of Kubernetes node labels to add to master instances"

  default = {}
}

# Bastion instance group
variable "bastion-image" {
  type        = "string"
  description = "AMI id to use for the bastion nodes (in private topology only)"
}

variable "bastion-additional-sgs" {
  type        = "list"
  description = "Number of security groups to add to our bastion nodes"

  default = []
}

variable "bastion-additional-sgs-count" {
  type        = "string"
  description = "Number of security groups to add to our bastion nodes"

  default = 0
}

variable "bastion-machine-type" {
  type        = "string"
  description = "EC2 instance type to run our bastions onto (default: t2.micro)"

  default = "t2.micro"
}

variable "bastion-volume-size" {
  type        = "string"
  description = "Size of our bastion's root volume, in GB (default: 10)"

  default = "10"
}

variable "bastion-volume-provisioned-iops" {
  type        = "string"
  description = "Bastion volume provisioned IOPS, if applicable"

  default = ""
}

variable "bastion-volume-type" {
  type        = "string"
  description = "Bastion volume type (io1/gp2), defaults to gp2"

  default = "gp2"
}

variable "bastion-ebs-optimized" {
  type        = "string"
  description = "Boolean (true or false) indicating whether our bastion should be EBS optimized"
  default     = "false"
}

variable "min-bastions" {
  type        = "string"
  description = "Bastion ASG min size (default: 1)"

  default = 1
}

variable "max-bastions" {
  type        = "string"
  description = "Bastion ASG max size (default: 2)"

  default = 2
}

variable "bastion-update-interval" {
  type        = "string"
  description = "Interval (in minutes) between rolling updates of bastion nodes (default: 5)"

  default = "5"
}

variable "bastion-cloud-labels" {
  type        = "map"
  description = "(Flat) map of EC2 tags to add to bastion instances"

  default = {}
}

variable "bastion-node-labels" {
  type        = "map"
  description = "(Flat) map of Kubernetes node labels to add to bastion instances"

  default = {}
}

# Initial minion instance group
variable "minion-ig-name" {
  type        = "string"
  description = "Name to give to the ig created along with the cluster (default: nodes)"

  default = "nodes"
}

variable "minion-ig-public" {
  type        = "string"
  description = "Set to true for nodes in the default minion ig to receive a public IP address"

  default = "false"
}

variable "minion-additional-sgs" {
  type        = "list"
  description = "Additional security groups to add to our minion nodes"

  default = []
}

variable "minion-additional-sgs-count" {
  type        = "string"
  description = "Number of security groups to add to our minion nodes"

  default = 0
}

variable "minion-image" {
  type        = "string"
  description = "AMI id to use for the minion nodes (in private topology only)"
}

variable "minion-machine-type" {
  type        = "string"
  description = "EC2 instance type to run our minions onto (default: t2.medium)"

  default = "t2.medium"
}

variable "minion-volume-size" {
  type        = "string"
  description = "Size of our default minion ig root volume, in GB (default: 30)"

  default = "30"
}

variable "minion-volume-provisioned-iops" {
  type        = "string"
  description = "Minion volume provisioned IOPS, if applicable"

  default = ""
}

variable "minion-volume-type" {
  type        = "string"
  description = "Minion volume type (io1/gp2), defaults to gp2"

  default = "gp2"
}

variable "minion-ebs-optimized" {
  type        = "string"
  description = "Boolean (true or false) indicating whether our default minion ig should be EBS optimized"
  default     = "false"
}

variable "min-minions" {
  type        = "string"
  description = "Minion ASG min size (default: 1)"

  default = 1
}

variable "max-minions" {
  type        = "string"
  description = "Minion ASG max size (default: 3)"

  default = 3
}

variable "minion-taints" {
  type        = "list"
  description = "List of taints (under the form key=value) to add to default minion ig"

  default = []
}

variable "minion-update-interval" {
  type        = "string"
  description = "Interval (in minutes) between rolling updates of minion nodes (default: 8)"

  default = "8"
}

variable "minion-cloud-labels" {
  type        = "map"
  description = "(Flat) map of EC2 tags to add to minion instances"

  default = {}
}

variable "minion-node-labels" {
  type        = "map"
  description = "(Flat) map of Kubernetes node labels to add to minion instances"

  default = {}
}
