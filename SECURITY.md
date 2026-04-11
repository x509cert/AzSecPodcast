# Security Policy

## Supported Versions

The Azure Security Podcast website is a static site with no versioned releases.
Security fixes are applied to the `master` branch and deployed continuously.

## Reporting a Vulnerability

If you discover a security vulnerability in this repository, please **do not** open a public GitHub issue.

Instead, report it privately via one of these options:

- **GitHub Private Vulnerability Reporting**: Use the [Security tab](../../security/advisories/new) in this repository
- **Email**: Contact the maintainers at the email address listed on [azsecuritypodcast.net](https://www.azsecuritypodcast.net)

Please include:

- A description of the vulnerability and its potential impact
- Steps to reproduce or a proof-of-concept (if applicable)
- Any suggested remediation

We aim to acknowledge reports within **5 business days** and provide a resolution timeline within **14 business days** where possible.

## Scope

The following are **in scope** for security reports:

- Content Security Policy bypasses on the hosted site
- Supply chain issues with CDN dependencies (Font Awesome, RSS.com player)
- Sensitive data exposure in the repository (credentials, tokens, PII)
- CI/CD pipeline misconfigurations (`.github/workflows/`)

The following are **out of scope**:

- Vulnerabilities in third-party services (Azure, RSS.com, Microsoft)
- Social engineering or phishing unrelated to this codebase
- Tracking parameters in external URLs linked from episode notes

## Security Practices

This project follows these security practices:

- HTTP security headers enforced via `web.config` (CSP, HSTS, X-Frame-Options, Permissions-Policy)
- Deployment secrets managed via GitHub Actions encrypted secrets
- No user-supplied input accepted or stored by this site
- Dependencies kept minimal (no npm/pip packages)
