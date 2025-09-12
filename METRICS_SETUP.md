# 📊 GitHub Metrics Setup

This repository uses [lowlighter/metrics](https://github.com/lowlighter/metrics) to generate beautiful, comprehensive GitHub profile metrics.

## 🚀 What's Included

### Multiple Workflow Configurations

1. **`metrics.yml`** - Standard comprehensive metrics
2. **`metrics-advanced.yml`** - Advanced metrics with all features
3. **`metrics-terminal.yml`** - Terminal-style aesthetic

### 🎯 Features Enabled

- **📅 Isometric Commit Calendar** - Full year 3D visualization
- **🈷️ Language Analysis** - Indepth analysis with recent activity
- **👨‍💻 Lines of Code** - Productivity metrics
- **📰 Recent Activity** - Latest contributions
- **📓 Featured Repositories** - Showcase your best work
- **🏆 Achievements** - GitHub badges and accomplishments
- **🎩 Notable Contributions** - Impact across projects
- **📌 Topics** - Technologies you work with
- **🌟 Recently Starred** - Learning and interests
- **🌇 GitHub Skyline** - 3D contribution visualization
- **💡 Coding Habits** - Patterns and statistics
- **🎟️ Follow-up** - Issue and PR management
- **🧑‍🤝‍🧑 People** - Network connections
- **💬 Discussions** - Community engagement
- **🗂️ Projects** - Project management
- **🎫 Gists** - Code snippets
- **♐ Code Snippets** - Random code from your repos
- **🧮 Repository Traffic** - Page views and visitor analytics
- **⏰ WakaTime** - Coding time tracking and productivity analytics

## 🔧 Setup Instructions

### 1. GitHub Token Setup

You'll need a GitHub Personal Access Token with the following scopes:
- `repo` (for private repositories)
- `read:org` (for organization data)
- `read:user` (for user data)

### 2. Repository Secrets

Add your token as a repository secret:
- Go to Settings → Secrets and variables → Actions
- Add new secret: `GITHUB_TOKEN`
- Paste your personal access token

### 3. Optional: Additional Services

For even more features, you can add:

#### WakaTime Integration
```yaml
plugin_wakatime: yes
plugin_wakatime_token: ${{ secrets.WAKATIME_TOKEN }}
plugin_wakatime_sections: time,projects,projects-graphs,languages,languages-graphs,editors,os
plugin_wakatime_days: 30
plugin_wakatime_limit: 8
```

**Setup Steps:**
1. Create a [WakaTime account](https://wakatime.com)
2. Get your API key from [Account Settings](https://wakatime.com/settings/account)
3. Add it as a repository secret: `WAKATIME_TOKEN`
4. Install [WakaTime plugins](https://wakatime.com/plugins) for your editors

#### Repository Traffic Analytics
```yaml
plugin_traffic: yes
plugin_traffic_skipped: repo1,repo2  # Optional: skip specific repos
```

**Features:**
- Page views across your repositories
- Visitor analytics and trends
- Shows which projects get the most attention
- Requires `repo` scope in your GitHub token

#### Stack Overflow Stats
```yaml
plugin_stackoverflow: yes
plugin_stackoverflow_user: your-stackoverflow-id
```

#### LeetCode Stats
```yaml
plugin_leetcode: yes
plugin_leetcode_user: your-leetcode-username
```

## 🎨 Customization

### Templates
- **Classic**: GitHub-style design (default)
- **Terminal**: SSH session aesthetic
- **Repository**: Repository-focused view
- **Markdown**: Documentation style

### Colors and Styling
```yaml
plugin_languages_colors: rainbow  # Predefined color sets
config_animations: yes           # CSS animations
config_display: large            # Size options
```

### Language Customization
```yaml
plugin_languages_ignored: html, css, dockerfile  # Hide languages
plugin_languages_aliases: javascript:JS, typescript:TS  # Custom names
plugin_languages_threshold: 1%  # Minimum percentage to show
```

## 📈 Metrics Update Schedule

- **Standard**: Every 6 hours
- **Advanced**: Daily at 2 AM UTC
- **Terminal**: Every 12 hours

## 🔄 Automatic Updates

The workflows automatically:
- ✅ Commit changes only when data changes
- ✅ Use descriptive commit messages
- ✅ Handle API rate limits gracefully
- ✅ Retry on failures
- ✅ Optimize SVG output

## 📈 Analytics Features

### 🧮 Repository Traffic
- **Page Views**: Track how many people visit your repositories
- **Visitor Analytics**: See which projects get the most attention
- **Trend Analysis**: Monitor traffic patterns over time
- **Public Insights**: Showcase your most popular work

### ⏰ WakaTime Integration
- **Coding Time**: Track total time spent coding
- **Language Breakdown**: See which languages you use most
- **Editor Usage**: Monitor your development environment preferences
- **Project Focus**: Track time spent on different projects
- **Operating System**: See your development platform usage
- **Daily Patterns**: Understand your coding habits and productivity

## 🎯 Pro Tips

1. **Indepth Language Analysis**: Uses git clone and linguist analysis for accurate stats
2. **Smart Filtering**: Ignores common non-programming languages
3. **Recent Activity**: Shows your latest contributions
4. **Achievement Tracking**: Displays GitHub accomplishments
5. **3D Visualizations**: GitHub Skyline and isometric calendar
6. **Traffic Analytics**: Monitor repository popularity and engagement
7. **Time Tracking**: Understand your coding patterns and productivity

## 🚨 Important Notes

- **API Limits**: The workflows respect GitHub API rate limits
- **Performance**: Indepth analysis can take longer but provides more accurate data
- **Privacy**: All data stays within GitHub's infrastructure
- **Customization**: Easy to modify colors, languages, and features

## 🔗 Links

- [Metrics Documentation](https://github.com/lowlighter/metrics)
- [Plugin Reference](https://github.com/lowlighter/metrics/blob/master/README.md#-plugins)
- [Template Gallery](https://github.com/lowlighter/metrics/blob/master/README.md#-templates)

---

*Generated with ❤️ using lowlighter/metrics*