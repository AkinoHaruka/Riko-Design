# Riko Design Skills & Agent Guidelines

> **Target Audience**: 任何负责本项目 UI/前端/设计实现的 AI Coding Agent。
> **核心原则**: 当你阅读此文件时，你必须严格遵循下方明确的参考源、颜色规范、字体配置、动效物理学以及工艺标准，不得擅自偏离或引入未经允许的设计系统。

---

## 1. 规范参考源与项目依赖路由 (Reference Routing)

在进行任何设计、样式编写与组件重构时，根据具体需求直接查阅工作区内的对应资源：

```
./
├── Riko-design-skills.md             # [当前文件] Agent 全局设计总则与查阅索引
├── styles/
│   └── design-tokens.css             # 可直接引入的 CSS 变量与 WebFont 链接
├── specs/
│   ├── mastercard/DESIGN.md          # 色彩体系、画布质感、轨道药丸几何核心参考
│   └── claude/DESIGN.md              # 排版节奏、层级权重、间距比例核心参考
├── emilkowalski-skills/              # 动效工程与微交互技能库
│   └── skills/
│       ├── animate/                  # 动画基本实现范式
│       ├── animation-vocabulary/     # 动效术语与物理直觉
│       ├── apple-design/             # 苹果风格精致微交互
│       ├── emil-design-eng/          # 设计工程师实战守则
│       └── improve-animations/       # 动效打磨与性能优化
└── apple-design-skill/               # Apple HIG 顶级工艺与设计规范
    ├── SKILL.md                      # Apple 规范综述（44pt触控、材质层级、排版）
    └── references/                   # 详细规范引用与视觉指标
```

`specs/mastercard/DESIGN.md` 与 `specs/claude/DESIGN.md` 是从 [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md) 复制的设计规范快照，精确来源提交与许可证见 [README.md](README.md)。

---

## 2. 颜色体系 (Color System - 严格源自 Mastercard)

所有背景、文字与强调色必须使用以下 Token，**严禁将整个页面背景设为纯白 `#FFFFFF`**。

### 2.1 基础色板速查

| 语义角色 | 色值 (HEX) | CSS 变量 | 用途说明 |
| :--- | :--- | :--- | :--- |
| **Canvas Cream** | `#F3F0EE` | `--color-canvas` | **全局页面默认背景底色**（暖调腻子奶油色，营造杂志刊物感） |
| **Lifted Cream** | `#FCFBFA` | `--color-surface-lifted` | 纸上叠纸效果、模块嵌套浮动区域 |
| **Surface Card** | `#FFFFFF` | `--color-surface-card` | **仅限**卡片、悬浮药丸导航条、次级按钮与卫星微图标底色 |
| **Surface Dark** | `#141413` | `--color-surface-dark` | 深色展示块、代码区、页脚背景 |
| **Ink Primary** | `#141413` | `--color-ink-primary` | **主标题与正文颜色**、主行动按钮背景（带蓝温墨黑） |
| **Ink Strong** | `#252523` | `--color-ink-strong` | 强强调文字、深色卡片内文本 |
| **Ink Slate** | `#696969` | `--color-ink-slate` | 次级辅助文字、弱化描述、禁用状态 |
| **Ink Taupe** | `#D1CDC7` | `--color-ink-taupe` | 极浅辅助文字、空状态占位、输入框 Placeholder |
| **Signal Orange** | `#CF4500` | `--color-signal-orange` | **关键信号点缀**（强调警示、分类小圆点，**严禁大面积滥用**） |
| **Light Orange** | `#F37338` | `--color-orange-light` | 轨道线弧光、轮播激活条、高亮引线 |
| **Clay Brown** | `#9A3A0A` | `--color-clay-brown` | 暖棕色次级辅助引导链接 |
| **Link Blue** | `#3860BE` | `--color-link-blue` | 行内超链接、信息类提示 |
| **Subtle Border** | `rgba(20,20,19,0.08)` | `--color-border-subtle` | 极细次像素微边框（Apple HIG 质感） |

### 2.2 按钮色彩规则
- **Primary 按钮**: 背景 `#141413`，文字 `#F3F0EE`（奶油色字，绝非纯白），圆角 `9999px` 或 `20px`。
- **Secondary 按钮**: 背景 `#FFFFFF`，文字 `#141413`，边框 `1.5px solid rgba(20,20,19,0.16)`。
- **Signal 按钮**: 仅用于核心确认或重要警示节点，背景 `#CF4500`，文字 `#FFFFFF`。

---

## 3. 字体排版体系 (Typography - Claude 层级 × 开源西文 × MiSans)

排版规格继承自 Claude DESIGN.md，字体替换为**免版权商用开源西文字体**与**小米开源商用中文字体 MiSans**。

### 3.1 字体家族栈 (Font Stacks)

```css
/* 1. 展示大标题 (Display / Serif) */
font-family: 'Cormorant Garamond', 'EB Garamond', 'MiSans', serif;

/* 2. 界面与正文 (Body & Sans / UI) */
font-family: 'Inter', 'MiSans', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;

/* 3. 代码与等宽数据 (Monospace / Code) */
font-family: 'JetBrains Mono', 'MiSans', ui-monospace, monospace;
```

### 3.2 字体载入 CDN (Agent 编写页面时请直接引入)

```html
<!-- Google Fonts: Cormorant Garamond, Inter, JetBrains Mono -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Inter:wght@400;450;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">

<!-- MiSans (小米自研开源商用中文字体) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/misans@4.0.0/lib/misans-normal.min.css">
```

### 3.3 字阶与版式比例对照表

| 角色 Token | 字体家族 | 字号 | 字重 | 行高 | 字距 (Tracking) | 适用场景 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `display-xl` | Cormorant Garamond + MiSans | 64px | 500 / 600 | 1.05 | -1.5px (-2%) | 核心 Hero 头条 |
| `display-lg` | Cormorant Garamond + MiSans | 48px | 500 | 1.10 | -1.0px | 模块大标题 |
| `display-md` | Cormorant Garamond + MiSans | 36px | 500 | 1.15 | -0.5px | 区块主要标题 |
| `display-sm` | Cormorant Garamond + MiSans | 28px | 500 | 1.20 | -0.3px | 区域副标题 |
| `title-lg` | Inter + MiSans | 22px | 600 | 1.30 | 0 | 大卡片标题 |
| `title-md` | Inter + MiSans | 18px | 600 | 1.40 | 0 | 中型卡片 / 对话框标头 |
| `title-sm` | Inter + MiSans | 16px | 600 | 1.40 | 0 | 列表头 / 项目摘要 |
| `body-md` | Inter + MiSans | 16px | 450 (或 400) | 1.55 | 0 | **默认主体正文** |
| `body-sm` | Inter + MiSans | 14px | 450 (或 400) | 1.55 | 0 | 次要正文、表格正文 |
| `caption` | Inter + MiSans | 13px | 500 | 1.40 | 0 | 辅助注释、元数据 |
| `eyebrow` | Inter + MiSans | 14px | 700 | 1.00 | +0.56px (+4%) | 模块分类眉标（前置小圆点） |
| `button` | Inter + MiSans | 14~16px | 500 | 1.00 | -0.32px | 胶囊按钮文案 |
| `code` | JetBrains Mono | 14px | 400 | 1.60 | 0 | 代码块与等宽数据展示 |

---

## 4. 几何、圆角与布局形态 (Mastercard Orbital & Pill)

- **超大圆角与药丸形优先**:
  - 按钮与标签: `border-radius: 9999px` (Pill) 或 `20px`。
  - 大型媒体展示区: `border-radius: 40px` (Stadium 体育场形态)。
  - 内容卡片: `border-radius: 16px ~ 24px`。
- **卫星式微型操作 (Satellite CTA)**:
  - 位于圆形图或卡片右下角的微型圆形按钮（`border-radius: 50%`，尺寸 44px~56px），背景纯白，墨黑箭头，停靠在主体边缘。
- **动态轨道线条 (Orbital Arc)**:
  - 装饰性引导线使用轻信号橙 `#F37338`，粗细 1px~1.5px，呈大圆弧形贯穿页面，营造星座轨迹感。

---

## 5. 动效与微交互准则 (Emil Kowalski Skills)

Agent 编写任何动效、过渡或手势交互时，必须遵守 `emilkowalski-skills/` 中的工程实践：

1. **采用物理弹簧 (Springs Over Easing)**:
   - 按钮反馈与轻度交互: `{ type: "spring", stiffness: 400, damping: 28 }`
   - 模态弹窗与抽屉展开: `{ type: "spring", stiffness: 300, damping: 30 }`
   - 手势滑动或甩动关闭: `{ type: "spring", stiffness: 260, damping: 20 }`
2. **触感反馈 (Press Feedback)**:
   - 任何可点击按钮/卡片按下时具备微缩放：
     ```css
     .pressable:active {
       transform: scale(0.97);
       transition: transform 120ms cubic-bezier(0.2, 0, 0, 1);
     }
     ```
3. **性能红线 (Compositor-Only)**:
   - 动画过程中只操作 `transform` 与 `opacity`。严禁在高频动画中实时修改 `width`, `height`, `margin`, `top`, `left`。
4. **布局连续性 (FLIP & layoutId)**:
   - Tab 切换指示块、筛选器高亮胶囊等状态移动必须使用布局过渡保持空间连续性。

---

## 6. 苹果设计哲学与工艺标准 (Apple Design Skill)

Agent 在处理组件排版、层次与细节时，必须参考 `apple-design-skill/`：

1. **44pt 触控热区准则**: 任何交互元素的点击/触控判定区域不得小于 44px × 44px。
2. **次像素发丝线 (Hairline Borders)**: 悬浮卡片与弹窗边缘添加 `1px solid rgba(20, 20, 19, 0.08)`，防止在复杂背景上糊化。
3. **漫反射阴影 (Diffuse Shadows)**:
   - 卡片微浮动: `box-shadow: 0 4px 12px rgba(20, 20, 19, 0.05)`
   - 浮动导航 / 模态框: `box-shadow: 0 12px 32px rgba(20, 20, 19, 0.08), 0 2px 6px rgba(20, 20, 19, 0.04)`
4. **无障碍 (Accessibility / a11y)**:
   - 确保奶油底色 `#F3F0EE` 上的文字对比度达到 WCAG AA（对比度 4.5:1 以上）。
   - 墨黑 `#141413` 与正文 `#3D3D3A` 均具备高对比度。

---

## 7. Agent 审查与交付检查清单 (Delivery Checklist)

在输出任何 UI 代码或页面之前，Agent 必须对照自检：

- [ ] **背景色检查**: 页面主背景是否为 `--color-canvas` (`#F3F0EE`) 而非死白？
- [ ] **字体匹配**: 大标题是否使用 `Cormorant Garamond`？正文是否使用 `Inter` + `MiSans`？代码是否使用 `JetBrains Mono`？
- [ ] **中文适配**: 中文字体首选是否配置为 `MiSans`？
- [ ] **圆角与几何**: 按钮是否呈胶囊状（Pill / 20px+）？大幅模块是否具备 40px 圆角？
- [ ] **按压反馈**: 交互按钮是否包含 `:active` 缩放或弹簧反馈？
- [ ] **触控热区**: 触控点击区域是否达到 44px 最小尺寸？
- [ ] **色彩克制**: 信号橙 `#CF4500` 是否仅用于点缀与关键节点，未泛滥成灾？
