# Deploy ringan di VPS terpisah: Ollama + FastAPI + Cloudflared (Zero Trust)

Target setup ini mengikuti pola repo `partner-AI`, tetapi sudah disesuaikan untuk repo **partner-ollama-qwen2.5-coder-1.5b**.

- qwen2.5-coder:1.5b berjalan di VPS terpisah.
- OpenClaw memanggil endpoint FastAPI via domain tunnel Cloudflare Zero Trust.
- Cocok untuk mesin ringan sekitar **2 vCPU / 8 GB RAM / 5 GB storage**, dengan syarat hanya menarik model yang memang diperlukan.

## Arsitektur

OpenClaw (server utama) -> `https://llm-bridge-qwen-coder.example.com/v1/chat/completions` -> Cloudflare Tunnel -> FastAPI bridge -> Ollama (`qwen2.5-coder:1.5b`)

## 0) Prasyarat

- VPS Linux dengan Docker + Docker Compose plugin.
- Akun Cloudflare Zero Trust.
- Named Tunnel sudah dibuat di Cloudflare, plus route DNS ke hostname publik Anda.

## 1) Setup file env

```bash
cd deploy/ollama-fastapi
cp .env.example .env
```

Isi `.env`:

- `BRIDGE_API_KEY`: secret untuk mengamankan endpoint FastAPI.
- `TUNNEL_TOKEN`: token Tunnel dari Cloudflare Zero Trust.

## 2) Jalankan service

```bash
docker compose up -d --build
```

Cek status:

```bash
docker compose ps
docker compose logs -f api
```

## 3) Install model

Untuk storage kecil, gunakan satu model utama saja:

```bash
docker compose exec ollama ollama pull qwen2.5-coder:1.5b
docker compose exec ollama ollama list
```

Jika perlu menghemat storage:

```bash
docker compose exec ollama ollama rm <model-lain>
```

## 4) Verifikasi endpoint bridge dari VPS

```bash
curl -sS http://127.0.0.1:8000/healthz

curl -sS http://127.0.0.1:8000/v1/chat/completions   -H 'Content-Type: application/json'   -H "Authorization: Bearer ${BRIDGE_API_KEY}"   -d '{
    "model": "qwen2.5-coder:1.5b",
    "messages": [{"role":"user","content":"Balas 1 kalimat."}],
    "stream": false
  }'
```

## 5) Cloudflare Tunnel route

Di Cloudflare Zero Trust dashboard, route tunnel ke service internal:

- **Service type**: HTTP
- **URL origin**: `http://api:8000`
- **Public hostname**: misal `llm-bridge-qwen-coder.example.com`

## 6) Konfigurasi OpenClaw

Gunakan file contoh berikut:

```bash
cp deploy/ollama-fastapi/openclaw.config.example.yaml ~/.openclaw/config.yaml
```

Atau sesuaikan provider yang ada.

## 7) Hardening singkat

- Jangan expose port Ollama (`11434`) ke publik.
- Biarkan akses publik hanya lewat Cloudflare hostname.
- Rotasi `BRIDGE_API_KEY` berkala.
- Pertimbangkan Cloudflare Access / service token sebagai lapisan tambahan.
