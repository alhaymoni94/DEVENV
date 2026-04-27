# Security Best Practices

## API Key Management

### Recommended: Environment Variables

For AI tools (opencode, etc.), prefer using environment variables instead of config files:

```bash
# In your shell profile (~/.zshrc)
export OPENAI_API_KEY="sk-..."
export ANTHROPIC_API_KEY="sk-ant-..."

# Or use a tool like direnv for per-directory env vars
```

### Config File Option

If using config files, ensure they're in locations that won't be committed:

- `~/.config/opencode/config.json` (already in .gitignore)
- Never store keys in the project repository

### Never Do

- ❌ Commit API keys to git
- ❌ Add keys to `.gitignore`-protected files that are already tracked
- ❌ Share keys in chat or documentation

## File Permissions

The project uses proper permissions:

- Scripts: `755` (executable)
- Configs: `644` (read/write owner, read others)
- Private data: Should be `600` for sensitive files

## Git Security

- Repository initialized in student workspaces (not camp root)
- `.gitignore` covers: `.opencode/`, `mise.toml`, `toolkit/.setup-config`, `__pycache__/`, `*.pyc`, `.pytest_cache/`
- Never commit: credentials, API keys, personal data

## Docker Security

When using Docker (optional):

- Don't run containers as root unless necessary
- Use specific image tags, not `latest`
- Scan images for vulnerabilities periodically