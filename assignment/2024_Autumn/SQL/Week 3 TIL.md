# 1. [조건에 맞는 사용자와 총 거래금액 조회하기](https://school.programmers.co.kr/learn/courses/30/lessons/164668)
```sql
SELECT USER_ID,
       NICKNAME,
       SUM(PRICE) AS TOTAL_SALES
FROM USED_GOODS_BOARD AS b
INNER JOIN USED_GOODS_USER AS u
ON b.WRITER_ID = u.USER_ID
WHERE STATUS = 'DONE'
GROUP BY u.USER_ID
HAVING TOTAL_SALES >= 700000
ORDER BY TOTAL_SALES ASC
```
- 1차 시도: 문제에서 요구하는 총거래금액의 컬럼 이름을 확인하지 않았음을 발견
- 2차 시도: 문제에서 `완료된 중고거래`를 경시했다가 `STATUS`컬럼을 발견
<br></br>
문제를 대충 읽는 습관이 오답 원인이었다. <br></br>
실제 시험이라 생각하고 집중하여 틀리지 않도록 조심해야겠다.

# 2. [업그레이드 할 수 없는 아이템 구하기](https://school.programmers.co.kr/learn/courses/30/lessons/273712)
```sql
SELECT i.ITEM_ID,
       i.ITEM_NAME,
       i.RARITY
FROM ITEM_INFO AS i
LEFT JOIN ITEM_TREE AS t
ON i.ITEM_ID = t.PARENT_ITEM_ID
WHERE t.ITEM_ID IS NULL
ORDER BY i.ITEM_ID DESC
```
`ITEM_INFO` 테이블과 `ITEM_TREE` 테이블을 여러 번 `JOIN` 해보며 방법을 찾고 있었다.<br></br>
그러던 중 `ITEM_INFO`의 `ITEM_ID`와 `ITEM_TREE`의 `PARENT_ITEM_ID`를 기준으로 `LEFT JOIN`을 해보니 실마리가 잡혔다.<br></br>
해당 아이템을 PARENT 아이템으로 가지는 아이템, 말하자면 "CHILD 아이템"들의 아이템 ID가 전부 오른쪽으로 붙어있는 결과를 얻었기 때문이다.<br></br>
즉 여기서 "CHILD 아이템"이 더 없는 아이템들이 바로 더 강화를 할 수 없는 아이템인 것이다.<br></br>
그 다음에 이에 맞춰 쿼리를 작성하니 쉽게 제출에 성공할 수 있었다.

# 3. [조건에 맞는 개발자 찾기](https://school.programmers.co.kr/learn/courses/30/lessons/276034)
```sql
SELECT DISTINCT d.ID,
       d.EMAIL,
       d.FIRST_NAME,
       d.LAST_NAME
FROM developers AS d
INNER JOIN skillcodes AS sc
ON (d.SKILL_CODE & sc.CODE) = sc.CODE
WHERE sc.name IN ('Python', 'C#')
ORDER BY d.ID ASC
```
이 문제는 지난 학기 과제에서도 푼 적이 있었는데, 다시 보니 풀 자신이 없었다.<br></br>
따라서 한번 더 정답 쿼리를 코드 리뷰해보기로 했다.<br></br>
<br></br>
이 쿼리의 핵심은 `ON`절의 비트 연산자 `&`이다.<br></br>
비트 연산자의 특징은 수를 비트(이진수) 단위로 연산을 한다는 점이다.<br></br>
개별 스킬의 코드는 2의 거듭제곱 꼴이므로 이진수에서 서로 자릿수가 겹치지 않는다.<br></br>
따라서 이들의 합인 SKILL_CODE는 자릿수가 변하지 않은 채 합을 유지하게 된다.<br></br>
1(TRUE)과 1(TRUE)의 교집합만이 1(TRUE)인 점도 이용하면 두 이진수의 비트 단위 교집합이 개별 스킬 코드인 셈이다.<br></br>
여기에 'Python'과 'C#'을 모두 보유하고 있는 개발자 ID의 중복을 제외해주면 정답 쿼리에 쉽게 다가갈 수 있다.<br></br>
<br></br>
이제는 유사 유형이 나오면 자신 있게 쿼리를 작성해보고 싶다.