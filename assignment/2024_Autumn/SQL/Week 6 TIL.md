# 1. [즐겨찾기가 가장 많은 식당 정보 출력하기](https://school.programmers.co.kr/learn/courses/30/lessons/131123)

위 문제는 5주차 때 풀이한 문제입니다.

아래는 틀린 풀이입니다.

## 1. 틀린 코드 이유 분석(정답 코드 참고)

- **틀린 코드**

    ```sql
    SELECT *
    FROM (SELECT FOOD_TYPE, REST_ID, REST_NAME, MAX(FAVORITES) AS FAVORITES
    FROM REST_INFO
    GROUP BY FOOD_TYPE
    ORDER BY FOOD_TYPE DESC);
    ```

이 코드가 틀린 이유를 찾아내고, 정답 코드와 비교해 정리해주세요.

- **정답 코드**

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

```
MAX 함수는 SQL에서 특정 그룹 내에서 최댓값을 반환하는 집계 함수이므로 그룹 내에서만 적용이 가능하다.
즉, 다른 컬럼과 함께 사용할 때는 문제가 발생하여 오답으로 처리된다.
그렇다고 FROM절 서브 쿼리에서 다른 컬럼을 제외한다면, SELECT절에서 원본 테이블의 해당 컬럼에 접근할 수 없어진다.
따라서 WHERE절 서브 쿼리를 통해, 조건별 집계와 컬럼 조회를 모두 할 수 있도록 쿼리를 작성해야 한다.
```


또한, 이 문제에서는 아래 **개선된 쿼리**로도 조회될 수 있습니다.

**ROW_NUMBER 윈도우 함수**를 사용합니다.

## 2. 개선된 쿼리 학습

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

- **주석**
    ```sql
    /** CTE로 새로운 임시 테이블에 저장 **/
    WITH RankedRest AS (
        SELECT
            FOOD_TYPE, REST_ID, REST_NAME, FAVORITES, /* 컬럼 추출 */
            /* FOOD_TYPE별 그룹 내에서 FAVORITES 내림차순 순위 정렬 */
            /* FAVORITES가 같은 경우 REST_ID를 기준으로 정렬 */
            ROW_NUMBER() OVER (PARTITION BY FOOD_TYPE ORDER BY FAVORITES DESC, REST_ID) AS rnk
            FROM REST_INFO /* 기존 테이블 */
    )
    /** 새 테이블에서 불러오기 **/
    SELECT
        FOOD_TYPE, REST_ID, REST_NAME, FAVORITES
    FROM RankedRest
    WHERE rnk = 1 /* 1위인 식당만 */
    ORDER BY FOOD_TYPE DESC; /* FOOD_TYPE별 정렬 */
    ```
- **이점**
    ```
    기존 쿼리에 비해 갖는 이점으로는 가독성, 안정성, 확장성을 들 수 있다.
    `WITH`절과 `ROW_NUMBER()` 윈도우 함수를 사용함으로써 서브쿼리와 복잡한 필터링 논리를 사용하는 기존 쿼리에 비해 가독성이 높다.
    또한 FAVORITES가 같은 경우에도 REST_ID 순서로 순위가 매겨지므로, 중복 값을 안정적으로 처리할 수 있다.
    rnk 값을 조정하는 식으로 이후 다른 유사 쿼리에서도 확장하여 사용이 가능하다.
    ```

# 2. [조건에 맞는 사원 정보 조회하기](https://school.programmers.co.kr/learn/courses/30/lessons/284527)

<!--지시사항을 따르고 <코드 실행>을 누르면 물론 ‘실패’로 뜰 겁니다. 다만 그 때 ‘SELECT 결과보기’를 눌러 세부 사항을 확인해주세요-->

**기본 코드**

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

- **RANK()**
    ```
    동일한 값에는 동일한 순위를 부여하지만, 중복 값 뒤에는 순위를 건너뛴다.
    예를 들어, 올림픽 등의 대회에서 공동 순위를 부여하는 경우, 중간 순위가 비워진 상태를 유지하는 것이 의미 있을 때 사용할 수 있다.
    ```
    <p align="center">
    <img src="https://github.com/viola2002/dartb/blob/main/assignment/2024_Autumn/SQL/screenshots/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-11-12%20112247.png">
    </p>

- **DENSE_RANK()**
    ```
    동일한 값에 동일한 순위를 부여하고, 다음 순위는 건너뛰지 않는다.
    예를 들어, 연속된 순위를 유지해야 하는 제품 등급을 표시할 때 쓰일 수 있다.
    고객 입장에서는 연속된 순위가 비교하기 쉽고 일관되어 보이기 때문이다.
    ```
    <p align="center">
    <img src="https://github.com/viola2002/dartb/blob/main/assignment/2024_Autumn/SQL/screenshots/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-11-12%20112328.png">
    </p>

- **ROW_NUMBER()**
    ```
    동일한 값이 있어도 순위를 중복하지 않고, 각 행에 고유한 순위를 부여한다.
    고유한 순서를 보장해야 할 때, 즉 조회수 상위 10개를 선택하고 싶지만 같은 조회수를 가진 영상이 여러 개 있는 경우 등을 예시로 들 수 있다.
    ```
    <p align="center">
    <img src="https://github.com/viola2002/dartb/blob/main/assignment/2024_Autumn/SQL/screenshots/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7%202024-11-12%20112409.png">
    </p>