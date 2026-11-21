# 自定义规则目录

这个目录存放你自己的规则，**与上游完全解耦**，同步时永远不会被上游覆盖。

GitHub Actions 每 4 小时自动执行一次（也可在 Actions 页面手动 Run workflow）：
同步上游 `LingJingMaster/Shadowrocket-Rules` 的最新改动 → 再把这里的规则覆盖叠加到根目录的规则文件上。

## 两种自定义方式

### 1. 给现有规则集追加条目：`custom/<名称>.list`

文件名与根目录的 `.list` 文件同名，内容会**追加到该文件末尾**。
例如 `custom/AI.list`：

```
# 让 example.ai 走 AI 服务的策略
DOMAIN-SUFFIX,example.ai
```

### 2. 给主配置加完整规则行：`custom/Shadowrocket.conf.rules`

每行是一条完整的 `[Rule]` 规则（含策略），会被插入到
`Shadowrocket.conf` 的 `[Rule]` 段**最顶部**，优先级高于上游所有规则。例如：

```
DOMAIN-SUFFIX,example.com,DIRECT
DOMAIN-KEYWORD,github,🚀 节点选择
```

也可以引用全新的自建规则集（先创建 `custom/MyExtra.list`，同步后根目录会生成同名文件）：

```
RULE-SET,https://raw.githubusercontent.com/codewings/My-Shadowrocket-Rules/main/MyExtra.list,DIRECT
```

## 注意事项

- **不要直接修改根目录的规则文件**（`AI.list`、`Shadowrocket.conf` 等），
  它们会在下次同步时被上游版本强制覆盖；所有改动请放在 `custom/` 里。
- 同步时 `Shadowrocket.conf` 中指向上游的 RULE-SET / update-url 会被自动
  改写为本仓库地址，这样你的自定义规则才能真正生效。
- 受保护不被上游覆盖的路径：`custom/`、`scripts/`、`.github/`、`README.md`。
