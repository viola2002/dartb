# Sixth Study Week


## Study Schedule
<br>

| 회차 | 강의 범위   | 강의 이수 여부 | 링크                                                                                                     |
|------|-------------|----------------|--------------------------------------------------------------------------------------------------------|
| 1    | 1~7강       | ✅              | [링크](https://www.youtube.com/watch?v=AXkaUrJs-Ko&list=PL87tgIIryGsa5vdz6MsaOEF8PK-YqK3fz&index=84)    |
| 2    | 8~17강      | ✅              | [링크](https://www.youtube.com/watch?v=AXkaUrJs-Ko&list=PL87tgIIryGsa5vdz6MsaOEF8PK-YqK3fz&index=75)    |
| 3    | 18~27강     | ✅              | [링크](https://www.youtube.com/watch?v=AXkaUrJs-Ko&list=PL87tgIIryGsa5vdz6MsaOEF8PK-YqK3fz&index=65)    |
| 4    | 28~37강     | ✅              | [링크](https://www.youtube.com/watch?v=e6J0Ljd6h44&list=PL87tgIIryGsa5vdz6MsaOEF8PK-YqK3fz&index=55)    |
| 5    | 38~47강     | ✅              | [링크](https://www.youtube.com/watch?v=AXkaUrJs-Ko&list=PL87tgIIryGsa5vdz6MsaOEF8PK-YqK3fz&index=45)    |
| 6    | 48~57강     | ✅              | [링크](https://www.youtube.com/watch?v=AXkaUrJs-Ko&list=PL87tgIIryGsa5vdz6MsaOEF8PK-YqK3fz&index=35)    |
| 7    | 58~67강     | 🍽️             | [링크](https://www.youtube.com/watch?v=AXkaUrJs-Ko&list=PL87tgIIryGsa5vdz6MsaOEF8PK-YqK3fz&index=25)    |
| 8    | 68~77강     | 🍽️             | [링크](https://www.youtube.com/watch?v=AXkaUrJs-Ko&list=PL87tgIIryGsa5vdz6MsaOEF8PK-YqK3fz&index=15)    |
| 9    | 78~85강     | 🍽️             | [링크](https://www.youtube.com/watch?v=AXkaUrJs-Ko&list=PL87tgIIryGsa5vdz6MsaOEF8PK-YqK3fz&index=5)     |
---

<br/>
<!-- 여기까진 그대로 둬 주세요-->

> **🧞‍♀️ 오늘은 강의보다 실습과 대시보드 직접 만들기가 더 중요하니, 기록보다는 사고하며 강의를 들어주세요.**

## 48. 워크시트 서식(2)

<!-- 워크시트에 관해 본 강의에서 알게 된 점을 적어주세요 -->

- `서식` 탭
    - 글꼴
        - 워크시트 내 텍스트의 <ins>글꼴, 색상, 크기</ins> 설정
    - 맞춤
        - 워크시트 내 텍스트의 <ins>정렬, 방향</ins> 설정
    - 음영
        - 워크시트 내 표시된 데이터 셀에 <ins>음영</ins> 적용
        - `행/열 색상 교차`: 데이터 셀의 구간을 설정하여 음영 적용
        - `구간 크기` = 하나의 셀 단위
    - 테두리
        - 뷰에 표시된 차트의 *테두리* <ins>유형, 두께, 색상</ins> 설정
        - `수준`의 눈금을 조정하여 테두리가 표시될 수준(테이블, 필드 등) 설정
        - <ins>테이블, 패널, 셀, 머리글</ins>
    - 라인
        - 뷰에서 표시된 *라인*의 <ins>유형, 두께, 색상</ins> 설정
        - 추세선과 참조선을 추가하면 해당 서식 설정 가능
        - 데이터의 <ins>축</ins>

## 49강. 대시보드패널

<!-- 대시보드패널 강의에서 알게 된 점을 적어주세요. -->

- `크기`
    - 현재 대시보드 크기 설정
    - 기본적인 `고정된 크기`, 화면을 채우는 `자동` 크기, 크기 `범위` 중 선택
- `시트`
    - 대시보드에서 사용할 수 있는 워크시트
- `개체`
    - 유용한 개체들
    - 텍스트, 이미지, 웹 페이지 등
- `기기 미리보기`
    - 디바이스별 해상도 설정

## 50. 대시보드 구성방식

<!-- 알게 된 점을 적고, 아래 질문에 답해보세요 :) -->

- 바둑판식
    - 격자무늬 구조에 따라 개체 구성
    - 특정 위치에만 추가할 수 있음
    - 다른 개체의 크기도 변경됨
    - 개체를 자주 추가해야 하는 경우 추천

- 부동
    - 개체를 자유롭게 배치 가능
    - 다른 개체의 크기나 모양에 영향을 주지 않음
    - 대시보드 크기가 자주 변경되지 않는 경우 추천

> **🧞‍♀️ 부동과 바둑판식 방식을, 차이를 중점으로 기술해 보세요**

```
부동은 개체를 자유롭게 배치할 수 있고, 다른 개체의 크기나 모양에 영향을 주지 않는다.
바둑판식은 격자무늬 구조에 따라 특정 위치에만 배치할 수 있으며, 다른 개체의 크기도 같이 변경된다.
```

## 51. 대시보드 컨테이너

- 컨테이너: 대시보드 개체들과 워크시트들을 그룹화하여 구성할 수 있는 공간
    - 가로: 내부의 개체들을 수평 공간으로 배열할 때
    - 세로: 내부의 개체들을 수직 공간으로 배열할 때
    ```
    레이아웃 패널 `항목 계층`에서 제대로 배치했는지 확인할 수 있음
    ```

## 52. 레이아웃 패널

- 제목 표시: 워크시트 제목 표시 여부
- 부동: 부동으로 전환 여부
- 위치
- 크기
- 테두리
- 백그라운드
- 여백
- 항목 계층

## 53. 필터 동작

<!-- 필터 동작에 대해 알게 된 점을 적어주세요 -->

## 54. 대시보드 하이라이터 동작

<!-- 하이라이터에 대해 알게 된 점을 적어주세요 -->


## 55. 대시보드 URL

<!-- URL에 대해 알게 된 점을 적어주세요 -->


## 56. 대시보드 시트에 이동 동작

<!-- 대시보드 시트에 이동에 대해 알게 된 점을 적어주세요!-->

## 57. 매개변수 변경 동작

<!-- 매개변수 변경 동작에 대해 알게 된 점을 적어주세요!-->

## 문제

오늘은 별도의 문제가 없습니다.

![1](https://github.com/yousrchive/BUSINESS-INTELLIGENCE-TABLEAU/blob/main/study/img/3rd%20study/1688556627184.png)

![1](https://github.com/yousrchive/BUSINESS-INTELLIGENCE-TABLEAU/blob/main/study/img/3rd%20study/Global%20SuperStore%20Dashboard.png)

![2](https://github.com/yousrchive/BUSINESS-INTELLIGENCE-TABLEAU/blob/main/study/img/3rd%20study/images.jpeg)
![2](https://github.com/yousrchive/BUSINESS-INTELLIGENCE-TABLEAU/blob/main/study/img/3rd%20study/maxresdefault.jpg)

여러 대시보드를 참고하시어, superstore 데이터를 사용해 나만의 대시보드를 제작해주세요.

**단, 워크시트 3개 이상의 그래프를 표시해야 하며 각 시트 간 상호작용성 필터 or 하이라이트 동작은 꼭 추가되어야 합니다**

어떤 부분에 가중을 두었는지, 어떤 사용자 편의성을 고려하였는지에 대한 설명이 필요합니다.

```
```
<p align="center">
<img src="">
</p>