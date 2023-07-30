# documentation "resource group"

resource "azurerm_resource_group" "main" {
  name     = "glebops"
  location = "Switzerland North"

  tags = var.common_tags
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "glebops-cluster"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "glebops"

  default_node_pool {
    name       = "main"
    node_count = 2
    vm_size    = "standard_D2s_v3"
    os_disk_size_gb = 32
    os_sku = "AzureLinux"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.common_tags
}