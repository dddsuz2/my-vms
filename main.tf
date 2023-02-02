terraform {
		  required_version = ">= 0.15"
		  required_providers {
		      proxmox = {
			      source = "telmate/proxmox"
			  }
		  }
}

provider "proxmox" {
		 pm_user = var.user
		 pm_password = var.password
		 pm_api_url = var.api_url
		 pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "Ubuntsu" {
		 name = "suzuki-ubuntu-test"
		 target_node = "hx90"
		 clone = "ubuntu-20-04-cloudinit"
		 memory = 2048
		 vmid = 55555
		 os_type = "cloud-init"

		 disk {
		 	  type = "scsi"
			  storage = "local-lvm"
			  size = "10G"
		}

		network {
				model = "virtio"
				bridge = "vmbr0"
		}

		lifecycle {
				  ignore_changes = [
				      network
				  ]
			}

		ipconfig0 = "ip=192.168.3.128/24, gw=192.168.3.1"
}

