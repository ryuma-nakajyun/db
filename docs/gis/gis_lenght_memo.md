# GISで2点間の距離を求める 
GISで2点間の距離を求める場合、単純な引き算ではなく地球を球体（または楕円体）として計算します。

## 1. 概算なら平面距離
例えば  
```text
A: 35.681236, 139.767125 （東京駅）  
B: 35.689487, 139.691706 （新宿駅）  
```
程度ならGISエンジンがない環境でざっくり計算できますが、緯度経度のまま
```text
√((lat2-lat1)^2 + (lon2-lon1)^2)
```
は厳密には正しくありません。

理由は、
```text
緯度1度 ≒ 111km    
経度1度 ≒ 111km × cos(緯度)  
```
だからです。  

## 2. GISで一般的なハーサイン(Haversine)公式
2点間の大圏距離を求めます。
```text
a = sin²((lat2-lat1)/2)
  + cos(lat1)
  × cos(lat2)
  × sin²((lon2-lon1)/2)

c = 2 × atan2(√a, √(1−a))
distance = R × c

地球半径
R = 6371km
```
を使用します。  
精度は日常業務なら十分です。

## 3. Java例
```java
public static double distance(
        double lat1,
        double lon1,
        double lat2,
        double lon2) {

    final double R = 6371000; // m

    double latRad1 = Math.toRadians(lat1);
    double latRad2 = Math.toRadians(lat2);

    double dLat = Math.toRadians(lat2 - lat1);
    double dLon = Math.toRadians(lon2 - lon1);

    double a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2)
        + Math.cos(latRad1)
        * Math.cos(latRad2)
        * Math.sin(dLon / 2)
        * Math.sin(dLon / 2);

    double c = 2 * Math.atan2(
        Math.sqrt(a),
        Math.sqrt(1 - a));

    return R * c;
}
```

## 4. PostgreSQL + PostGIS
GISならこちらが本命です。  
```sql
SELECT ST_DistanceSphere(
    ST_MakePoint(139.767125,35.681236),
    ST_MakePoint(139.691706,35.689487)
);
```

結果  
メートル単位  
で返ります。  

## 5. 実務でよくある検索
半径1km以内の施設
```sql  
SELECT *
FROM facility
WHERE ST_DWithin(
    geom,
    ST_MakePoint(139.767125,35.681236)::geography,
    1000
);
```
1000m以内  
の施設取得。  

設計観点  
マスタに  
```sql
latitude  DECIMAL(10,7)
longitude DECIMAL(10,7)
```
を保持し、  
距離計算時だけ   
double  
へ変換して計算するのが一般的です。  

つまり、
```text
保存 → DECIMAL
計算 → double
検索 → GIS関数(PostGIS等)
```
という役割分担になります。これが実務のGISシステムで最もよく見る構成です。

### 参考
---
- AI先生
- 

### memo
---
- 距離計算の精度を比較して
- PostGISで最近傍検索を作って
- Javaで距離計算のテストを書く
