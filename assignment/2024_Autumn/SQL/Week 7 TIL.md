# [NULL처리하기 (SQL 고득점kit)](https://school.programmers.co.kr/learn/courses/30/lessons/59410)

**동물의 생물 종, 이름, 성별 및 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성합니다.**

이때, 이름이 없는 동물의 이름은 ‘No name’으로 합니다.

## 1. IFNULL()으로 해결

```sql
/* IfNULL() 함수 문법을 익히고 사용하여 해결해주세요. */
SELECT ANIMAL_TYPE,
       IFNULL(NAME, 'No name'),
       SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY ANIMAL_ID ASC
```

같은 문제를, CASE WHEN 문법을 사용하여 해결해주세요

## 2. CASE WHEN으로 해결

```sql
/* CASE WHEN 문법을 익히고 사용하여 해결해주세요. */
SELECT ANIMAL_TYPE,
       CASE WHEN NAME IS NULL THEN 'No name' ELSE NAME END,
       SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY ANIMAL_ID ASC
```

# [중성화 여부 파악하기](https://school.programmers.co.kr/learn/courses/30/lessons/59409#qna)

## 3. 문제를 풀어주세요. (힌트: IF, LIKE를 사용할 수 있습니다)

```sql
SELECT ANIMAL_ID,
       NAME,
       IF(SEX_UPON_INTAKE LIKE '%Neutered%' OR SEX_UPON_INTAKE LIKE '%Spayed%', 'O', 'X') AS 중성화
FROM ANIMAL_INS
```

## 문제 4. 아래는 QnA에 올라온 질문입니다. 왜 풀이가 틀렸는지 답해주세요.

[](https://school.programmers.co.kr/questions/80270)

```
`OR` 연산자를 사용할 때는 각 조건을 명시적으로 작성해야 한다.
현재 작성된 쿼리에서 '%Spayed%'는 독립적인 조건으로, 항상 참으로 간주된다.
따라서 Spayed라는 단어가 있는 것을 제대로 처리하지 못해 오답이다.
```