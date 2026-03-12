# Asciinema 4 Slides

A small toolkit to automate and script `asciinema` recordings tailored for slide decks.

This project was created to generate a large number of consistent demo videos aligned with a presentation template (font size, colors, timing, aspect ratio).
Instead of repeating manual steps, everything is scripted and reproducible.

If you need deterministic terminal demos for talks or training sessions, this may help.

<p align="center">
  <img src="examples/module_avail_o.gif" alt="Demo" />
</p>

---

## ✨ Features

- Scriptable wrapper around `asciinema`
- Consistent prompt styling
- Slide-friendly dimensions (16:9 ready)
- Controlled timing (idle limits, typing effect)
- One-command cast → GIF conversion via `agg`
    - And GIF → MP4 via `ffmpeg`

---

## Workflow

```text
Scripted demo commands
        |
        v
+------------------------+
| asciinema4slides.sh    |
+------------------------+
        |
        v
     demo.cast
        |
        v
+------------------------+
| cast2gif.sh            |
+------------------------+
        |
        v
      demo.gif
        |
        +--------------------+
                             v
                  +------------------------+
                  | gif2mp4.sh (Optional)  |
                  +------------------------+
                             |
                             v
                          demo.mp4
```

---

## 📦 Requirements

- `asciinema` ≥ 2.4
- `agg` ≥ 1.6
- `bash`

Optional:

- `ffmpeg` (for GIF → MP4 conversion)

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

### 4️⃣ (Optional) Convert the GIF to MP4

Some presentation tools allow pausing videos more easily than GIF animations.

```bash
./scripts/gif2mp4.sh demo.gif
```

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

## Skipping command execution

In some cases you may want to **display a command being typed without actually executing it**,
for example to shorten long outputs or show only a portion of a command result.

This can be done using the `ASCIINEMA_DRY_RUN` variable.

Example:

```bash
ASCIINEMA_DRY_RUN=1 ASCIINEMA find /usr/lib
find /usr/lib | head -n 5
echo "....."
find /usr/lib | tail -n 5
```

In this case:

- the command is **typed and displayed** in the recording
- but it is **not executed**
- allowing you to manually control the visible output

This is useful to simulate long-running commands or truncate large outputs in demos.

---

## 🧪 Experimental

An experimental all-in-one wrapper can chain the full workflow:

```text
demo.sh -> demo.cast -> demo.gif -> demo.mp4
```

Example:

```bash
./scripts/all-in-one.sh demo.sh
```

To allow overwriting existing files:

```bash
./scripts/all-in-one.sh --force demo.sh
```

This helper is convenient, but more fragile than running each step explicitly.
Use it with care, especially when output files already exist.

---

## ⚠️ Limitations

### Argument rendering (`%q` behavior)

Commands wrapped with the `ASCIINEMA` helper are printed using `printf %q` to ensure safe and reproducible shell escaping.

As a consequence, the displayed command may not exactly match the original user input.

For example:

```bash
echo "Hello world!"
```

may be rendered as:

```bash
echo Hello\ world\!
```

and:

```bash
module avail -o ""
```

may appear as:

```bash
module avail -o ''
```

This is expected behavior.

`%q` does not preserve the original quoting style — it generates a shell-escaped representation that is functionally equivalent and safe to re-execute.

The executed command remains identical; only its visual representation may differ.

If exact quote preservation is required, a different rendering strategy (e.g., raw string execution) would be necessary, with potential trade-offs in safety and reproducibility.

### Comments and pipes in demo scripts

Because `#` and `|` are interpreted by the shell before function calls,
comments cannot be captured by the `ASCIINEMA` helper.

To display comments in demos, use the following pattern:

```bash
sleep 2
echo 'command args # comment'
sleep 2
command args
__prompt
```

And pipes:

```bash
sleep 2
echo 'command args | command2 args2'
sleep 2
command args | command2 args2
__prompt
```

---

## 🤝 Acknowledgments

This project originates from an idea by **@Billae**, who also helped shape the design and overall approach.
Many thanks for the initial inspiration and feedback during development.
