# Clínica Vanessa Alves — site de demonstração

Site de apresentação (página única) para a Clínica Vanessa Alves, Castelo-ES.

- `index.html`: o site completo, com fotos, fontes e scripts embutidos (sem dependências externas).
- `_headers` (Netlify/Cloudflare Pages) e `vercel.json` (Vercel): cabeçalhos de segurança.
- `robots.txt` e a meta `noindex`: impedem a indexação enquanto for demonstração. Remover os dois quando a clínica aprovar e o site virar oficial.

Publicado com GitHub Pages a partir da branch `main` (pasta raiz): https://vitortozi.github.io/clinica-vanessa-alves/

## Como trabalhamos

Toda alteração passa por **pull request**, para Vitor e Nicolas acompanharem e revisarem:

1. A mudança é feita numa branch nova (nunca direto na `main`).
2. Ao enviar a branch, o GitHub **abre o pull request sozinho** (`.github/workflows/abrir-pull-request.yml`).
3. Alguém revisa em *Files changed* e clica em **Merge pull request**.
4. O merge na `main` publica o site em 1 a 2 minutos.

Para publicar ou atualizar pelo PC, veja `COMO-USAR.txt` (scripts `publicar-no-github.bat` e `atualizar-e-abrir.bat`).

Desenvolvido por Vitor Tozi Francischetto e Nicolas Perim.
