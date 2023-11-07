#load balancer nat rules 
resource "azurerm_lb_nat_rule" "nat_rule" {
  depends_on = [ azurerm_linux_virtual_machine.linuxvm_vm ]
  count = var.vm_count
  name = "vm-${count.index}-ssh-${var.nic_inbound_ports[count.index]}-vm-22"
  protocol = "Tcp"
  frontend_port = element(var.nic_inbound_ports, count.index)
  backend_port = 22
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  resource_group_name = azurerm_resource_group.rg_name.name
  loadbalancer_id = azurerm_lb.web_lb.id
}

#associate lb nat rule with VM ni
resource "azurerm_network_interface_nat_rule_association" "lb_nat_rule_associa" {
  count = var.vm_count
  network_interface_id = element(azurerm_network_interface.web_linuxvn_ni[*].id, count.index)
  ip_configuration_name = element(azurerm_network_interface.web_linuxvn_ni[*].ip_configuration[0].name, count.index)
  nat_rule_id = element(azurerm_lb_nat_rule.nat_rule[*].id, count.index)
}