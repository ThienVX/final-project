resource "helm_release" "postgresql" {
  name       = "my-postgresql"
  chart      = "bitnami/postgresql"
  namespace  = "db" # Replace with your desired namespace
  repository = "https://charts.bitnami.com/bitnami"

  values = [
    <<EOT
    primary:
      persistence:
        size: 10Gi
    global:
      postgresql:
        postgresqlDatabase: testdb
        postgresqlUsername: testuser
        postgresqlPassword: testpass
    EOT
  ]
}
