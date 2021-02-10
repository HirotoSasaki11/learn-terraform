resource "google_bigquery_dataset" "log_export_dataset" {
  project = var.project_id
  for_each = var.datasets
  dataset_id                  = each.value.dataset_id
  location                    = "asia-east1"
}

resource "google_logging_project_sink" "instances-sink" {
  project = var.project_id
  for_each = var.sinks
  name = each.value.name
  filter = each.value.filter
  destination = each.value.destination
  unique_writer_identity = each.value.unique_writer_identity
  bigquery_options {
      use_partitioned_tables = false
  }
}


resource "google_project_iam_binding" "log-writer" {
  for_each = var.sinks
  role = "roles/bigquery.dataEditor"
  project = var.project_id
  members = [
    google_logging_project_sink.instances-sink["${each.key}"].writer_identity
  ]
}
resource "google_project_iam_binding" "log-config-writer" {
  for_each = var.sinks
  role = "roles/logging.configWriter"
  project = var.project_id
  members = [
    google_logging_project_sink.instances-sink["${each.key}"].writer_identity
  ]
}
