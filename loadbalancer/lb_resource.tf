#Creation of public IP for load balancer
resource "azurerm_public_ip" "web_lb_publicip" {
  name = "${local.prefex}-lbpublicip"
  resource_group_name = azurerm_resource_group.rg_name.name
  location = azurerm_resource_group.rg_name.location
  sku = "Standard"
  allocation_method = "Static"

  tags = local.common_tags
}

#Create load bakancer resource
resource "azurerm_lb" "web_lb" {
  name = "${local.prefex}-web-load-balancer"
  resource_group_name = azurerm_resource_group.rg_name.name
  location = azurerm_resource_group.rg_name.location
  sku = "Standard"
  frontend_ip_configuration {
    name = "frontendip"
    public_ip_address_id = azurerm_public_ip.web_lb_publicip.id
  }
}
#Load balancer backend pool
resource "azurerm_lb_backend_address_pool" "web_lb_backendpool" {
  name = "web-lb-backendpool"
  loadbalancer_id = azurerm_lb.web_lb.id
}
#Load balancer probe
resource "azurerm_lb_probe" "web_lb_probe" {
  name = "web-lb-probe"
  loadbalancer_id = azurerm_lb.web_lb.id
  port = 80
  protocol = "Tcp"
}
#load balancer rule
resource "azurerm_lb_rule" "web_lb_rule" {
  loadbalancer_id                = azurerm_lb.web_lb.id
  name                           = "web-lb-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
  probe_id = azurerm_lb_probe.web_lb_probe.id
  backend_address_pool_ids = [ azurerm_lb_backend_address_pool.web_lb_backendpool.id ]
  
}
#Associalate network interface and load balancer
resource "azurerm_network_interface_backend_address_pool_association" "web_lb_backendpool_asso" {
  network_interface_id = azurerm_network_interface.web_linuxvn_ni.id
  ip_configuration_name = azurerm_network_interface.web_linuxvn_ni.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_lb_backendpool.id
}