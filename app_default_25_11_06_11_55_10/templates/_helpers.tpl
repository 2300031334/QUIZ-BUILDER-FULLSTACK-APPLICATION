{{- /*
Generate the full name of the chart release.
*/ -}}
{{- define "quiz-builder.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- /*
Generate the name for the frontend component.
*/ -}}
{{- define "quiz-builder.frontend.name" -}}
{{- printf "%s-frontend" (include "quiz-builder.fullname" .) -}}
{{- end -}}

{{- /*
Generate the name for the backend component.
*/ -}}
{{- define "quiz-builder.backend.name" -}}
{{- printf "%s-backend" (include "quiz-builder.fullname" .) -}}
{{- end -}}

{{- /*
Generate common labels for all resources.
*/ -}}
{{- define "quiz-builder.labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
{{- end -}}

{{- /*
Generate selector labels for frontend.
*/ -}}
{{- define "quiz-builder.frontend.selectorLabels" -}}
app: {{ include "quiz-builder.frontend.name" . }}
{{- end -}}

{{- /*
Generate selector labels for backend.
*/ -}}
{{- define "quiz-builder.backend.selectorLabels" -}}
app: {{ include "quiz-builder.backend.name" . }}
{{- end -}}

{{- /*
Get ingress host with fallback.
*/ -}}
{{- define "quiz-builder.ingress.host" -}}
{{- with .Values.frontend.ingress.host }}
{{ . | quote }}
{{- else }}
""
{{- end }}
{{- end -}}

{{- /*
Get ingress path with default /
*/ -}}
{{- define "quiz-builder.ingress.path" -}}
{{- with .Values.frontend.ingress.path }}
{{ . | default "/" | quote }}
{{- else }}
"/"
{{- end }}
{{- end -}}
