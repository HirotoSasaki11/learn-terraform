variable "project_id" {
  type        = string
  description = "The project ID to host the GAE services in"
}


variable "sinks" {
  description = "The list of the push subscriptions"
  type = map(object({
    name = string
    destination = string
    filter = string
    unique_writer_identity = bool
  }))
  default = {}
}
variable "datasets" {
  description = "The list of the push subscriptions"
  type = map(object({
    dataset_id = string
  }))
  default = {}
}

# variable "module_depends_on" {
#   description = "List of modules or resources this module depends on."
#   type        = list(any)
#   default     = []
# }

