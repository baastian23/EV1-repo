# Guía de Contribución
- Estrategia: GitFlow (main, develop, feature/*, release/*, hotfix/*).
- Naming: feature/<desc>, hotfix/<desc>, release/<x.y.z>
- Commits: Conventional Commits (feat, fix, docs, refactor, test, chore).
- PRs: 1 revisor mínimo + CI verde + actualizar CHANGELOG si aplica.
- Merges:
  - feature/* → develop (squash)
  - hotfix/* → main y luego main → develop
  - release/* → main (tag) y develop
