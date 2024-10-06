# 1. [ROOT 아이템 구하기](https://school.programmers.co.kr/learn/courses/30/lessons/273710)
```sql
SELECT i.ITEM_ID,
       i.ITEM_NAME
FROM ITEM_INFO AS i
INNER JOIN ITEM_TREE AS t
ON i.ITEM_ID = t.ITEM_ID
WHERE t.PARENT_ITEM_ID IS NULL
```
지난주 문제 덕분에 큰 어려움 없이 수월하게 풀 수 있었다.

# 2. [업그레이드 할 수 없는 아이템 구하기](https://school.programmers.co.kr/learn/courses/30/lessons/284531)
```sql
SELECT ROUTE,
       CONCAT(ROUND(SUM(D_BETWEEN_DIST), 1), "km") AS TOTAL_DISTANCE,
       CONCAT(ROUND(AVG(D_BETWEEN_DIST), 2), "km") AS AVERAGE_DISTANCE
FROM SUBWAY_DISTANCE
GROUP BY ROUTE
ORDER BY SUM(D_BETWEEN_DIST) DESC
```
코드 실행 결과는 문제가 없었으나 채점을 하니 실패가 떴었다.<br></br>
그런데 이 쿼리를 어디서 본 것 같아서 확인해 보니, 바로 지난주 수요일에 매스큐엘 리뷰를 하며 봤던 것이었다.<br></br>
문제의 원인은 `CONCAT()`을 한 뒤 정렬할 경우 ASCII 값을 기준으로 한다는 SQL의 특징 때문이었다.<br></br>
쉽게 생각해 보면 PC에서 파일 정렬을 할 때 종종 10번 대가 2, 3, 4 등의 한자리 수보다 앞에 오는 경우와 같은 상황이다.<br></br>
따라서 `CONCAT()`을 하기 전의 과정을 기준으로 정렬하면 문제를 쉽게 해결할 수 있다.

# 3. [헤비 유저가 소유한 장소](https://school.programmers.co.kr/learn/courses/30/lessons/77487)
```sql
SELECT *
FROM PLACES
WHERE HOST_ID IN (
    SELECT HOST_ID
    FROM PLACES
    GROUP BY HOST_ID
    HAVING COUNT(ID) >= 2
)
ORDER BY ID ASC
```
지난주에 매스큐엘을 하며 풀었던 문제랑 유사해서 어렵지 않게 해결했다.