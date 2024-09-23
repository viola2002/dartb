# 1. [우리 플랫폼에 정착한 판매자](https://solvesql.com/problems/settled-sellers-1/)
```sql
SELECT seller_id,
       COUNT(DISTINCT order_id) AS orders
FROM olist_order_items_dataset
GROUP BY seller_id
HAVING orders >= 100
```
이전에 풀어본 적 있는 문제라 어렵지 않았다.
- `COUNT()` 함수를 쓸 때는 중복에 유의하여 `DISTINCT`를 적극 활용하자.
- 집계함수는 `WHERE`절로 필터링이 안 되므로 `HAVING`절을 사용하자.
이 두 가지에 유의하여 쿼리를 작성하니 수월하였다.

# 2. [몇 분이서 오셨어요?](https://solvesql.com/problems/size-of-table/)
```sql
SELECT *
FROM tips
WHERE size % 2 <> 0
```
sql은 python과는 달리 `//` 연산자는 존재하지 않는다.
`%` 연산자를 나머지 연산에서 쓸 수는 있지만 모든 sql 데이터 베이스에서는 쓰이는 것은 아니다.
sql 데이터 베이스에 따라 사용 가능한 연산자나 함수 등이 다른 점이 까다로웠다.

# 3. [최고의 근무일을 찾아라](https://solvesql.com/problems/best-working-day/)
```sql
SELECT day,
       ROUND(SUM(tip), 3) AS tip_daily
FROM tips
GROUP BY day
ORDER BY tip_daily DESC
LIMIT 1
```
처음에는 `MAX()` 함수를 이용하려고 했으나 그 경우 서브쿼리를 이용해야 해서 복잡했다.
따라서 팁을 내림차순으로 정렬한 뒤 가장 첫번째 행만 출력하도록 쿼리를 작성했다.
나중에는 서브쿼리로도 작성할 수 있도록 노력해야겠다.