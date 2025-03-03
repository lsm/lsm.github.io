# Bilingual Blog

A minimalist bilingual blog built with Jekyll for GitHub Pages.

## Features
- Bilingual support (English & Chinese)
- Minimalist black & white theme with dark mode
- PR-based commenting system
- Custom Chinese font (Noto Serif SC)

## Deployment to GitHub Pages

1. Create a new repository on GitHub
2. Push this code to the repository
3. Go to repository Settings > Pages
4. Under "Source", select the main branch
5. Your site will be published at `https://[username].github.io/[repository]`

## Local Development

```bash
bundle install
bundle exec jekyll serve
```

## Adding Comments

Comments are stored in `_data/comments/[post-slug].yml`. To add a comment:
1. Fork the repository
2. Create/edit the appropriate YAML file
3. Submit a pull request

## License

MIT
