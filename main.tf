provider "google" {
  credentials = "${file("${var.credential.data}")}"
  project     = "${var.project_id.tf_sample}" // workplace機能については使ってみたい
  region      = "asia-northeast1"
}

resource "google_cloud_run_service" "default" {
  name     = "cloudrun-srv"
  location = "asia-northeast1"
  project  = var.project_id.tf_sample

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }
}

data "google_iam_policy" "asia_noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers"
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "asia_noauth" {
  location  = google_cloud_run_service.default.location
  project   = google_cloud_run_service.default.project
  service   = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.asia_noauth.policy_data
}