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
- Google Cloud 설정 - 체험판 시작
- Google Cloud 설정 - 프로젝트 선택
- Google Cloud 설정 - 프로젝트 ID 확인
- BigQuery 설정
- BigQuery 메인화면
    - 대부분 BigQuery Studio에서 진행
- BigQuery의 환경 구성 요소
    1. 프로젝트(Project)
        - 하나의 큰 건물
        - 하나의 프로젝트에 여러 데이터셋이 존재할 수 있음
    1. 데이터셋(Dataset)
        - 건물(프로젝트)에 있는 창고
        - 하나의 데이터셋에 다양한 테이블이 존재할 수 있음
    1. 테이블(Table)
        - 창고(데이터셋)에 있는 선반
        - 행과 열로 이루어진 데이터들 저장
- Google Cloud 설정 - 데이터셋 생성
- Google Cloud 설정 - 테이블 생성(pokemon, trainer, trainer_pokemon, battle)
- Google Cloud 설정 - 생성된 테이블 확인
- Google Cloud 설정 - 쿼리 실행해보기

# 2-1. 데이터 활용 Overview
- 데이터를 활용하는 과정
    1. 어떤 일을 해야 한다 (문제 정의)
    1. 원하는 것을 정한다
    1. 데이터 탐색 (EDA)
        1.
            - 단일 자료
            - 다량의 자료
                - 연결
        1.
            - 조건 필터링
            - 추출
            - 변환
            - 요약
    1. 데이터 결과 검증
    1. 피드백 / 활용
- 이 강의에서 다루는 내용
    - 데이터 탐색
    - 데이터 결과 검증

# 2-2. 저장된 데이터 확인하기
