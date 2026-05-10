# N8N role

## Ringkasan

Partner ini diposisikan sebagai **Code helper for Function/Code nodes, expression drafting, payload normalization.**

## Pola pakai

### Input ideal

- JSON kecil
- text pendek / sedang
- markdown ringkas
- metadata task yang jelas

### Output ideal

- JSON terstruktur
- summary singkat
- keputusan ringkas yang mudah diteruskan ke node berikutnya

## Guardrails

- jangan kirim konteks besar tanpa seleksi
- jangan pakai untuk loop reasoning panjang
- jangan pakai untuk pekerjaan yang butuh memori lokal besar
- jika task terlalu berat, naikkan ke partner/model yang lebih cocok

## Routing saran

- first-pass / cheap path -> partner ini
- heavy path -> model lebih besar atau workflow khusus
- final execution -> node deterministik / service backend

## Contoh posisi di workflow

1. Trigger / Scheduler
2. Normalization node
3. **Partner ini**
4. Validator / Guardrail node
5. Router / Storage / Notification
