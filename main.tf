// uncomment this if bucket is created
# terraform {
#   backend "gcs" {
#     bucket = "tfstate-perseptron"
#     prefix = "Project1/state"
#   }
# }

//we need to create this bucket beforehand to keep terraform state file in it
module "storage" {
  source = "./modules/storage"
  backend_bucket_name = var.backend_bucket_name
}

//configuring network, nat, firewall
module "network" {
    source = "./modules/network"
    vpc_name = var.vpc_network_name
    vpc_subnet_name = var.vpc_subnet_name
    vpc_subnet_CIDR = var.vpc_subnet_CIDR
}

//creaing service acc 
module "iam" {
  source = "./modules/iam"
  sa_id = var.service_account_id
}

//we need this only for example
module "db" {
  source = "./modules/db"
}

//creating MIG
module "app-runtime-env" {
  source = "./modules/app-runtime-env"

  // Don't I have to pass a link on that resource instead of name? 
  // But it works...
  vpc_network_name = var.vpc_network_name
  vpc_subnet_name = var.vpc_subnet_name 

  // Here I pass an object from output.tf of iam module
  template_sa = module.iam.service_account_name
}