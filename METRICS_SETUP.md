# 📊 GitHub Metrics Setup Guide

## 🎯 Overview

This repository now includes a comprehensive GitHub metrics setup using the [lowlighter/metrics](https://github.com/lowlighter/metrics) action, integrated as a git submodule for version control and easy updates.

## 🔧 Submodule Management

### Initial Setup (Already Done)
```bash
git submodule add https://github.com/lowlighter/metrics.git metrics
```

### Updating the Metrics Repository
```bash
# Update to latest version
git submodule update --remote metrics

# Commit the update
git add metrics
git commit -m "🔄 Update metrics submodule to latest version"
```

### Cloning This Repository
```bash
# Clone with submodules
git clone --recurse-submodules https://github.com/kzndotsh/kzndotsh.git

# Or if already cloned
git submodule update --init --recursive
```

## 🚀 Workflow Configuration

The GitHub Actions workflow (`.github/workflows/metrics.yml`) is configured with:

### ⚙️ Core Features
- **Daily Updates**: Runs at 2 AM UTC
- **Manual Triggers**: Can be run manually or on push
- **Smart Updates**: Only commits when data changes
- **Performance Optimized**: SVG optimization and caching

### 🎨 Enabled Plugins (20+)
1. **🏆 Achievements** - GitHub achievements with secrets
2. **📅 Activity Calendar** - Full year commit calendar
3. **🈷️ Languages** - In-depth language analysis
4. **👨‍💻 Lines of Code** - Code statistics across repos
5. **📓 Repositories** - Featured, pinned, starred repos
6. **🌟 Stars** - Recently starred repositories
7. **📌 Topics** - Starred topics with icons
8. **🎩 Notable Contributions** - Contributions to other projects
9. **💡 Coding Habits** - Activity patterns and facts
10. **🎟️ Follow-up** - Issues and PR tracking
11. **🧑‍🤝‍🧑 People** - Followers, following, sponsors
12. **🎭 Reactions** - Comment reactions analysis
13. **🗂️ Projects** - GitHub projects showcase
14. **🎫 Gists** - Gist statistics
15. **🌇 GitHub Skyline** - 3D commit visualization
16. **📰 Recent Activity** - Latest GitHub activity
17. **🧮 Traffic** - Repository traffic stats
18. **♐ Random Code** - Code snippets showcase
19. **🏅 Contributors** - Repository contributors
20. **📜 Licenses** - Repository licenses
21. **💫 Star Lists** - Star lists showcase
22. **🎲 Fortune** - Community fortune plugin

## 🔑 Required Setup

### 1. GitHub Personal Token
Create a personal access token with these scopes:
- `public_repo` (for public repository data)
- `read:org` (for organization data)
- `read:user` (for user data)

### 2. Repository Secret
Add `METRICS_TOKEN` to your repository secrets with your personal access token.

### 3. Enable Private Contributions
In your GitHub profile settings, enable "Include private contributions on my profile" for complete metrics.

## 📈 Customization

### Plugin Configuration
Each plugin can be customized by modifying the workflow file:
- Enable/disable plugins with `plugin_[name]: true/false`
- Configure plugin options with `plugin_[name]_[option]: value`
- Adjust limits, thresholds, and display options

### Template Options
- `classic` - Standard layout (current)
- `terminal` - Terminal-style layout
- `repository` - Repository-focused layout
- `markdown` - Markdown output format

### Display Options
- `config_display: columns` - Multi-column layout
- `config_animations: true` - CSS animations
- `config_twemoji: true` - Twitter emojis
- `config_gemoji: true` - GitHub emojis

## 🎯 Advanced Features

### Indepth Analysis
- `plugin_languages_indepth: true` - Clone and analyze repositories
- `plugin_notable_indepth: true` - Deep contribution analysis
- `plugin_followup_indepth: true` - Detailed issue/PR analysis

### Performance Optimization
- `optimize: true` - SVG optimization
- `verify: true` - SVG validation
- `retries: 3` - Retry failed operations
- `output_condition: data-changed` - Smart updates

### Community Plugins
- `plugin_fortune: true` - Fortune cookies
- Additional community plugins available

## 🔄 Maintenance

### Regular Updates
- Update submodule monthly for latest features
- Monitor workflow runs for any issues
- Adjust plugin configuration as needed

### Troubleshooting
- Check GitHub Actions logs for errors
- Verify token permissions and scopes
- Ensure repository secrets are properly set

## 📚 Resources

- [Metrics Documentation](https://github.com/lowlighter/metrics/blob/master/README.md)
- [Plugin Documentation](https://github.com/lowlighter/metrics/tree/master/source/plugins)
- [Template Documentation](https://github.com/lowlighter/metrics/tree/master/source/templates)
- [Live Configuration Tool](https://metrics.lecoq.io)

---

> 💡 **Pro Tip**: This setup provides the most comprehensive GitHub profile metrics possible with advanced features like indepth analysis, achievement secrets, and community plugins!