
# 都道府県マスタ構築
###　COPYコマンドでcsvでデータ投入 
- create文
```sql
CREATE TABLE tbl_prefecture (
    prefecture_code INTEGER PRIMARY KEY,
    prefecture_name VARCHAR(20) NOT NULL,
    city_name VARCHAR(50) NOT NULL,
    latitude DECIMAL(10,7) NOT NULL,
    longitude DECIMAL(10,7) NOT NULL,
    source_code VARCHAR(50) NOT NULL,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(50),
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(50)
);
```
↓
```sql
COPY tbl_prefecture_import
FROM '/tmp/prefecture.csv'
DELIMITER ','
CSV HEADER;
```
↓
変換INSERT
```sql
INSERT INTO tbl_prefecture (
    prefecture_code,
    prefecture_name,
    city_name,
    latitude,
    longitude,
    source_code
)
```

```sql
-- テーブルコメント
COMMENT ON TABLE tbl_prefecture IS '都道府県および代表都市の位置情報を管理するマスタ';
-- カラムコメント
COMMENT ON COLUMN tbl_prefecture.prefecture_code IS '都道府県コード (JIS X 0401)';
COMMENT ON COLUMN tbl_prefecture.prefecture_name IS '都道府県名';
COMMENT ON COLUMN tbl_prefecture.city_name IS'代表都市名';
COMMENT ON COLUMN tbl_prefecture.latitude IS '緯度 (WGS84座標系)';
COMMENT ON COLUMN tbl_prefecture.longitude IS'経度 (WGS84座標系)';
COMMENT ON COLUMN tbl_prefecture.source_code IS'データ取得元コード';
COMMENT ON COLUMN tbl_prefecture.is_deleted IS '論理削除フラグ';
COMMENT ON COLUMN tbl_prefecture.created_at IS '登録日時';
COMMENT ON COLUMN tbl_prefecture.created_by IS '登録者';
COMMENT ON COLUMN tbl_prefecture.updated_at IS '更新日時';
COMMENT ON COLUMN tbl_prefecture.updated_by IS '更新者';
```

現状のテーブル定義に対しては、以下の形式になります。
```sql
INSERT INTO tbl_prefecture (
    prefecture_code,
    prefecture_name,
    city_name,
    latitude,
    longitude,
    source_code
) VALUES
(1, '北海道', '札幌市', 43.0644444, 141.3469444, 'PREFECTURE_MASTER'),
(2, '青森県', '青森市', 40.8247222, 140.7405556, 'PREFECTURE_MASTER');
```

### 10進数の変換について
47件すべてを正確に10進数へ変換してINSERT文を作成する場合、各行の緯度・経度を計算する必要があります。  
ただし、今回提示された47件について、正確な変換結果を私がその場で手計算すると計算ミスのリスクがあります。  
PostgreSQLなら、60進数データをそのまま投入してDB側で10進数へ変換する方が確実です。  

例えば、札幌市なら、
```sql
SELECT
    43 + 3.0/60 + 52.0/3600 AS latitude,
    141 + 20.0/60 + 49.0/3600 AS longitude;
```
- 結果
```text
43.0644444
141.3469444
```
もし47件すべてのINSERT文を作るなら、CSVから機械的に変換して生成した方が安全です。

### 項目の役割
```text
項目	用途prefecture_code	都道府県コード  
prefecture_name	都道府県名
city_name	県庁所在地
latitude	緯度(10進数)
longitude	経度(10進数)
source_code	原典コード・データ取得元
created_at	登録日時
updated_at	更新日時
```

- 追加候補
  - is_deleted
  - 論理削除フラグ
実務では物理削除より多い

created_by  
登録者  
updated_by  
更新者  
source_code  
「総務省」「国土地理院」などの元データ識別  

ただし、学習用リポジトリなら、
```text
prefecture_code
prefecture_name
city_name
latitude
longitude
source_code
created_at
updated_at
```
くらいが最小かつ実務寄りで、ちょうど良いバランスだと思います。  
is_deleted や created_by は次の学習テーマとして追加するのがおすすめです。  

### memo
- 改行しないと実行されない？？？
```sql
SELECT *
FROM tbl_prefecture;
```
- 
- 