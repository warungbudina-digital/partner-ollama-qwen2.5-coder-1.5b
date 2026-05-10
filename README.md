# partner-ollama-qwen2.5-coder-1.5b

Partner coding kecil untuk Code node n8n, transform data, regex, mapping, dan patch ringan.

## Tujuan

Repo ini adalah baseline partner khusus model **qwen2.5-coder:1.5b** untuk ekosistem OpenClaw + n8n Ayang. Fokusnya bukan membuat sistem besar di dalam repo, tapi memberi arah yang stabil, ringan, dan mudah dipakai pada **Google Cloud Shell gratis**.

## Prinsip desain

- kecil, cepat, dan murah dijalankan
- minim dependency tambahan
- tidak menyimpan artefak besar di repo
- cocok untuk sesi Cloud Shell yang ephemeral
- output harus mudah dipakai ulang oleh n8n

## Peran utama

- model: `qwen2.5-coder:1.5b`
- role: `n8n-code-transform-partner`
- use in n8n: Code helper for Function/Code nodes, expression drafting, payload normalization.

## Cocok untuk

- generate small JS for n8n Code nodes
- transform JSON payloads
- write regex and parsing helpers
- draft workflow expressions
- produce structured patch suggestions

## Hindari untuk

- large framework scaffolding
- heavy repo-wide refactors
- long-form editorial content
- deep market forecasting

## Struktur awal

- `configs/partner.profile.json` — profil runtime dan guardrails partner
- `docs/CLOUD_SHELL_PROFILE.md` — batas desain agar tetap stabil di Cloud Shell gratis
- `docs/N8N_ROLE.md` — peran partner di workflow n8n
- `prompts/SYSTEM.md` — prompt sistem dasar partner
- `tasks/BACKLOG.md` — backlog implementasi awal
- `scripts/preflight.sh` — cek ringan sebelum dipakai di Cloud Shell

## Quick start

```bash
bash scripts/preflight.sh
cat configs/partner.profile.json
cat prompts/SYSTEM.md
```

## Catatan

Repo ini sengaja dibuat **tipis**. Di Cloud Shell gratis, kestabilan lebih penting daripada banyak fitur. Simpan logika berat di n8n/OpenClaw atau service remote, bukan di repo partner ini.


## Deploy bridge

Repo ini juga sudah punya baseline deploy ala `partner-AI` di:

- `deploy/ollama-fastapi/`

Isi folder itu menyediakan:
- Docker build untuk FastAPI bridge
- `docker-compose.yml` untuk Ollama + API + Cloudflared
- `.env.example`
- contoh config OpenClaw

Default model deploy untuk repo ini: **qwen2.5-coder:1.5b**
