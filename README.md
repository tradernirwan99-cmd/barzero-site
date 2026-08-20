# Bar Zero — website

Static one-page site, Mongolian / English, hosted on GitHub Pages.

## Files

| Path | What it is |
|---|---|
| `src/page.html` | **The source.** Edit this one — all markup, styles and scripts live here. |
| `index.html` | Generated. Do not edit by hand; `build.ps1` overwrites it. |
| `build.ps1` | Wraps `src/page.html` in a full HTML document (head, meta, OG tags, favicon). |
| `.nojekyll` | Tells GitHub Pages to serve the files as-is. |

## Editing

1. Edit `src/page.html`.
2. Rebuild:
   ```
   powershell -ExecutionPolicy Bypass -File build.ps1
   ```
3. Commit and push. GitHub Pages redeploys within a minute or two.

Site metadata (title, description, URL) lives at the top of `build.ps1`.

## Translations

Every translatable element carries `data-mn` and `data-en` attributes; the
language button swaps `textContent` between them and stores the choice in
`localStorage`. When you add text, add **both** attributes or the button will
leave that element untranslated.

## Placeholders to replace

- Brand name `BAR ZERO` (nav and footer)
- Contact email `hello@barzero.dev`
- Telegram link `t.me/barzero`
- Prices in the pricing section
- `$siteUrl` in `build.ps1`

## Publishing

GitHub Pages: **Settings → Pages → Source: Deploy from a branch → `main` / `/ (root)`**
