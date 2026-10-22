# 日付
### CURRENT_DATEの取得までの流れ
---
```text
DBの時刻は、DBサーバのOS時刻
 ↓
DBが参照
 ↓
CURRENT_DATE
CURRENT_TIMESTAMP
```

- OSの時刻確認
  - Linux
  - Shell
  - date

- 現在日時
```bash
date '+%Y-%m-%d %H:%M:%S'
```

- ミリ秒付き
```bash
date '+%Y-%m-%d %H:%M:%S.%3N'
```

### 関連コマンドなど
- タイムゾーン確認
```bash
timedatectl
```

- NTP同期状態確認
```bash
timedatectl status
```

### 参考
---
- AI先生
- 書籍たち

### memo
---
- 
- 
- 
