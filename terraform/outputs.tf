output "static_web_url" {
  value = azurerm_static_web_app.demo_swa.default_host_name
}