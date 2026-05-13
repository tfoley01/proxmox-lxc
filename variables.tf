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

variable "student_password" {
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
  default = 1
}

variable "memory" {
  type    = number
  default = 512
}

variable "disk_size" {
  type    = string
  default = "8"
}

variable "ip_address" {
  type = string
}

variable "gateway" {
  type    = string
  default = "10.78.0.1"
}
