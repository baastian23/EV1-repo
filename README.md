EV1 – Microservicio HTML

Integrantes
- Bastián Concha (@baastian23)
- Sergio Velasquez (@SheoInformatic)

Descripción breve
Repositorio base en HTML para practicar control de versiones y DevOps (CI/CD) durante la evaluación parcial.

---

Estrategia de ramas

Para este proyecto implementamos **GitFlow**, porque:

- Permite separar el código estable en la rama `main` del código en desarrollo en `develop`.
- Usamos ramas `feature/*` para nuevas funcionalidades y `hotfix/*` para correcciones urgentes.
- Garantiza trazabilidad y control de versiones en un entorno colaborativo.
- Comparado con GitFlow que nos da más claridad y control al momento de simular flujos DevOps en el ámbito académico.

Por esta razón, elegimos **GitFlow** como estrategia de ramificación.


## Estrategia de ramificación (GitFlow)
Usamos **GitFlow**:
- Principales: `main` (producción) y `develop` (integración).
- Soporte: `feature/<nombre>`, `release/<x.y.z>`, `hotfix/<nombre>`.

**Justificación:** equipo colaborando en paralelo, necesidad de releases formales y trazabilidad clara. Compatible con **SemVer** y CI.

### Naming de ramas
- `feature/<descripcion-corta>`
- `hotfix/<descripcion-corta>`
- `release/<x.y.z>`

### Commits (Conventional Commits)
- `feat: ...` nueva funcionalidad
- `fix: ...` corrección de bug
- `docs: ...` documentación
- `refactor: ...` refactor interno
- `test: ...` pruebas
- `chore: ...` tareas de build/devops

### Flujo de merges
- `feature/*` → **PR a `develop`** (checks verdes, 1 review, *squash merge*).
- `hotfix/*` → **PR a `main`** (urgente); luego **merge de `main` a `develop`**.
- `release/*` → PR a `main` (tag `vX.Y.Z`) y PR a `develop`.

### Revisión
- 1 aprobación mínima.
- CI (GitHub Actions) en **verde** en push a `develop` y PR a `main`.

## CI/CD, Calidad y Trazabilidad

Pipeline (GitHub Actions):
1) Tests unitarios (Jest + jsdom).
2) Build Docker (NGINX) y escaneo de imagen con Trivy (bloquea en HIGH+). Opcional Snyk si `SNYK_TOKEN` está configurado.
3) Push de la imagen a GHCR.
4) Despliegue simulado con Docker Compose (2 réplicas) y smoke tests (200 OK).

Seguridad:
- Dependabot (npm, Docker y GitHub Actions).
- CodeQL para análisis estático.
- Trivy (y Snyk opcional) bloquean el pipeline si hay vulnerabilidades severas.

Escalabilidad y gobernanza:
- `docker-compose.yml` define límites de CPU/Mem, `read_only`, `no-new-privileges`, `cap_drop: ALL`.
- NGINX con headers de seguridad en `nginx.conf`.

Ejecución local:
```sh
docker build -t ev1-repo:local .
docker run -d -p 8080:80 ev1-repo:local
# o con Compose (requiere .env con COMMIT_SHA y OWNER o ajusta la imagen)
```

Trazabilidad:
- Flujo GitFlow (main, develop, feature/*).
- PRs con checks, imagen versionada en GHCR por commit SHA.
