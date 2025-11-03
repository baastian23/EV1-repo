🚀 EV2 – Evaluación Parcial 2 (DOY0101)
Automatización CI/CD y Orquestación de Contenedores

👥 Integrantes
Bastián Concha — @baastian23
Sergio Velásquez — @SheoInformatic

🧾 Descripción General
Repositorio base en HTML y Node.js, utilizado para practicar control de versiones y DevOps (CI/CD) durante la Evaluación Parcial 2.
Este proyecto implementa un pipeline completamente automatizado en GitHub Actions, que abarca:
Integración y pruebas automáticas.
Escaneo de seguridad y control de dependencias.
Contenedorización con Docker y publicación de imágenes.
Despliegue simulado.
Orquestación de contenedores y escalado.

🌿 Estrategia de Ramas (GitFlow)
💡 Justificación
Se implementa GitFlow porque:
Separamos el código estable (main) del código en desarrollo (develop).
Permitimos trabajo colaborativo paralelo con ramas feature/*, hotfix/* y release/*.
Aseguramos trazabilidad, control de cambios y un flujo claro de promoción a producción.
Es compatible con versionado semántico (SemVer) y con pipelines CI/CD automatizados.

🧩 Estructura de ramas
Rama	Uso principal
main	Producción / versión estable
develop	Integración de cambios en desarrollo
feature/*	Nueva funcionalidad
hotfix/*	Corrección urgente en producción
release/*	Preparación de una versión estable

Flujo de merges:
feature/* → PR → develop (requiere revisión y CI en verde).
release/* → PR → main (se etiqueta vX.Y.Z) y luego merge a develop.
hotfix/* → PR → main (urgente) y luego merge de main a develop.

🧱 Convención de nombres de ramas
feature/<descripcion-corta>
hotfix/<descripcion-corta>
release/<x.y.z>

📝 Estilo de commits (Conventional Commits)
feat: nueva funcionalidad
fix: corrección de bug
docs: cambios de documentación
refactor: cambio interno sin alterar comportamiento
test: pruebas
chore: tareas de build/devops

⚙️ Pipeline CI/CD (GitHub Actions)
El pipeline implementa integración continua y entrega continua, cumpliendo con los indicadores.
Build y Test
Instala dependencias.
Ejecuta pruebas unitarias con Jest + jsdom (npm test).
Si las pruebas fallan, el pipeline se detiene.

🐋 Contenedorización
Construye una imagen Docker basada en NGINX.
Etiqueta la imagen con el commit SHA (GIT_SHA) y con latest.
Publica la imagen en GitHub Container Registry (GHCR).

🔐 Análisis de Seguridad
Trivy escanea la imagen Docker y bloquea el pipeline si hay vulnerabilidades de severidad HIGH o CRITICAL.
Snyk ejecuta análisis adicional (si existe el secreto SNYK_TOKEN).
Dependabot mantiene dependencias npm / Docker / Actions actualizadas.
CodeQL hace análisis estático de seguridad en el código fuente.

☁️ Despliegue Automático
Usa Docker Compose para simular un entorno productivo.
Despliega el servicio con 2 réplicas usando --scale web=2.
Ejecuta pruebas de humo (smoke tests) vía curl http://localhost:8080 para validar respuesta 200 OK.
Hace docker compose down -v para limpiar al final.

🧭 Orquestación y Escalado
docker compose maneja múltiples contenedores y escala el servicio.
Se aplican restricciones y controles de seguridad:
read_only
no-new-privileges
cap_drop: ALL
La arquitectura está diseñada para poder migrar a Kubernetes usando manifiestos en una etapa futura.

🛡️ Seguridad y Gobernanza
Herramientas usadas en el pipeline:
Dependabot → mantiene dependencias actualizadas.
CodeQL → análisis estático del código.
Trivy → escaneo de vulnerabilidades en la imagen Docker (falla si hay HIGH+).
Snyk → test de seguridad opcional en contenedores.
NGINX → configurado con headers de seguridad en nginx.conf.
Estas medidas garantizan cumplimiento de seguridad, gobernanza y calidad antes del despliegue.

📈 Escalabilidad y Orquestación
El archivo docker-compose.yml:
Levanta el servicio en múltiples réplicas (ej: --scale web=2) para simular balanceo de carga.
Aplica límites de CPU/Memoria y endurecimiento de seguridad.
Permite levantar el entorno tanto en local como dentro del pipeline.
Esto simula un entorno cloud controlado, donde se prueba despliegue continuo y comportamiento bajo orquestación.

🔧 Variables y Secrets requeridos
Configurar en:
Settings → Secrets and variables → Actions
Variable	Uso
SONAR_TOKEN	(Opcional) Activar análisis de calidad en SonarCloud y Quality Gate.
SNYK_TOKEN	(Opcional) Habilitar análisis con Snyk en el pipeline.
GITHUB_TOKEN	Token integrado de GitHub Actions para autenticarse en GHCR y hacer push de la imagen.

🔍 Trazabilidad y Auditoría
Flujo GitFlow (main, develop, feature/*), con PR obligatorios.
Los Pull Requests requieren revisión humana y pipeline en verde.
Cada imagen Docker se publica en GHCR con:
latest
el hash del commit (GIT_SHA)
Se agregan etiquetas OCI como org.opencontainers.image.source y revision para auditoría y trazabilidad.
Esto permite demostrar de forma clara qué commit generó qué imagen y en qué estado fue desplegada.

🏁 Resumen de Cumplimiento (Indicadores de Logro)
Indicador	Descripción	Evidencia en este proyecto Cumple
Uso de contenedores para facilitar despliegue en la nube	Dockerfile, build de imagen, push a GHCR	✅
Pruebas automatizadas integradas en CI	npm test con Jest en el pipeline	✅
Análisis de seguridad y bloqueo en vulnerabilidades críticas	Trivy (exit code en HIGH+), Snyk, Dependabot, CodeQL	✅
Despliegue automático en entorno cloud simulado con trazabilidad completa	Docker Compose, smoke tests con curl, versionado SHA	✅
Orquestación de contenedores para garantizar operación en escala	docker compose up --scale web=2 y políticas de runtime	✅

🏁 Resumen Final
Este proyecto demuestra la automatización completa del ciclo de vida de un microservicio:
Contenedorización con Docker y publicación en GHCR.
Pipeline CI/CD con build, test, análisis de seguridad y despliegue automático.
Validación post-despliegue (smoke tests).
Orquestación y escalado con Docker Compose.
Trazabilidad total mediante ramas controladas, PR con revisión y etiquetado de imágenes por commit.
En otras palabras: cumple todos los criterios de la Evaluación Parcial 2. ✅
>>>>>>> ebfb3301e1b32c5b9016df52973a9abdd43bbaac
