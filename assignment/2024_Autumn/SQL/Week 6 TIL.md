# 1. [즐겨찾기가 가장 많은 식당 정보 출력하기](https://school.programmers.co.kr/learn/courses/30/lessons/131123)

위 문제는 5주차 때 풀이한 문제입니다.

아래는 틀린 풀이입니다.

1. 틀린 코드 이유 분석(정답 코드 참고)

**틀린 코드**

```sql
SELECT *
FROM (SELECT FOOD_TYPE, REST_ID, REST_NAME, MAX(FAVORITES) AS FAVORITES
FROM REST_INFO
GROUP BY FOOD_TYPE
ORDER BY FOOD_TYPE DESC
```

이 코드가 틀린 이유를 찾아내고, 정답 코드와 비교해 정리해주세요.

- 정답 코드

    ```sql
    SELECT FOOD_TYPE, REST_ID, REST_NAME, FAVORITES
    FROM REST_INFO
    WHERE (FOOD_TYPE, FAVORITES) IN (
        SELECT FOOD_TYPE, MAX(FAVORITES)
        FROM REST_INFO
        GROUP BY FOOD_TYPE
    )
    ORDER BY FOOD_TYPE DESC;
    ```


또한, 이 문제에서는 아래 **개선된 쿼리**로도 조회될 수 있습니다.

**ROW_NUMBER 윈도우 함수**를 사용합니다.

1. 개선된 쿼리 학습
- **개선된 쿼리**

    ```sql
    WITH RankedRest AS (
        SELECT
            FOOD_TYPE, REST_ID, REST_NAME, FAVORITES,
            ROW_NUMBER() OVER (PARTITION BY FOOD_TYPE ORDER BY FAVORITES DESC, REST_ID) AS rnk
        FROM REST_INFO
    )
    SELECT
        FOOD_TYPE, REST_ID, REST_NAME, FAVORITES
    FROM RankedRest
    WHERE rnk = 1
    ORDER BY FOOD_TYPE DESC;
    ```


이 코드를 단계별로 해석하고(주석 사용 등), 위 코드에 비해 갖는 이점을 설명하세요.

# 2. [조건에 맞는 사원 정보 조회하기](https://school.programmers.co.kr/learn/courses/30/lessons/284527)

<!--지시사항을 따르고 <코드 실행>을 누르면 물론 ‘실패’로 뜰 겁니다. 다만 그 때 ‘SELECT 결과보기’를 눌러 세부 사항을 확인해주세요-->

기본 코드

```sql
SELECT
    EMP_NO,
    EMP_NAME,
    SAL,
    RANK() OVER (ORDER BY SAL DESC) AS rnk
FROM
    HR_EMPLOYEES;
```

이때, **RANK(), DENSE_RANK(), ROW_NUMBER() 함수**를 사용하며 결과를 비교하고 해당 함수를 사용하는 경우를 서술해주세요. (함수 사용 예제는 직접 찾아보기)

- 예시

    ![스크린샷 2024-11-05 오후 12.27.07.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/90b65d7a-c625-43c1-9a97-de3f82558ba7/2770811b-bc49-46ac-846b-95778dfd1464/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2024-11-05_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_12.27.07.png)