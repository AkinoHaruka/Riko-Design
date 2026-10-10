# Riko Design

跨平台产品界面的设计参考与 CSS token 集合，整合暖色画布、清晰的排版层级、开源字体、轻量动效和 Apple Human Interface Guidelines（HIG）工艺参考。

## 项目内容

| 路径 | 内容 |
| --- | --- |
| [`Riko-design-skills.md`](Riko-design-skills.md) | 完整设计规范、Agent 实施指引与交付自检清单 |
| [`styles/design-tokens.css`](styles/design-tokens.css) | CSS 色彩、字体、圆角、阴影、动效和按钮基础样式 |
| [`design-md/mastercard/DESIGN.md`](design-md/mastercard/DESIGN.md) | Mastercard 设计参考：色彩、画布质感与几何形态 |
| [`design-md/claude/DESIGN.md`](design-md/claude/DESIGN.md) | Claude 设计参考：排版层级与版式比例 |
| [`design-md/UPSTREAM.md`](design-md/UPSTREAM.md) | 两份规范对应的上游提交号、文件来源与许可证 |
| [`scripts/sync-design-md.ps1`](scripts/sync-design-md.ps1) | 从 VoltAgent 同步这两份 `DESIGN.md` 的脚本 |
| [`emilkowalski-skills/`](https://github.com/emilkowalski/skills) | Emil Kowalski 的动效与设计工程技能，上游 Git 子模块 |
| [`apple-design-skill/`](https://github.com/dickwu/apple-design-skill) | Apple HIG 设计参考，上游 Git 子模块 |

## 快速使用

在网页项目中引入设计 token：

```css
@import url("./styles/design-tokens.css");
```

样式表会从 Google Fonts 和 jsDelivr 加载字体。项目默认使用 Cormorant Garamond、Inter、JetBrains Mono 与 MiSans 字体栈；请根据目标平台和网络环境调整字体加载方式。

从 VoltAgent 更新设计规范时运行：

```powershell
pwsh -File ./scripts/sync-design-md.ps1
```

脚本解析上游 `main` 到具体提交，并且只下载 Mastercard 与 Claude 两个 `DESIGN.md` 文件；同步版本记录在 [`design-md/UPSTREAM.md`](design-md/UPSTREAM.md)。

克隆项目时一并获取上游子模块：

```bash
git clone --recurse-submodules https://github.com/AkinoHaruka/Riko-Design.git
```

## 设计基线

- **画布与文字**：Canvas Cream `#F3F0EE`、Ink Black `#141413`。
- **强调色**：Signal Orange `#CF4500`，用于少量关键提示。
- **形态**：药丸按钮使用 `9999px` 圆角，媒体容器使用 `40px` 圆角。
- **动效**：优先使用 `transform` 和 `opacity`；按钮按压缩放为 `scale(0.97)`。
- **交互**：触控目标以至少 `44pt` 为基线，并检查键盘、对比度和辅助技术体验。

完整色板、字体层级、间距、组件示例与交付清单请见 [`Riko-design-skills.md`](Riko-design-skills.md)。

## 上游来源与素材说明

- **Mastercard 与 Claude 设计规范**：[`design-md/mastercard/DESIGN.md`](design-md/mastercard/DESIGN.md) 和 [`design-md/claude/DESIGN.md`](design-md/claude/DESIGN.md) 从 [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md) 同步。运行同步脚本时会解析上游分支到不可变提交，并且只下载这两个文件；当前版本见 [`design-md/UPSTREAM.md`](design-md/UPSTREAM.md)。来源仓库采用 MIT License。其品牌说明页将在线版本指向 [getdesign.md / Mastercard](https://getdesign.md/mastercard/design-md) 和 [getdesign.md / Claude](https://getdesign.md/claude/design-md)。
- [Emil Kowalski / skills](https://github.com/emilkowalski/skills)：弹簧动效、微交互与动画工程实践。
- [Dick Wu / apple-design-skill](https://github.com/dickwu/apple-design-skill)：Apple HIG 摘要与设计审查参考。

Emil 与 Apple 参考仓库以 Git 子模块固定在各自版本；VoltAgent 规范仅同步到 `design-md/<brand>/`。根目录尚未声明覆盖整份合集的统一许可证；上游许可与原始来源说明应随各自材料一并遵守。

## Agent 协作流程

1. 开始设计或编码前阅读 [`Riko-design-skills.md`](Riko-design-skills.md)。
2. 色彩与几何查阅 `design-md/mastercard/DESIGN.md`；排版查阅 `design-md/claude/DESIGN.md`。
3. 动效查阅 `emilkowalski-skills/skills/`；Apple 平台工艺查阅 `apple-design-skill/SKILL.md`。
4. 优先复用 `styles/design-tokens.css`，交付前完成规范文档第 7 节的自检。
