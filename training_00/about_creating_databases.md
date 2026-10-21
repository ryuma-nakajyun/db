# DB作成
DBを作成していないなら、
```sql
CREATE DATABASE gisdb;
```

PostgreSQLでDBを切り替える場合は、作成後
```bash
\c gisdb
```
で接続できます。

テーブル作成後は
```bash
\dt
```
で存在確認できます。

現在 psql に接続中なら、
```bash
\l
```
でDB一覧を確認して、
```bash
\c DB名
```
で切り替えます。

例えば先ほど作成した gisdb に切り替えるなら、
```bash
\c gisdb
```
成功すると、
```text
You are now connected to database "gisdb" as user "postgres".  
```
と表示されます。  

現在接続中のDBを確認するには、
```sql
SELECT current_database();
```
または
```bash
\conninfo
```
を実行します。

### memo
---
- 省略コマンドの正式名称(関連記憶のためmust)
- 省略コマンドの
- 
