terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_weather" {
  name = "tfmainrg"
  location = "Brazil South"
}

resource "azurerm_container_group" "tfcg_weather" {
  name                  = "weatherapi"
  location              = azurerm_resource_group.tf_weather.location
  resource_group_name   = azurerm_resource_group.tf_weather.name

  ip_address_type = "public"
  dns_name_label = "weatherapitfdns"
  os_type = "Linux"

  container {
    name = "wheaterapi"
    image = "evol1/weatherapi"
    cpu = "1"
    memory = "1"
    ports {      
      port = 5000
      protocol = "TCP"
    }
  }
}