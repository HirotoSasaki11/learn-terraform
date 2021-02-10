module "bigquery-sinks" {
  source     = "./modules"
  project_id = "{PROJECTNAME}"

  sinks ={
    audit-log = {
      name = "audit-log"
      destination = "bigquery.googleapis.com/projects/{PROJECTNAME}/datasets/audit_log"
      filter = "logName:cloudaudit.googleapis.com"
      unique_writer_identity = true
    },
  application-log = {
      name = "application-log"
      destination = "bigquery.googleapis.com/projects/{PROJECTNAME}/datasets/application_log"
      filter = "resource.type=gae_app"
      unique_writer_identity = true
    }
  }
}

module "bq-datasets" {
  source     = "./modules"
  project_id = "{PROJECTNAME}"

  datasets ={
    audit-log = {
      dataset_id = "audit_log"
    },
    application-log = {
      dataset_id = "application_log"   
    },
  }
}

resource "google_data_fusion_instance" "basic_instance" {
  provider = google-beta
  name = "my-instance"
  region = "us-central1"
  type = "BASIC"
}