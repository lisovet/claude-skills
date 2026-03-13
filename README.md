# Claude Skills

A collection of Claude Code skills for design, development, and creative work.

## Skills

| Skill | Description |
|-------|-------------|
| [ios-frontend-design](skills/ios-frontend-design/) | Design and build distinctive, production-grade iOS interfaces in SwiftUI. An opinionated creative director that rejects generic AI aesthetics. |
| [image-prompt](skills/image-prompt/) | Generate optimized prompts for Google's Nano Banana image generators (Nano Banana 2 and Nano Banana Pro). Based on official Google prompting guidance. |
| [ad-creator](skills/ad-creator/) | Generate ad images using Nano Banana (Gemini). Includes a Python generation script, 40 DTC ad templates, and an interactive prompt-crafting workflow. |

## Installation

### Claude Code (recommended)

```bash
# Install a specific skill
/install-skill lisovet/claude-skills/skills/ios-frontend-design
/install-skill lisovet/claude-skills/skills/image-prompt
/install-skill lisovet/claude-skills/skills/ad-creator

# Or manually:
git clone https://github.com/lisovet/claude-skills.git /tmp/claude-skills
cp -r /tmp/claude-skills/skills/<skill-name> ~/.claude/skills/
```

### Manual

Copy the skill folder into your Claude Code skills directory:

```bash
# Example: ios-frontend-design
mkdir -p ~/.claude/skills/ios-frontend-design
curl -o ~/.claude/skills/ios-frontend-design/SKILL.md \
  https://raw.githubusercontent.com/lisovet/claude-skills/main/skills/ios-frontend-design/SKILL.md

# Example: image-prompt
mkdir -p ~/.claude/skills/image-prompt
curl -o ~/.claude/skills/image-prompt/SKILL.md \
  https://raw.githubusercontent.com/lisovet/claude-skills/main/skills/image-prompt/SKILL.md
```

### Verify installation

After installing, the skill should appear when you run Claude Code. Invoke directly with `/<skill-name>` or let it activate automatically based on context.

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
