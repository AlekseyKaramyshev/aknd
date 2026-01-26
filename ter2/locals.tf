locals {
    name = {
        platform    = "${var.env}-${var.name}",
        platform1   = "${var.env}-${var.vm_db_name}"
    }
}
