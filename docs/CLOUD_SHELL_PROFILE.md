# Cloud Shell free profile

Dokumen ini menjelaskan batas desain repo agar tetap stabil pada Google Cloud Shell gratis.

## Fakta desain yang dipakai

Desain repo ini mengikuti batas konservatif dari dokumentasi resmi Google Cloud Shell:

- Cloud Shell memiliki **5 GB persistent storage** di `$HOME`.
- Ada **weekly usage quota** default untuk Cloud Shell gratis.
- Sesi Cloud Shell bersifat **ephemeral**; setelah tidak aktif, sesi berakhir dan VM kerja dibuang.
- Perubahan di luar `$HOME` **tidak boleh dianggap persisten** antar sesi.

Sumber resmi Google Cloud:
- https://cloud.google.com/shell/docs/quotas-limits
- https://cloud.google.com/shell/docs/how-cloud-shell-works

## Implikasi teknis

Karena itu repo ini harus:

- kecil secara ukuran
- tidak membawa model weights
- tidak membawa dataset besar
- tidak mengandalkan daemon/background process jangka panjang
- tidak mengandalkan Docker build berat
- tidak mengandalkan vector index lokal besar
- tidak mengandalkan state penting di luar file teks kecil

## Aturan praktis repo

- utamakan file `.md`, `.json`, `.sh`, `.py` kecil
- hindari dependency npm/pip besar kecuali benar-benar perlu
- hindari binary besar, cache, dan artefak hasil generasi
- logika berat dipindah ke n8n, OpenClaw, atau server lain
- gunakan repo ini sebagai profile + prompt + task-contract, bukan monolith runtime

## Batas operasional yang disarankan

- target ukuran repo kerja: < 25 MB
- satu artefak output: < 10 MB
- temp workspace: < 256 MB
- tidak ada long-running worker di Cloud Shell
- tidak ada local DB yang dianggap durable

## Pola yang disarankan

- Cloud Shell dipakai untuk edit, test ringan, dan sync git
- eksekusi rutin dilakukan lewat n8n / OpenClaw worker
- inference dilakukan lewat Ollama atau endpoint model yang sudah ada
- hasil penting disimpan ke repo, DB remote, atau workflow storage yang benar
