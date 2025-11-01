EV2 – Evaluación Parcial 2 DOY0101
Integrantes

Bastián Concha (@baastian23)
Sergio Velásquez (@SheoInformatic)

Descripción General
Repositorio base en HTML y Node.js utilizado para practicar control de versiones y DevOps (CI/CD) durante la Evaluación Parcial 2.
El proyecto implementa un pipeline completamente automatizado en GitHub Actions, que incluye integración, pruebas, análisis de seguridad, despliegue simulado y orquestación de contenedores.

Estrategia de Ramas (GitFlow)
Justificación

Se utiliza GitFlow por las siguientes razones:
Permite separar el código estable en main del código en desarrollo (develop).
Facilita el trabajo colaborativo mediante ramas feature/*, hotfix/* y release/*.
Asegura trazabilidad, control de versiones y flujo DevOps claro en entornos educativos.
Compatible con SemVer (versionado semántico) y CI/CD automatizado.

Estructura
Principales: main (producción) y develop (integración).
Soporte: feature/<nombre>, release/<x.y.z>, hotfix/<nombre>.
Flujo de merges:
feature/* → Pull Request a develop (requiere revisión + CI verde).
release/* → Pull Request a main (con tag vX.Y.Z) y merge a develop.
hotfix/* → Pull Request a main (urgente) y merge posterior a develop.

Convenciones de nombres
feature/<descripcion-corta>
hotfix/<descripcion-corta>
release/<x.y.z>

Estilo de commits (Conventional Commits)
feat: nueva funcionalidad
fix: corrección de bug
docs: documentación
refactor: refactor interno
test: pruebas
chore: tareas de build/devops

CI/CD, Calidad y Trazabilidad
Pipeline (GitHub Actions)

Implementa integración y entrega continua (IL2.2 – IL2.4):

Build y Test:
Instala dependencias y ejecuta pruebas unitarias con Jest + jsdom (npm test).
Contenedorización (IL2.1):
Construye una imagen Docker basada en NGINX y la publica en GHCR (GitHub Container Registry).
Análisis de seguridad (IL2.3):
Trivy analiza vulnerabilidades (bloquea el pipeline en nivel HIGH+).
Snyk ejecuta test opcional si existe SNYK_TOKEN.
Dependabot mantiene actualizadas las dependencias.
CodeQL realiza análisis estático del código.

Despliegue automático (IL2.4):
Usa Docker Compose para simular un entorno productivo.
Escala el servicio a 2 réplicas (--scale web=2).
Valida endpoints (curl http://localhost:8080 → “200 OK”).
Ejecuta limpieza con docker compose down -v.

Orquestación (IL2.5):
Compose define límites de CPU/Memoria y políticas de seguridad (read_only, no-new-privileges, cap_drop: ALL).
Configurable para Kubernetes (opcional) mediante manifiestos futuros.

Seguridad y Gobernanza
Dependabot: actualiza dependencias npm, Docker y GitHub Actions.
CodeQL: detección de vulnerabilidades estáticas.
Trivy: escaneo de imagen Docker, falla en vulnerabilidades críticas.
Snyk: test condicional de seguridad (requiere token).
NGINX: configurado con headers seguros definidos en nginx.conf.

Escalabilidad y Orquestación
El archivo docker-compose.yml:
Define 2 réplicas web para simular balanceo de carga.
Establece restricciones de recursos (CPU/Memoria) y políticas de seguridad.
Permite levantar el entorno localmente o dentro del pipeline CI/CD.

Variables y Secrets necesarios
Configurar en Settings → Secrets and variables → Actions:
SONAR_TOKEN → opcional, activa análisis de SonarCloud.
SNYK_TOKEN → opcional, habilita test de Snyk.
GITHUB_TOKEN → integrado automáticamente por GitHub para GHCR.

Trazabilidad y Auditoría
Flujo GitFlow con ramas main, develop, feature/*.
PRs con checks automáticos (CI verde requerido para merge).
Imágenes en GHCR versionadas por commit (GIT_SHA) y tag latest.
Etiquetas OCI en las imágenes (org.opencontainers.image.source y revision) para auditoría.

Resumen final de tu entrega:
Dockerfile y Compose configurados correctamente.
CI/CD funcional (build → test → scan → deploy).
Seguridad y gobernanza implementadas (Trivy, Snyk, Dependabot, CodeQL).
Escalabilidad y orquestación comprobadas (2 réplicas).
README completo, profesional y alineado con los indicadores.
