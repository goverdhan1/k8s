# metrics-server.tf

resource "helm_release" "metrics_server" {
  name             = "metrics-server"
  repository       = "https://kubernetes-sigs.github.io/metrics-server/"
  chart            = "metrics-server"
  namespace        = "kube-system"
  create_namespace = true
  version          = "3.8.2"
  force_update     = true
  replace          = true
  cleanup_on_fail  = true
  atomic          = false
  recreate_pods   = true
  wait            = false
  wait_for_jobs   = true

  values = [
    <<-EOT
    apiService:
      create: true
      annotations: {}
      labels:
        app.kubernetes.io/managed-by: "Helm"

    commonLabels:
      app.kubernetes.io/managed-by: "Helm"

    serviceAccount:
      create: true
      annotations: {}
      name: "metrics-server"
      labels:
        app.kubernetes.io/managed-by: "Helm"

    rbac:
      create: true
      labels:
        app.kubernetes.io/managed-by: "Helm"
      pspEnabled: false

    args:
      - --kubelet-insecure-tls
      - --kubelet-preferred-address-types=InternalIP,InternalDNS,ExternalDNS,ExternalIP

    resources:
      requests:
        cpu: 100m
        memory: 200Mi
      limits:
        cpu: 200m
        memory: 400Mi

    tolerations:
      - operator: "Exists"

    service:
      annotations: {}
      labels:
        app.kubernetes.io/managed-by: "Helm"

    deployment:
      annotations: {}
      labels:
        app.kubernetes.io/managed-by: "Helm"

    podLabels:
      app.kubernetes.io/managed-by: "Helm"

    podAnnotations:
      meta.helm.sh/release-name: "metrics-server"
      meta.helm.sh/release-namespace: "kube-system"
    EOT
  ]

  set {
    name  = "metrics.enabled"
    value = true
  }

  set {
    name  = "serviceMonitor.enabled"
    value = false
  }

  set {
    name  = "apiService.create"
    value = "true"
  }

  set {
    name  = "hostNetwork.enabled"
    value = "true"
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }

  set {
    name  = "args"
    value = "{--kubelet-insecure-tls=true,--kubelet-preferred-address-types=InternalIP}"
  }

  # Added resource limits
  set {
    name  = "resources.limits.cpu"
    value = "100m"
  }

  set {
    name  = "resources.limits.memory"
    value = "128Mi"
  }

  set {
    name  = "resources.requests.cpu"
    value = "50m"
  }

  set {
    name  = "resources.requests.memory"
    value = "64Mi"
  }

  timeout = 300

  depends_on = [
    aws_eks_cluster.main
  ]
}
