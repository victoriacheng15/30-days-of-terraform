run "plan_defaults" {
  command = plan

  assert {
    condition     = output.resource_group_name == var.resource_group_name
    error_message = "Resource group output should match the configured input name."
  }

  assert {
    condition     = output.security_settings.min_tls_version == "TLS1_2"
    error_message = "Storage account minimum TLS version must be TLS1_2."
  }

  assert {
    condition     = output.security_settings.https_traffic_only_enabled
    error_message = "Storage account must enforce HTTPS-only traffic."
  }

  assert {
    condition     = output.security_settings.allow_nested_items_to_be_public == false
    error_message = "Nested blob items should not allow public access."
  }

  assert {
    condition     = output.security_settings.logs_container_access_type == "private"
    error_message = "Logs container must be private."
  }
}

run "plan_with_prod_environment" {
  command = plan

  variables {
    resource_group_name = "rg-day26-testing-prod"
    environment         = "prod"
  }

  assert {
    condition     = output.resource_group_name == "rg-day26-testing-prod"
    error_message = "Resource group name override should be reflected in outputs."
  }

  assert {
    condition     = azurerm_resource_group.main.tags["environment"] == "prod"
    error_message = "Environment tag should be set to prod when overridden in test variables."
  }
}
