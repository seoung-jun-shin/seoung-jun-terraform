data "nutanix_subnet" "subnet" {
  subnet_name = var.nutanix_network
}

data "nutanix_cluster" "cluster" {
  name = var.nutanix_cluster
}

data "nutanix_image" "image" {
  image_name = var.nutanix_image
}

resource "nutanix_virtual_machine" "machine" {
  count = var.vm_count 
  name = "${var.vm_name_pfx}-${count.index}"
  cluster_uuid = data.nutanix_cluster.cluster.id

  num_vcpus_per_socket = 4
  num_sockets          = 2
  memory_size_mib      = 2048


  nic_list {
    subnet_uuid = data.nutanix_subnet.subnet.id
  }

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.image.id
    }

    disk_size_mib = 30720

    device_properties {
      device_type = "DISK"

      disk_address = {
        adapter_type = "SATA"
        device_index = 0
      }
    }
 
  }
}