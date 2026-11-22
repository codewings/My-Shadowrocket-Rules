> 如需Clash版本 → [请点击此处](https://github.com/LingJingMaster/Clash-Rules)

> **本仓库为个人定制 Fork**：每 4 小时自动同步上游 [LingJingMaster/Shadowrocket-Rules](https://github.com/LingJingMaster/Shadowrocket-Rules) 并叠加 `custom/` 中的自定义规则，详见文末[「本 Fork 的定制机制」](#本-fork-的定制机制)。

---

# 小火箭 Shadowrocket Config

一份开箱即用的 小火箭 Shadowrocket 规则配置
- 支持前沿的苹果智能（Apple Intelligence）
- 在新规下的香港券商访问
- 导入后添加自己的节点或订阅即可使用

## 快速开始

1. 复制配置文件的 Raw 链接：
   `https://raw.githubusercontent.com/LingJingMaster/Shadowrocket-Rules/refs/heads/main/Shadowrocket.conf`
2. 打开 Shadowrocket → 配置 → 右上角 `+` → 粘贴链接 → 下载
3. 点击已下载的配置，设为使用中（✔️）
4. 首页添加你自己的节点或订阅
5. 连通性测试，选择可用节点连接

或者扫描二维码

<img width="200" height="200" alt="ctool-2026-02-26-17-13-16" src="https://github.com/user-attachments/assets/22f1b4f7-3265-493c-9e5a-2b662924ed2f" />

## 分流规则

| 优先级 | 服务 | 默认策略 |
|--------|------|----------|
| 1 | 🧱 DNS 防泄露（HTTPDNS） | REJECT |
| 2 | 📧 邮件服务（IMAP / POP3 / SMTP） | PROXY，可切换 DIRECT 或地区节点 |
| 3 | 🔍 谷歌服务（含 Gemini） | 日本节点，可手动切香港节点 |
| 4 | 🤖 AI 服务（ChatGPT、Claude、苹果智能等） | 美国节点 |
| 5 | 📹 油管视频（含 YouTube 翻译 API） | 节点选择 |
| 6 | 🔒 哔哩哔哩 | DIRECT |
| 7 | 🏠 私有网络 / 局域网 | DIRECT |
| 8 | 📲 电报消息 | 节点选择 |
| 9 | 🐱 代码托管（GitHub、GitLab、Atlassian） | 节点选择 |
| 10 | Ⓜ️ 微软服务 | 节点选择 |
| 11 | 🏦 汇丰香港（含 Reward+） | DIRECT |
| 12 | 🏦 其他香港银行 | DIRECT |
| 13 | 📈 券商服务（富途 / moomoo / 长桥 / 老虎 / 雪盈 / 盈透） | 香港节点 |
| 14 | 🍎 苹果推送 | 节点选择 |
| 15 | 🍏 苹果服务 | DIRECT |
| 16 | 🔒 国内服务 | DIRECT |
| 17 | 🌍 非中国（境外流量） | PROXY |
| 18 | GEOIP CN | DIRECT |
| 19 | 🐟 漏网之鱼（兜底） | PROXY |


## 默认策略

| 服务 | 默认策略 | 可选策略 |
|------|----------|----------|
| 🧱 DNS 防泄露 | REJECT | 节点选择、DIRECT |
| 📧 邮件服务 | PROXY | DIRECT、节点选择、日本节点、香港节点 |
| 🔍 谷歌服务 | 🇯🇵 日本节点 | 🇭🇰 香港节点、节点选择、PROXY、DIRECT |
| 🤖 AI 服务 | 🇺🇸 美国节点 | 节点选择、PROXY、DIRECT |
| 🍎 苹果推送 | 🚀 节点选择 | PROXY、DIRECT |
| 🍏 苹果服务 | DIRECT | 节点选择、PROXY |
| 🏦 汇丰香港 | DIRECT | 🇭🇰 香港节点、节点选择、PROXY |
| 🏦 香港银行 | DIRECT | 香港节点、节点选择、PROXY |
| 📈 券商服务 | 🇭🇰 香港节点 | DIRECT、节点选择、PROXY |
| 🌍 非中国 | PROXY | 节点选择、DIRECT、日本节点 |
| 🐟 漏网之鱼 | PROXY | 节点选择、DIRECT、日本节点 |







## 规则集来源

- [blackmatrix7/ios_rule_script](https://github.com/blackmatrix7/ios_rule_script) — 主要规则集
- [iab0x00/ProxyRules](https://github.com/iab0x00/ProxyRules) — AI 服务补充规则
- `Mail.list` 收录 Apple、Gmail、Outlook、Yahoo、Yandex 的邮件协议端点
- `Apple.list` 基于 blackmatrix7 Apple 规则，并配套加载 `Apple_Domain.list`，补充 iCloud Photos / Apple CDN 直连域名
- `HK_Broker.list` 补充富途 / moomoo / 长桥 / 老虎 / 雪盈 / 盈透 / TradeUP / Schwab 证券域名及交易 IP 段
- `HSBC_HK.list` 与 `HK_Banks_Direct.list` 收录香港银行网站及 App 服务域名

## Star History

[![Star History Chart](https://api.star-history.com/chart?repos=lingjingmaster/shadowrocket-rules&type=date&legend=top-left)](https://www.star-history.com/?repos=lingjingmaster%2Fshadowrocket-rules&type=date&legend=top-left)

## License

MIT

---

# 本 Fork 的定制机制

本仓库 = **上游镜像 + 自定义叠加层**。GitHub Actions（`.github/workflows/sync-upstream.yml`）每 4 小时执行一次，也可在 Actions 页面手动 Run workflow：

```
同步上游全部文件 → 叠加 custom/ 中的自定义规则 → 有变化才提交推送
```

自己使用时请订阅本仓库的配置地址：
`https://raw.githubusercontent.com/codewings/My-Shadowrocket-Rules/refs/heads/main/Shadowrocket.conf`

## 如何添加自定义规则

所有个人改动只放在 `custom/` 目录（详见 [custom/README.md](custom/README.md)），**不要直接修改根目录的规则文件**——它们每次同步都会被上游版本强制覆盖。

**方式一：覆盖上游规则 → `custom/Shadowrocket.conf.rules`**

每行一条完整的 `[Rule]` 规则（含策略），会被插入 `Shadowrocket.conf` 的 `[Rule]` 段**最顶部**。Shadowrocket 自上而下匹配、命中即停，因此这里的规则**优先级高于上游所有规则**——即使上游将来加入同域名的规则，也会因排在后面而永远不被命中（被"遮蔽"而非删除）。

```
DOMAIN-SUFFIX,device-link.cindy.app,DIRECT
DOMAIN-KEYWORD,github,🚀 节点选择
```

**方式二：给规则集补充条目 → `custom/<名称>.list`**

与根目录 `.list` 同名的文件，内容会追加到该文件末尾，策略跟随该规则集在 conf 中 `RULE-SET` 行定义的策略。注意这种方式**不保证覆盖**：若同一域名命中了 conf 中更靠前的规则或规则集，先命中者获胜。需要"覆盖"语义时请用方式一。

也可以创建全新的规则集（如 `custom/MyExtra.list`，同步后根目录会生成同名文件），再在方式一中用 `RULE-SET` 引用它。

## 工程设计决策

| 决策 | 理由 |
|------|------|
| **强制镜像同步而非 `git merge`** | 根目录规则文件被提交为「上游内容 + 叠加层」，与上游存在双向差异；用 merge 会在上游改动与叠加内容重叠时（典型如在文件末尾追加规则）反复产生冲突。改为每次从 `upstream/main` 强制 checkout 上游文件再重新叠加，根目录文件永远是确定性产物，**零冲突** |
| **上游 URL 重写为 Fork 地址** | 上游 conf 中所有 `RULE-SET` / `update-url` 指向上游 raw 地址；不重写的话 Shadowrocket 实际加载的仍是上游的 `.list`，`custom/` 中的追加条目永远不会生效。同步时自动把 `LingJingMaster/Shadowrocket-Rules` 替换为 `codewings/My-Shadowrocket-Rules` |
| **标记块 + 幂等脚本** | 叠加内容用 `BEGIN/END custom rules` 注释标记包裹；`scripts/apply-custom-rules.sh` 每次先剥离旧标记块再重新插入（含标记块前后空行），重复执行结果完全一致，不会累积重复规则 |
| **受保护路径** | `custom/`、`scripts/`、`.github/`、`README.md` 永不被上游覆盖（前三个不在上游仓库中，README 保护是为了保留本说明文档）；上游删除的文件会被同步删除，但由 `custom/*.list` 生成的根目录文件除外 |
| **规则插入在 `[Rule]` 最顶部** | 而非 `FINAL` 之前或各 `RULE-SET` 之间：顶部位置提供无条件最高优先级，实现真正的"覆盖"语义；实现上也最简单——不依赖对上游规则结构的任何假设 |
| **无变化不提交** | 定时任务在上游无更新且 `custom/` 无改动时产生空 diff，直接跳过提交，不污染历史；有变化时以 `chore(sync): upstream@<sha> + apply custom rules` 单提交记录每次同步 |
| **本地可复现** | 同步与叠加都是纯 bash 脚本（`scripts/sync-upstream.sh` + `scripts/apply-custom-rules.sh`），可在本地 clone 中以与 CI 完全相同的方式执行和验证 |
