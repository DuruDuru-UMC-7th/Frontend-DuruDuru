# DuruDUru

## 🗂 목차
1. [기능 소개](#기능-소개)
2. [화면](#화면)
3. [기술 스택](#기술-스택)
4. [컨벤션](#컨벤션)
   
---

## 1. 기능 소개

- 식재료 등록
  - OCR 영수증 인식으로 식재료 등록
  - 직접 추가하는 방식으로 식재료 등록
- 등록된 시재료의 레시피 추천 기능
- 동네 이웃과 품앗이
  - 교환, 나눔으로 품앗이
  - 채팅으로 품앗이 요청

---

## 2. 화면

### **👀  서비스 화면**

| ![IMG_4197](https://github.com/user-attachments/assets/eac0ffac-3f09-4199-a89b-a304f60a118b) | ![IMG_4198](https://github.com/user-attachments/assets/7656e297-2ca0-4ee5-b7d3-8eb93014f11f) | ![IMG_4199](https://github.com/user-attachments/assets/c65b2e23-ab10-4995-a84b-5436ad44a5e8) | ![IMG_4213](https://github.com/user-attachments/assets/086d6a81-451f-44c7-adcf-7aac8c5ca0be) |
|----------------------------------|----------------------------------|----------------------------------|----------------------------------|
| 영수증 식재료 등록                           | 영수증 식재료 등록                           | 직접 식재료 등록                         | 직접 식재료 등록                           |
| ![IMG_4200](https://github.com/user-attachments/assets/b154f654-6847-499c-b2e2-745f012f5a27) | ![IMG_4201](https://github.com/user-attachments/assets/5300d9ba-889a-4ce2-bf88-5570eee1d3f0) | ![IMG_4202](https://github.com/user-attachments/assets/6dcf4e20-8384-4c33-9ca7-f33a4bdbe0fa) | ![IMG_4203](https://github.com/user-attachments/assets/b4b6682a-9b8f-438b-ac11-b8294b0875a0) |
| 식재료 목록 조회                           | 식재료 레시피 추천                           | 식재료 레시피 추천                           | 레시피 상세 화면                          |
| ![IMG_4204](https://github.com/user-attachments/assets/092da8ad-d56e-41ed-a636-99820c8cb9a0) | ![IMG_4205](https://github.com/user-attachments/assets/05d3249b-653f-43a3-a6ae-ea7e66d1f74b) | ![IMG_4208](https://github.com/user-attachments/assets/e876adfd-c907-4f0a-90d4-61df69060bd4) | ![IMG_4210](https://github.com/user-attachments/assets/1c700479-daa7-4583-9e82-4f82ac41960e) |
| 내 동네 설정 화면                           | 동네 품앗이 조회                          | 식재료 품앗이 등록 화면                         | 품앗이 글 상세 화면                         |
| ![IMG_4211](https://github.com/user-attachments/assets/452328a7-f8e7-4808-8613-c97259dcb81b) | ![IMG_4212](https://github.com/user-attachments/assets/9defcdfb-1ec4-4390-90d6-1e7609788bb3) | ![IMG_4215](https://github.com/user-attachments/assets/449875da-a3c4-4a50-b8f9-850e504ebf7c) | ![IMG_4214](https://github.com/user-attachments/assets/6763fa91-eb79-4df8-a308-540954bf2514) |
| 채팅방                          | 마이페이지                          | 회원가입                           | 로그인                          |

---

## 3. 기술 스택

| 분류 | 사용 기술 |
|------|-----------|
| **Language** | Swift |
| **Architecture** | MVC |
| **Network** | Alamofire |
| **UI Framework** | UIKit |
| **Image** | Kingfisher |
| **Library**      | Then, Kingfisher, SnapKit, Alamofire             |

---

## 4. 컨벤션

### 🌿 브랜치 컨벤션

| 브랜치 명 | 용도 |
|-----------|------|
| `main` | 제품 배포 브랜치 |
| `develop` | 통합 개발 브랜치 |
| `feat/` | 새로운 기능 개발 |
| `refac/` | 코드 리팩토링 |
| `hotfix/` | 긴급 수정 |

---

### ❗ 이슈 컨벤션

이슈 제목: [FEAT] 인기 교육 조회 API 구현
```java
## 💡 About
<!--무엇에 관한 이슈인지 소개해주세요.-->

## ✅ To Do
- [ ] task
```
### 🔀 PR 컨벤션

PR 제목: [FEAT] 인기 교육 조회 API 구현

```java
## ⛏ 작업 내용
<!-- 작업한 내용을 간단하게 적어주세요! -->
- 내용

## 📌 PR Point
<!-- 주의할 사항이나 같이 고민해볼 부분, 리뷰를 원하는 부분 등을 적어주세요! -->
- 내용

### ✅ Issue
<!-- 생성한 관련 이슈가 있다면 Resolved #이슈번호로 닫아주세요! -->
Resolved #이슈번호
```
### 📝 커밋 컨벤션

- 커밋 유형은 영어 대문자로 작성하기
    
    
    | 커밋 유형 | 의미 |
    | --- | --- |
    | `Feat` | 새로운 기능 추가 |
    | `Fix` | 버그 수정 |
    | `Docs` | 문서 수정 |
    | `Style` | 코드 formatting, 세미콜론 누락, 코드 자체의 변경이 없는 경우 |
    | `Refactor` | 코드 리팩토링 |
    | `Test` | 테스트 코드, 리팩토링 테스트 코드 추가 |
    | `Chore` | 패키지 매니저 수정, 그 외 기타 수정 ex) .gitignore |
    | `Design` | CSS 등 사용자 UI 디자인 변경 |
    | `Comment` | 필요한 주석 추가 및 변경 |
    | `Rename` | 파일 또는 폴더 명을 수정하거나 옮기는 작업만인 경우 |
    | `Remove` | 파일을 삭제하는 작업만 수행한 경우 |
    | `!BREAKING CHANGE` | 커다란 API 변경의 경우 |
    | `!HOTFIX` | 급하게 치명적인 버그를 고쳐야 하는 경우 |
