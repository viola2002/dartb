[초보자를 위한 BigQuery(SQL) 입문](https://www.inflearn.com/course/%EC%B4%88%EB%B3%B4%EC%9E%90%EB%A5%BC-%EC%9C%84%ED%95%9C-%EB%B9%85%EC%BF%BC%EB%A6%AC-sql-%EC%9E%85%EB%AC%B8/dashboard)
# 1-1. BigQuery 기초 지식
- 데이터 저장 형태
    - Database: 데이터의 저장소
    - Table: 데이터가 저장된 공간
- OLTP
    - 거래를 하기 위해 사용되는 데이터베이스
    - 보류, 중간 상태가 없음(주문 O or 주문 X 둘 중 하나)
    -> '데이터가 무결하다'
    - 주로 데이터의 추가(INSERT), 데이터의 변경(UPDATE) 발생
    - 분석을 위해 만든 것이 아니므로 쿼리 속도가 느릴 수 있음
- OLAP(Online Analytical Processing)
    - OLTP 보완
    - 분석을 위한 기능 제공
- 데이터 웨어하우스(Data Warehouse)
    - 말 그대로 창고
    - 데이터를 한 곳에 모아서 저장
- BigQuery 장점
    - SQL로 데이터 추출 쉬움
    - 빠른 속도
    - Firebase & Google Analytics 4의 데이터 쉽게 추출
    - 데이터 웨어하우스를 쓰기 위해 서버(컴퓨터)를 띄울 필요 없음
    - 구글에서 인프라 관리

# 1-2. BigQuery 환경 설정

# 2-1. 데이터 활용 Overview

# 2-2. 저장된 데이터 확인하기
