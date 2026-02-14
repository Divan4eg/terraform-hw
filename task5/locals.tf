locals {
    env = "develop"
    project = "platform"

    instance_names = {
        web = "netology-${local.env}-${local.project}-web"
        db = "netology-${local.env}-${local.project}-db"
    }
}