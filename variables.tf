variable "proxmox_endpoint" {
  type = string
}

variable "proxmox_username" {
  type = string
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "target_node" {
  type    = string
  default = "pve"
}

variable "vm_id" {
  type    = number
  default = 1000
}

variable "hostname" {
  type = string
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 2048
}

variable "disk_size" {
  type    = string
  default = "32"
}

variable "ip_address" {
  type = string
}

variable "gateway" {
  type    = string
  default = "192.168.10.1"
}
