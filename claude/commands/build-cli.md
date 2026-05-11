# Build CLI Command

You are building a CLI that works well for both humans and agents. Follow these principles strictly when designing and implementing CLI commands.

## Input

The user will describe what their CLI should do. They may provide:
- A description of the domain and operations
- Existing API endpoints or data models
- Specific commands they want

If $ARGUMENTS is provided, treat it as the task description.

## CLI Design Principles

### 1. Command Naming

- Name commands around **user tasks**, not internal API operations
- Use `verb-noun` or `noun verb` patterns consistently (pick one, don't mix)
- Common workflows should require minimal flags
- Group related commands under a shared namespace

### 2. Output Modes

Every command that produces output MUST support:

- **Table output** (default) — human-readable, aligned columns
- **JSON output** (`--output=json` or `-o json`) — machine-readable, stable schema
- **`--fields`** flag to select specific fields in both table and JSON modes
- **`--quiet` / `-q`** — minimal output (e.g., just IDs), useful for piping

Output schema must be stable across versions. Adding fields is fine; renaming or removing fields is a breaking change.

### 3. Schema Introspection

Every command group MUST have a `schema` subcommand that returns:

```json
{
  "command": "resource list",
  "description": "List resources with optional filters",
  "flags": {
    "--status": { "type": "string", "enum": ["active", "archived"], "default": "active" },
    "--limit": { "type": "integer", "default": 50 }
  },
  "output_fields": ["id", "name", "status", "created_at"],
  "examples": [
    "cli resource list --status=active --output=json",
    "cli resource list --fields=id,name"
  ]
}
```

This lets agents inspect the CLI contract at runtime without parsing `--help` text.

### 4. Dry Run

Commands that **write, mutate, or have side effects** MUST support `--dry-run`:

- Print the normalized request plan (what would be done) without executing
- Output should be valid JSON when combined with `--output=json`
- Dry run must NOT make network calls or state changes

Read-only commands do not need `--dry-run`.

### 5. Input Validation

- Validate all inputs **before** execution, not during
- Use typed flags (enum, integer, boolean) — don't accept arbitrary strings where a finite set exists
- Provide clear, actionable error messages: say what was wrong AND what is expected
- Prefer explicit flags over positional argument overloading beyond the first argument

### 6. Error Handling

- Exit codes: `0` success, `1` general error, `2` usage error (bad input/flags)
- Errors in JSON mode must still be valid JSON: `{"error": "message", "code": "ERROR_CODE"}`
- Never print stack traces in production mode — log them to stderr or a debug file
- Include a `--verbose` / `-v` flag for diagnostic output on stderr

### 7. Discoverability

- `--help` on every command and subcommand with usage examples
- Top-level `help` command that lists all command groups
- Consider a `discover` command for CLIs that wrap APIs, to show available endpoints not yet promoted to typed commands

### 8. Safety Rules for Write Commands

Write commands (create, update, delete) should:

- Require explicit confirmation for destructive operations (or `--yes` / `-y` to skip)
- Support `--dry-run` (see above)
- Log what was changed to stdout
- Return the affected resource in the output

### 9. Standard Global Flags

Every CLI should support these global flags:

| Flag | Short | Purpose |
|------|-------|---------|
| `--output` | `-o` | Output format: `table`, `json` |
| `--fields` | | Comma-separated field list |
| `--quiet` | `-q` | Minimal output |
| `--verbose` | `-v` | Debug output on stderr |
| `--dry-run` | | Show plan without executing |
| `--yes` | `-y` | Skip confirmation prompts |
| `--help` | `-h` | Show help |

### 10. Configuration

- Support config via file (`~/.config/cli-name/config.toml` or similar), env vars, and flags
- Precedence: flags > env vars > config file > defaults
- Provide a `config show` command to display resolved configuration
- Provide a `config set` command for common settings

## Implementation Approach

When building the CLI:

1. **Start with the command tree** — define all commands and their flags before writing implementation
2. **Implement the output layer first** — table/JSON formatting, error formatting, field selection
3. **Add schema generation** — derive from the command definitions, not hand-maintained
4. **Build commands** — using the shared output and validation infrastructure
5. **Add dry-run** — for all write commands
6. **Write integration tests** — test both human-readable and JSON output modes

## Technology Preferences

- Ask the user what language/framework they prefer if not obvious from context
- For TypeScript: consider `commander`, `yargs`, or `oclif`
- For Go: consider `cobra` + `pflag`
- For Python: consider `click` or `typer`
- For Rust: consider `clap`

## What NOT to Do

- Don't add hidden magic or implicit behavior that differs between runs
- Don't parse free-text where structured input is possible
- Don't change output format based on whether stdout is a TTY (unless the user explicitly opts into this)
- Don't require interactive input — every interactive prompt must have a flag equivalent
- Don't build features "just in case" — promote from real usage via `discover` patterns
