# 1. PIVOT과 UNPIVOT

## A. pivot과 unpivot에 관해 자유로운 리소스를 이용해 학습하고 요약해주세요.

예시:
[[SQLD 모든 것] 26. PIVOT, UNPIVOT절 | SQL 피봇팅 | 아이리포](https://www.youtube.com/watch?v=FINRIH6Bmq0)

**PIVOT**
- 가시성 있게 보이도록 = 보고서 작성
- 행을 열로
- (ORACLE) `PIVOT`절은 내부적으로 *첫 번째 컬럼*에 대한 `GROUP BY` 연산 수행을 포함함
- (ORACLE) 문법 예시
    ```SQL
    SELECT *
    FROM (
        SELECT E.JOB, D.DNAME
        FROM EMP E, DEPT D
        WHERE E.DEPTNO = D.DEPTNO
    )
    PIVOT (
        COUNT(*) FOR DNAME IN (
            'ACCOUNTING' AS ACCOUNTING,
            'RESEARCH' AS RESEARCH,
            'SALES' AS SALES
        )
    );
    ```

**UNPIVOT**
- 집계 함수를 사용할 수 있도록 = 통계치 계산
- 열을 행으로
- (ORACLE) 문법 예시
    ```SQL
    SELECT 계절, 연도, 기온
    FROM (SELECT * FROM 평균기온)
    UNPIVOT (
        기온 FOR 연도 IN (
            Y2018 AS '2018년',
            Y2019 AS '2019년',
            Y2020 AS '2020년',
            Y2021 AS '2021년',
            Y2022 AS '2022년'
        )
    );
    ```

## B. 다음 문제를 풀어주세요.

문제: [Occupations | HackerRank](https://www.hackerrank.com/challenges/occupations/problem)

어렵다면 아래 소스를 참고하셔도 좋습니다. </br>
[[SQL] CASE WHEN으로 Pivot Table 만들기(HackerRank - Occupations 문제)](https://techblog-history-younghunjo1.tistory.com/159)

**MySQL**
- 정답 쿼리
    ```sql
    SELECT
        MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor,
        MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
        MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer,
        MAX(CASE WHEN Occupation = 'Actor' THEN Name END) AS Actor
    FROM (
        SELECT
            Name,
            Occupation,
            ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS RowNum
        FROM OCCUPATIONS
    ) AS Ranked
    GROUP BY RowNum
    ORDER BY RowNum;
    ```
- 쿼리 해설
    1. `ROW_NUMBER()`를 이용하여, 각 직업별로 이름에 알파벳 오름차순 순위 부여
        - 쿼리
            ```sql
            SELECT
                Name,
                Occupation,
                ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS RowNum
            FROM OCCUPATIONS;
            ```
        - 출력 예시
            ```
            NAME	OCCUPATION	RowNum
            Eve	Actor	1
            Jennifer	Actor	2
            Ketty	Actor	3
            Samantha	Actor	4
            Aamina	Doctor	1
            Julia	Doctor	2
            Priya	Doctor	3
            Ashley	Professor	1
            Belvet	Professor	2
            Britney	Professor	3
            ```
    1. `CASE`문을 사용해, 각 직업에 해당하는 이름을 열로 변환
        - 쿼리
            ```sql
            SELECT
                CASE WHEN Occupation = 'Doctor' THEN Name END AS Doctor,
                CASE WHEN Occupation = 'Professor' THEN Name END AS Professor,
                CASE WHEN Occupation = 'Singer' THEN Name END AS Singer,
                CASE WHEN Occupation = 'Actor' THEN Name END AS Actor,
                RowNum
            FROM (
                SELECT
                    Name,
                    Occupation,
                    ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS RowNum
                FROM OCCUPATIONS
            ) AS Ranked;
            ```
        - 출력 예시
            ```
            Doctor	Professor  	Singer	Actor	RowNum
            NULL	NULL	NULL	Eve	1
            NULL	NULL	NULL	Jennifer	2
            NULL	NULL	NULL	Ketty	3
            NULL	NULL	NULL	Samantha	4
            Aamina	NULL	NULL	NULL	1
            Julia	NULL	NULL	NULL	2
            Priya	NULL	NULL	NULL	3
            NULL	Ashley	NULL	NULL	1
            NULL	Belvet	NULL	NULL	2
            NULL	Britney	NULL	NULL	3
            ```
    1. `MAX()`함수와 `GROUP BY`절을 이용해 열별 데이터 통합
        - 쿼리
            ```sql
            SELECT
                MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor,
                MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
                MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer,
                MAX(CASE WHEN Occupation = 'Actor' THEN Name END) AS Actor
            FROM (
                SELECT
                    Name,
                    Occupation,
                    ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS RowNum
                FROM OCCUPATIONS
            ) AS Ranked
            GROUP BY RowNum;
            ```
        - 왜 `MAX()` 함수인가?
            ```
            1. `GROUP BY RowNum`을 수행할 때 `MAX()`함수가 각 열에서 `NULL`이 아닌 값을 선택한다.
            2. 만약 특정 열에 값이 없으면, `MAX()`함수는 `NULL`을 반환한다.
            3. 다른 함수를 사용할 수 있지만 `MAX()`함수가 가장 널리 쓰이고 의미가 직관적이라고 한다. (ChatGPT피셜...)
            ```

# 2. 성능 최적화 기법

## A. 아래 칼럼을 읽고 요약해주세요.

칼럼 내용에 기반해 문제를 출제했습니다. </br>
[SQL 쿼리 성능 최적화를 위한 튜닝 팁 6가지 (Query Optimization)](https://community.heartcount.io/ko/query-optimization-tips/)

**성능 최적화를 위한 6가지 팁**
1. 좌변을 연산하지 않을 것
    - 사용자 입장에서 직관적이더라도 DB 관점에서는 효율적이지 않음
    - 한 줄 한 줄 일일이 연산을 수행하지 않도록 우변에서 필터링하는 걸  권장
    - 다시 말해, 연산이라는 가공을 거치지 않고 원본 데이터를 직접 비교
1. `OR` 대신 `UNION`을 사용할 것
    - 1번과 비슷하게, DB가 한번 스캔할 때 모든 조건을 확인하게 됨
    - 두 개 이상의 `SELECT`절을 `UNION`연산자로 병합
1. 필요한 Row와 Column만 선택할 것
    - WHERE절, SELECT절
    - 서브 쿼리 활용
1. 분석 함수를 활용할 것
    - 분석 함수(Analytic Functions): 각 Row별 세부적인 계산
        - 순위 결정
            - `ROW_NUMBER()`
            - `RANK()`
            - `DENSE_RANK()`
        - 데이터 변화 추적
            - `LEAD()`: 이전 Row 참조
            - `LAG()`: 다음 Row 참조
    - 집계 함수와 달리 사전에 데이터를 그룹화할 필요 없음
1. 와일드카드(`%`)는 끝에 작성할 것
    - 앞에 작성하면 모든 가능한 조합을 검색하므로 가급적 끝에 사용
1. 계산값을 미리 저장해두고 나중에 조회할 것
    - 복잡한 계산은 실시간으로 하는 것보단 새로 테이블을 생성
    - 일정 주기마다 통계치 업데이트

## B. 문제를 풀어주세요.

### 문제

여러분은 `customer_orders`라는 테이블을 관리하는 데이터베이스 관리자로 일하고 있습니다. </br>
이 테이블에는 고객의 주문 정보가 저장되어 있으며, 각 고객이 주문한 제품과 수량, 가격 정보가 포함되어 있습니다. </br>
또한, 고객들이 특정 제품을 재구매한 비율을 계산하려고 합니다.

---

### 테이블 구조:

1. **customers** 테이블
    - `customer_id` (고객 ID, PRIMARY KEY)
    - `name` (고객 이름)
2. **orders** 테이블
    - `order_id` (주문 ID, PRIMARY KEY)
    - `customer_id` (고객 ID, FOREIGN KEY)
    - `order_date` (주문 날짜)
3. **order_details** 테이블
    - `order_id` (주문 ID, FOREIGN KEY)
    - `product_id` (제품 ID)
    - `quantity` (수량)
    - `unit_price` (단가)

---

### 요구 사항:

1. **`avg_order_value`**: 고객별 평균 주문 금액을 계산하여 `customers` 테이블에 업데이트하세요.
    - `avg_order_value`는 각 고객이 한 번의 주문에서 지출한 평균 금액입니다.
2. **`total_spent`**: 고객별 총 지출 금액을 계산하여 `customers` 테이블에 업데이트하세요.
    - `total_spent`는 고객이 지금까지 지출한 총 금액입니다.
3. **`num_orders`**: 고객이 총 몇 번의 주문을 했는지 계산하여 `customers` 테이블에 업데이트하세요.
    - `num_orders`는 고객이 주문한 총 개수입니다.
4. **`repurchase_rate`**: 고객의 재구매 비율을 계산하여 `customers` 테이블에 업데이트하세요.
    - `repurchase_rate`는 각 고객이 2번 이상 주문한 제품 비율을 의미합니다. (즉, 재구매한 제품이 전체 구매 제품 중 몇 퍼센트를 차지하는지)

---

### 예시:

- 고객 A는 3번 주문을 했고, 그 중 2개의 제품을 재구매했습니다.
    - 평균 주문 금액: 100,000원
    - 총 지출 금액: 300,000원
    - 주문 횟수: 3번
    - 재구매 비율: 66.67%

---

### 정답

```sql
UPDATE customers c
SET
    avg_order_value = (
        SELECT AVG(od.quantity * od.unit_price)
        FROM order_details od
        JOIN orders o ON od.order_id = o.order_id
        WHERE o.customer_id = c.customer_id
    ),
    total_spent = (
        SELECT SUM(od.quantity * od.unit_price)
        FROM order_details od
        JOIN orders o ON od.order_id = o.order_id
        WHERE o.customer_id = c.customer_id
    ),
    num_orders = (
        SELECT COUNT(DISTINCT o.order_id)
        FROM orders o
        WHERE o.customer_id = c.customer_id
    ),
    repurchase_rate = (
        SELECT
            COUNT(DISTINCT CASE WHEN od.product_id IN (
                SELECT product_id
                FROM order_details
                JOIN orders o ON order_details.order_id = o.order_id
                WHERE o.customer_id = c.customer_id
                GROUP BY order_details.product_id
                HAVING COUNT(order_details.product_id) > 1
            ) THEN od.product_id END) * 1.0 / COUNT(DISTINCT od.product_id)
        FROM order_details od
        JOIN orders o ON od.order_id = o.order_id
        WHERE o.customer_id = c.customer_id
    );
```

---

### 추가 질문:

1. 정답 쿼리에서 `repurchase_rate`를 구할 때 사용한 `HAVING COUNT(order_details.product_id) > 1`의 의미는 무엇인가요?
```
"재구매"는 적어도 두 번 이상 특정 제품을 구매하였을 때 해당한다.
따라서 `HAVING`절을 통해 한 번보다 많이 (= 두 번 이상) 구매를 한 경우만 필터링한다.
```
2. 이 문제에서 사용될 수 있는 성능을 최적화하기 위한 방법은 무엇일까요?
```
반복되는 집계 함수와 `JOIN` 사용을 `WITH`절을 통해 하나의 테이블에 저장해둔다.
주기적으로 데이터를 업데이트 해가며 불러오면 성능을 최적화할 수 있다.
```