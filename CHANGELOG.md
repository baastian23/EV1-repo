# Changelog
Basado en Keep a Changelog.  
Usamos Semantic Versioning.

## [Unreleased]
- Sin cambios aún.

## [0.1.0] - 2025-11-01

### Added
- CI con GitHub Actions (Docker + NGINX) y smoke tests.
- Documentación de GitFlow, naming, commits y flujo de PR/merge.
- Build de imagen Docker (NGINX) y push a GHCR con etiquetas `latest` y `SHA`.
- Pruebas automatizadas con Jest + jsdom (incluye polyfill de TextEncoder/TextDecoder).
- Despliegue simulado con Docker Compose (2 réplicas) y smoke tests de salud.
- Snyk Open Source (SCA), Snyk Code (SAST) y Snyk Container en CI (bloquea en HIGH+ cuando existe `SNYK_TOKEN`).
- Trivy para escaneo de imagen (bloquea en HIGH/CRITICAL).
- Etiquetas OCI para trazabilidad (source, revision/SHA) en la imagen.

### Changed
- `nginx.conf` reparado y endurecido: cabeceras de seguridad, cacheo estático y configuración válida.
- Ajustes de CI: path en minúsculas para GHCR, fallback para `npm ci`, y pasos condicionados por secretos.

### Security
- Compose endurecido: `read_only`, `cap_drop: [ALL]`, `no-new-privileges: true`, `tmpfs` y `healthcheck`.
- SonarCloud deshabilitado por decisión; se estandariza Snyk como analizador principal.

### Docs
- README actualizado: pipeline, secretos requeridos (`SNYK_TOKEN`), uso de GHCR y Compose, checklist IL2.*.
- Comentarios en `sonar-project.properties` aclarando que está deshabilitado.
