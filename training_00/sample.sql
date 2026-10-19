-- サンプルsql
-- DBの時刻は
-- DBサーバのOS時刻
-- ↓
-- DBが参照
-- ↓
-- CURRENT_DATE
-- CURRENT_TIMESTAMP
SELECT CURRENT_DATE;

-- OSの時刻確認
-- Linux
-- Shell
-- date

-- 現在日時
-- Shell
-- date '+%Y-%m-%d %H:%M:%S'

-- ミリ秒付き
-- Shell
-- date '+%Y-%m-%d %H:%M:%S.%3N'

-- タイムゾーン確認
-- Shell
-- timedatectl

-- NTP同期状態確認
-- Shell
-- timedatectl status
