# DBを学ぶ
DB（データベース）の基礎基本を、実務で使う順番に整理するとこんな構造になります。

## 項目一覧
- 1. DBとは
- 2. テーブル
- 3. 行（レコード）
- 4. 列（カラム）
- 5. 主キー（PRIMARY KEY）
- 6. 外部キー（FOREIGN KEY）
- 7. CRUD
- 8. SELECT
- 9. WHERE
- 10. ORDER BY
- 11. GROUP BY
- 12. JOIN
- 13. インデックス
- 14. トランザクション
- 15. COMMIT
- 16. ROLLBACK
- 17. 排他制御
- 18. 正規化
- 19. 実務で最低限覚えるSQL
- 20. SQLの基礎基本を理解できたら
- 99. memo

### 1. DBとは 
--- 
データを保存・検索・更新する仕組み。  
例  
顧客管理システム  
| 顧客ID | 名前 |
|--------|------|
| C001   | 山田 |
| C002   | 鈴木 |
これを管理するのがDBです。

- DB製品の代表例
 - Oracle
 - PostgreSQL
 - MySQL
 - SQL Server

### 2. テーブル
---
データを格納する箱。
customer
| customer_id |  customer_name| 
|------|------|
| C001 |  山田| 
| C002 | 鈴木| 
Excelのシートに近いイメージです。

### 3. 行（レコード）
---
1件のデータ。
C001, 山田
これで1レコード。

### 4. 列（カラム）
---
項目名。
| customer_id |  customer_name| 
|------|------|
これがカラム。

### 5. 主キー（PRIMARY KEY）
---
データを一意に識別するキー。  
customer_id  
NG  
C001  
C001  
同じ値は登録不可。  

### 6. 外部キー（FOREIGN KEY）
---
テーブル同士を結び付けるキー。  
顧客  
customer_id	name1	山田  
注文  
order_id	customer_id100	1  
customer_idで関連付ける。  

### 7. CRUD
---
最重要.  
- Create
- 登録
- INSERT
- Read
- 検索
- SELECT
- Update
- 更新
- UPDATE
- Delete
- 削除
- DELETE

### 8. SELECT
---
最も使用頻度が高い。
```sql
SELECT * 
FROM customer;
```
- 結果
  - 全件取得

### 9. WHERE
---
条件検索
```sql
SELECT *
FROM customer
WHERE customer_id = 'C001';
```

### 10. ORDER BY
---
並び替え
```sql
SELECT *
FROM customer
ORDER BY customer_id;
```
降順
ORDER BY customer_id DESC;

### 11. GROUP BY
---
集計
```sql
SELECT
    pref_code,
    COUNT(*)
FROM customer
GROUP BY pref_code;
```
結果
```text
東京 100件
大阪 80件
岡山 20件
```

### 12. JOIN
---
顧客テーブル
1 山田
2 鈴木

注文テーブル
100 1
101 2

結合
```sql
SELECT
    c.customer_name,
    o.order_id
FROM customer c
INNER JOIN orders o
    ON c.customer_id = o.customer_id;
```
結果
```text
山田 100  
鈴木 101  
```

### 13. インデックス
---
検索を高速化する仕組み。  
イメージ  
辞書の索引  
なし  
1件ずつ探す  
あり  
すぐ見つかる  

### 14. トランザクション
---
処理のまとまり。  
銀行振込  
①A口座から引く  
②B口座へ入れる  
両方成功するか、  
全部失敗  
にする。  

### 15. COMMIT  
---
- 確定 
  - COMMIT;  

### 16. ROLLBACK  
---
- 取消  
  - ROLLBACK;  

### 17. 排他制御  
---
複数人が同時更新した時の制御。  
例  
山田さん  
鈴木さん  
同時更新  
↓  
データ競合  
を防ぐ。  

### 18. 正規化  
---
重複をなくす設計。  
悪い例  
```text
注文
顧客名
顧客住所
顧客電話番号
毎回持つ。
```
良い例
```text
customer
order
に分ける。
```

### 19. 実務で最低限覚えるSQL
---
```text
SELECT 
INSERT 
UPDATE
DELETE

次に
INNER JOIN
LEFT JOIN
GROUP BY
HAVING
ORDER BY

その後
EXISTS
IN
NOT EXISTS
サブクエリ
```

### 20. SQLの基礎基本を理解できたら
---
- CRUD SQL作成
- JOINを用いたデータ取得
- トランザクション管理
- コネクション管理
- 排他制御
- インデックスを考慮したSQL改修
- SQLチューニング
- テーブル定義書作成
追うのもいいかも.

### 参考
---
- AI先生
- 書籍たち


99. ### memo
---
- ファイル内の特定文字列を検索したい、grepの使い方を
```bash
 grep '###' README.md
```
- 
- 
