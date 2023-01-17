{{- define "certmanager.wait" }}
{{- $fullName := include "tc.common.names.fullname" . }}
---
apiVersion: batch/v1
kind: Job
metadata:
  namespace: {{ .Release.Namespace }}
  name: {{ $fullName }}-wait
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-1"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation
spec:
  template:
    spec:
      serviceAccountName: {{ $fullName }}-wait
      containers:
        - name: {{ $fullName }}-wait
          image: {{ .Values.kubectlImage.repository }}:v1.26.0
          securityContext:
            runAsUser: 568
            runAsGroup: 568
            readOnlyRootFilesystem: true
            runAsNonRoot: true
          command:
            - "/bin/sh"
            - "-c"
            - |
              /bin/sh <<'EOF'
              kubectl wait --namespace metallb-system --for=condition=ready pod --selector=app=metallb --timeout=90s || echo "metallb-system wait failed..."
              kubectl wait --namespace cert-manager --for=condition=ready pod --selector=app=cert-manager --timeout=90s || echo "cert-manager wait failed..."
              kubectl wait --namespace cert-manager-webhook --for=condition=ready pod --selector=app=cert-manager --timeout=90s || echo "cert-manager-webhook wait failed..."
              kubectl wait --namespace cert-manager-cainjector --for=condition=ready pod --selector=app=cert-manager --timeout=90s || echo "cert-manager-cainjector wait failed..."
              timeout=0
              while (k3s kubectl describe endpoints cert-manager -n cert-manager | grep '  Addresses' | grep '<none>'); do
                sleep 5
                (($timeout++))
                if [[ $timeout -eq 20 ]]; then
                  echo "waiting for cert-manager endpoint failed..."
                  exit 0
                fi
              done
              while (k3s kubectl describe endpoints cert-manager-webhook -n cert-manager | grep '  Addresses' | grep '<none>'); do
                sleep 5
                (($timeout++))
                if [[ $timeout -eq 20 ]]; then
                  echo "waiting for cert-manager webhook endpoint failed..."
                  exit 0
                fi
              done
              cmctl check api --wait=2m
              EOF
          volumeMounts:
            - name: {{ $fullName }}-manifests-temp
              mountPath: /tmp
            - name: {{ $fullName }}-manifests-home
              mountPath: /home/apps/
      restartPolicy: Never
      volumes:
        - name: {{ $fullName }}-manifests-temp
          emptyDir: {}
        - name: {{ $fullName }}-manifests-home
          emptyDir: {}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: {{ $fullName }}-wait
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-2"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation
rules:
  - apiGroups:  ["*"]
    resources:  ["pods"]
    verbs:  ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: {{ $fullName }}-wait
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-2"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ $fullName }}-wait
subjects:
  - kind: ServiceAccount
    name: {{ $fullName }}-wait
    namespace: {{ .Release.Namespace }}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ $fullName }}-wait
  namespace: {{ .Release.Namespace }}
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "-2"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation
{{- end }}
