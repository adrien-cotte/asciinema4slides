# Asciinema 4 Slides

A small toolkit to automate and script `asciinema` recordings tailored for slide decks.

This project was created to generate a large number of consistent demo videos aligned with a presentation template (font size, colors, timing, aspect ratio).  
Instead of repeating manual steps, everything is scripted and reproducible.

If you need deterministic terminal demos for talks or training sessions, this may help.

---

## ✨ Features

- Scriptable wrapper around `asciinema`
- Consistent prompt styling
- Slide-friendly dimensions (16:9 ready)
- Controlled timing (idle limits, typing effect)
- One-command cast → GIF conversion via `agg`

---

## 📦 Requirements

- `asciinema` ≥ 2.4  
- `agg` ≥ 1.6  
- `bash`

---

## 🚀 Quickstart

### 1️⃣ Wrap your demo script

```bash
#!/usr/bin/env bash

source etc/config.sh

ASCIINEMA echo Hello
```

---

### 2️⃣ Record the cast

```bash
./scripts/asciinema4slides.sh -c ./demo.sh demo.cast
```

---

### 3️⃣ Generate the GIF

```bash
./scripts/cast2gif.sh demo.cast
```

The generated GIF matches your configured:

- font size  
- rows / columns  

---

## ⚙️ Configuration

Edit:

```
etc/user-config.sh
```

to override defaults such as:

- font size
- prompt
- typing speed
- row/col ratio

---

## 🤝 Acknowledgments

This project originates from an idea by **@Billae**, who also helped shape the design and overall approach.  
Many thanks for the initial inspiration and feedback during development.
