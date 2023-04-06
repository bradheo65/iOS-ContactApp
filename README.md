# iOS-ContactApp

## 🖥️ 프로젝트 소개

- Open API에 저장된 정보로 표현한 연락처 iOS 앱 프로젝트 입니다. 

## 🕰️ 개발 기간

- 2023.02.10 ~ 2023. 03. 02 (21일)

## 🧑🏻‍💻 개발 멤버(1인)

- [브래드](https://github.com/bradheo65)
    
## ⚙️ 개발 환경

- 최소 타겟 버전: iOS 15.0
- 라이브러리 관리: Swift Package Manager(SPM)

## 🛠️ Architecture

- MVC

## 📖 사용 라이브러리

- SnapKit

## 📚 Open API Server
    
- 사람 정보(https://jsonplaceholder.typicode.com/users)
- 랜덤 사람 이미지(https://pravatar.cc/)
    
## 📌 주요 기능

- UITableViewDiffableDataSource
- REST API

## 📝 접목 기술
    
- `MVC (View, Model, ViewController)`: 현재 ViewController 2개로 많지 않고, Data관련 로직이 많이 필요하기 않기 때문에 MVC 패턴으로 프로젝트 진행

- `SnapKit사용`: View AutoLayout 구성 시 작성해야할 코드를 줄여주고, 가독성 증가를 위해 선택

- `View 간 데이터 전달 방식`: 데이터 전달이 필요한 경우가 상위View -> 하위View로 진행되어 메소드 또는 .init()으로 데이터 전달하는 방법으로 진행

- `UITableViewDiffableDataSource`: 자연스러운 UI 업데이트로 인해 사용자 경험(UX)을(를) 높일 수 있고, 새로운 기술을 Study와 적용하기 위해 선택

## 📱 View 구조

|`메인 View`|
|:---:|
|<image src = "https://i.imgur.com/jJnIUCI.png" width="800" height="400">|

|`상세 View`|
|:---:|
|<image src = "https://i.imgur.com/r51PAS5.png" width="800" height="400">| 
