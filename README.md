# Claude Skills

A collection of Claude Code skills for design, development, and creative work.

## Skills

| Skill | Description |
|-------|-------------|
| [ios-frontend-design](skills/ios-frontend-design/) | Design and build distinctive, production-grade iOS interfaces in SwiftUI. An opinionated creative director that rejects generic AI aesthetics. |

## Installation

### Claude Code (recommended)

```bash
# Install all skills
/install-skill lisovet/claude-skills/skills/ios-frontend-design

# Or manually:
git clone https://github.com/lisovet/claude-skills.git /tmp/claude-skills
cp -r /tmp/claude-skills/skills/ios-frontend-design ~/.claude/skills/
```

### Manual

Copy the skill folder into your Claude Code skills directory:

```bash
mkdir -p ~/.claude/skills/ios-frontend-design
curl -o ~/.claude/skills/ios-frontend-design/SKILL.md \
  https://raw.githubusercontent.com/lisovet/claude-skills/main/skills/ios-frontend-design/SKILL.md
```

### Verify installation

After installing, the skill should appear when you run Claude Code. You can invoke it directly with `/ios-frontend-design` or it will activate automatically when you ask Claude to build iOS UI.

## Adding new skills

Each skill lives in its own folder under `skills/`:

```
skills/
  ios-frontend-design/
    SKILL.md
  another-skill/
    SKILL.md
```

A skill needs only a `SKILL.md` file with YAML frontmatter (`name`, `description`, `license`) followed by the skill instructions in Markdown.

## License

MIT
