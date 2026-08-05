# Copilot instructions for AzSecPodcast

## Commands

- There is no package manifest and no local build/test/lint suite. This is a static HTML/CSS/JS site deployed as the repository root.
- Serve locally from the repo root with `python -m http.server 8000`, then open `http://localhost:8000/`. Use a local server rather than `file://` because `index.html` fetches `data/episodes.json`.
- Validate the full episode data with `Get-Content .\data\episodes.json -Raw -Encoding utf8 | ConvertFrom-Json | Out-Null`.
- Validate one generated episode file with `Get-Content .\data\Episode0127.json -Raw -Encoding utf8 | ConvertFrom-Json | Out-Null`.
- Add an episode with the interactive PowerShell helper: `.\New-Episode.ps1`. Use `.\New-Episode.ps1 -Help` for script help.
- Deployment is `.github\workflows\master_azuresecuritypodcast.yml`: pushes to `master` deploy the repo root to the `azuresecuritypodcast` Azure Web App with `azure/webapps-deploy`.

## Architecture

- `index.html` is the static shell for the home page: metadata, hero section, podcast links, `#episodes-container`, footer, `css/styles.css?v=4`, and deferred `ui.js`.
- `ui.js` owns episode rendering. It fetches `data/episodes.json`, renders the first 15 episodes immediately, appends the rest after the first paint, opens the newest episode by default, and uses event delegation on `h3.Heading` for expand/collapse.
- `data/episodes.json` is the episode source of truth. Episodes are stored newest-first, and each object has `number`, `date`, `title`, and raw HTML in `contentHtml`.
- Episode anchors are generated in `ui.js`: numbers under 100 use 3 digits, numbers 100+ use 4 digits, producing IDs like `Ep099`/`ep099` and `Ep0126`/`ep0126`.
- `New-Episode.ps1` creates `data\EpisodeNNN.json` and can prepend the episode into `data\episodes.json`, then deletes the temporary per-episode file.
- `bios.html` is a separate static page for host bios that shares the same stylesheet and image assets.
- `css\styles.css` is a combined stylesheet for layout, responsive behavior, and podcast-specific rules such as `.podcast-player` and `h3.Heading`.
- `web.config` configures Azure App Service/IIS static serving: JSON MIME type, Markdown MIME type, compression, security headers, CSP, and cache rules for `css`, `images`, `ui.js`, and `data`.

## Key conventions

- Keep `data\episodes.json` newest-first. The first array item is treated as the newest episode, expanded by default, and has its RSS iframe eager-loaded.
- Prefer `.\New-Episode.ps1` for episode creation so filenames, host/guest wording, RSS iframe markup, transcript links, and prepend behavior stay consistent.
- If editing `contentHtml` by hand, keep it valid JSON string content and preserve the existing HTML patterns: RSS.com iframe, transcript as the first link, and external links with `target="_blank"` plus `rel="noreferrer"`.
- Do not move episode markup back into `index.html`; the current design keeps episode content in JSON and renders it client-side.
- When adding external scripts, styles, fonts, images, frames, or fetch targets, update the CSP in `web.config` at the same time. Current runtime dependencies include cdnjs for Font Awesome and `player.rss.com` for embedded players.
- Preserve the `images\Expand.png` and `images\Collapse.png` expand/collapse icon paths unless `ui.js` is updated with matching paths.
- The deploy workflow installs `html-minifier-terser` but does not currently run a minification step; do not assume generated or minified files are part of the deployment output.
