storage "mysql" {
  database = "vault"
  table    = "vault"
  username = "root"
  password = "vault"
  address = "mysql:3306"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}

default_lease_ttl = "168h"
max_lease_ttl = "720h"
