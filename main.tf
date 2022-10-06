resource "ibm_is_instance" "instance1" {
  name    = "instance1"
  image   = var.image
  profile = var.profile
  primary_network_interface {
    subnet = ibm_is_subnet.subnet1.id
  }
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone1
  keys = [data.ibm_is_ssh_key.sshkey1.id]
  user_data = data.template_cloudinit_config.cloud-init-apptier.rendered
  resource_group = data.ibm_resource_group.rg.id
}

resource "ibm_is_instance" "instance2" {
  name    = "instance2"
  image   = var.image
  profile = var.profile
  primary_network_interface {
    subnet = ibm_is_subnet.subnet2.id
  }
  vpc  = ibm_is_vpc.vpc1.id
  zone = var.zone2
  keys = [data.ibm_is_ssh_key.sshkey1.id]
  user_data = data.template_cloudinit_config.cloud-init-apptier.rendered

  resource_group = data.ibm_resource_group.rg.id
}

resource "ibm_is_security_group_rule" "sg1_tcp_rule_22" {
  group     = ibm_is_vpc.vpc1.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = "22"
    port_max = "22"
  }
}

resource "ibm_is_security_group_rule" "sg1_tcp_rule_80" {
  group     = ibm_is_vpc.vpc1.default_security_group
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = "80"
    port_max = "80"
  }
}
