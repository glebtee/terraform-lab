locals {
  charts_folder     = "charts"
  app_manifest_file = "app.yaml"

  charts = {
    for file in fileset("${local.charts_folder}", "**/${local.app_manifest_file}"):
      trimsuffix("${file}", "/${local.app_manifest_file}") =>
        yamldecode(file("${local.charts_folder}/${file}"))
  }
}

resource "helm_release" "this" {
  for_each = local.charts

  name                       = try(each.value.name)
  chart                      = try(each.value.chart)
  repository                 = try(each.value.repository, null)
  repository_username        = try(each.value.repository_username, null)
  repository_password        = try(each.value.repository_password, null)
  version                    = try(each.value.version)
  namespace                  = try(each.value.namespace, "default")
  timeout                    = try(each.value.timeout, 300)
  disable_webhooks           = try(each.value.disable_webhooks, false)
  reuse_values               = try(each.value.reuse_values, false)
  reset_values               = try(each.value.reset_values, false)
  force_update               = try(each.value.force_update, false)
  recreate_pods              = try(each.value.recreate_pods, false)
  cleanup_on_fail            = try(each.value.cleanup_on_fail, false)
  max_history                = try(each.value.max_history, 0)
  atomic                     = try(each.value.atomic, false)
  skip_crds                  = try(each.value.skip_crds, false)
  render_subchart_notes      = try(each.value.render_subchart_notes, true)
  disable_openapi_validation = try(each.value.disable_openapi_validation, false)
  wait                       = try(each.value.wait, true)
  wait_for_jobs              = try(each.value.wait_for_jobs, false)
  dependency_update          = try(each.value.dependency_update, false)
  replace                    = try(each.value.replace, false)
  lint                       = try(each.value.lint, false)
  create_namespace           = try(each.value.create_namespace, false)

  values = [
    "${file("${local.charts_folder}/${each.key}/values.yaml")}",
  ]
}