variable "credentials" {
  description = "GCP Credentials"
  default     = "../application_default_credentials.json"
}


variable "project" {
  description = "Project"
  default     = "axial-gist-411121"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default     = "us-west1"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default     = "US"
}

variable "bq_dataset_name" {
  description = "BigQuery Dataset Name"
  #Update the below to what you want your dataset to be called
  default     = "project_dataset"
}

variable "gcs_bucket_name" {
  description = "Storage Bucket Name"
  #Update the below to a unique bucket name
  default     = "de-zoomcamp-2025-project"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}
