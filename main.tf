locals {
  students = {
    "alice" = { id = 1101, ip = "192.168.10.101/24" }
    "bob"   = { id = 1102, ip = "192.168.10.102/24" }
    # ...
  }
}

resource "proxmox_virtual_environment_container" "labs" {
  for_each = local.students

  node_name = var.target_node

  description = "Managed by Terraform via Semaphore"
  
 clone {
    vm_id = 104
  }

  agent {
    # NOTE: The agent is installed and enabled as part of the cloud-init configuration in the template VM, see cloud-config.tf
    # The working agent is *required* to retrieve the VM IP addresses.
    # If you are using a different cloud-init configuration, or a different clone source
    # that does not have the qemu-guest-agent installed, you may need to disable the `agent` below and remove the `vm_ipv4_address` output.
    # See https://bpg.sh/docs/resources/virtual_environment_vm#qemu-guest-agent for more details.
    enabled = true
  }

  memory {
    dedicated = var.memory
  }

 # Other useful settings
  unprivileged = true
  started      = true

  tags = ["terraform", "lxc", "debian"]

  # Initialization (Cloud-Init style for LXC)
  initialization {

    hostname = "lab-${each.key}"

    ip_config {
      ipv4 {
        address = "${each.value.ip}"
        gateway = var.gateway
      }
    }

    dns {
      servers = ["8.8.8.8", "1.1.1.1"]
    }
  }
}
