# 1. [성분으로 구분한 아이스크림 총 주문량](https://school.programmers.co.kr/learn/courses/30/lessons/133026)
```sql
SELECT II.INGREDIENT_TYPE,
       SUM(FH.TOTAL_ORDER) AS TOTAL_ORDER
FROM FIRST_HALF AS FH
LEFT JOIN ICECREAM_INFO AS II
ON FH.FLAVOR = II.FLAVOR
GROUP BY II.INGREDIENT_TYPE
ORDER BY SUM(FH.TOTAL_ORDER) ASC
```
문제의 조건대로 차근차근 따라간다면 그다지 어렵지 않은 문제였다.

# 2. [즐겨찾기가 가장 많은 식당 정보 출력하기](https://school.programmers.co.kr/learn/courses/30/lessons/131123)
```sql
SELECT FOOD_TYPE,
       REST_ID,
       REST_NAME,
       FAVORITES
FROM REST_INFO
WHERE FAVORITES IN (
    SELECT MAX(FAVORITES)
    FROM REST_INFO
    GROUP BY FOOD_TYPE
)
GROUP BY FOOD_TYPE
ORDER BY FOOD_TYPE DESC
```
저번에 풀어본 `WHERE`절 서브 쿼리 유형 같아서 못 풀 정도는 아니였다.<br></br>
그러나 음식 종류 A의 최대 즐겨찾기 수와 같은 즐겨찾기 수를 갖지만, 음식 종류가 B나 C인 식당의 경우가 아직 찝찝하다.<br></br>
메인 쿼리의 `GROUP BY`절을 통해 해결을 했고, 그 원리가 이해가 되긴 하지만 뭐랄까 명료하지 않은 기분...?<br></br>
다른 학회원 분들의 쿼리를 참고해 보거나 ChatGPT에게 쿼리 리뷰를 부탁해 봐야겠다.

# 3. [조건에 맞는 사원 정보 조회하기](https://school.programmers.co.kr/learn/courses/30/lessons/284527)
```sql
SELECT SUM(GRD.SCORE) AS SCORE,
       EMP.EMP_NO,
       EMP.EMP_NAME,
       EMP.POSITION,
       EMP.EMAIL
FROM HR_DEPARTMENT AS DPM
LEFT JOIN HR_EMPLOYEES AS EMP
ON DPM.DEPT_ID = EMP.DEPT_ID
LEFT JOIN HR_GRADE AS GRD
ON EMP.EMP_NO = GRD.EMP_NO
GROUP BY EMP.EMP_NO
ORDER BY SCORE DESC
LIMIT 1
```
최상위 1명을 골라내는 방법으로 내림차순 정렬 후 가장 첫 행만 보여주도록 쿼리를 짰다.<br></br>
근데 이것도 마찬가지로 "이래도 되나?"싶은 생각이 든다.