variable location {
    description = "Azure Region"
    type = string
}

variable location_short {
    description = "Azure Region Short Name"
    type        = string
}

variable enviroment {
    description = "Azure Enviroment"
    type        = string
}

variable az_bastion {
    type = string
}

variable resource_groups{
    type = map(object({
        workload = string
        role     = string
    }))
}

