# <p align="center">NS Exploror 🛍</p>
<p align="center">

<img width="30%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/8280d8b5-db00-4b62-aabf-b1ba553b0a0d"/>

#### <p align="center">NS Explorer는 Naver Open API 를 이용한 상품 검색 애플리캐이션입니다.<br></br></p>

<p>
<img width="19%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/75573c84-7e46-4df0-a1d4-a3425a87b8a0"/>

<img width="19%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/b14144a1-231b-42d9-9a77-fb1d4385e4fa"/>

<img width="19%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/b8db8a3e-9b81-4f04-8931-0608b29d8e43"/>

<img width="19%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/49d0001c-f880-4f28-9db7-243d4fc507ec"/>

<img width="19%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/083e49da-4fa1-46cb-a26e-acf4aee0847d"/>
</p>

## 프로젝트 기간 🎀 
2023.09.07 ~ 2023.09.11

## 프로젝트 구분 🎀
미출시 솔로 프로젝트
 
## Main Features ✨
- Product Search with Naver Open API
- [Add / Remove] Product 'Like it'
- Search Product in 'Like it' tab
- Product on WebView

## Tech Stacks 🛠
- CodeBase UIKit
- MVC Architecture
- URL Session
- Realm Swift
- SnapKit
- Kingfisher
- TextFieldEffects
- NetworkMonitor

## 주요 기술 🌖
- Naver Open API 에 URL Session 을 사용하여 검색어를 Query String 으로 사용해 상품을 검색하고 화면에 표시합니다.
- 검색된 상품을 '정확도순', '등록일자순', '가격높은순', '가격낮은순' 으로 정렬 할 수 있습니다.
- Realm Swift 를 사용해 검색된 상품 썸네일의 우측 하단에 아이콘을 넣어 찜하기 기능을 구현하고 데이터베이스에 저장 할 수 있도록 구현하였습니다.
- 상품 검색 결과 화면에서 '찜한 상품' 의 경우 아이콘의 컬러가 변경되어 표시되고 다시 터치 할 경우 '찜하기가 해제' 되고 데이터베이스에서 삭제 할 수 있도록 구현하였습니다.
- 찜하기에 등록된 상품은 애플리캐이션 하단의 찜한 상품을 모은 탭에서 모아서 볼 수 있도록 하였습니다.
- 찜한 상품을 모은 탭에서 등록된 상품을 해제하여 데이터베이스에서 삭제 할 수 있도록 하였습니다.
- 모든 페이지에서 상품 상세 정보에 대해 WebView 에서 상세정보를 볼 수 있으며 네비게이션 영역 우측 상단에 찜한 상품의 여부를 확인 할 수 있도록 아이콘의 컬러를 디스플레이 하였습니다.
- 상품 검색 결과 화면에서 상품을 찜할 때 아이콘이 잠시 커졌다 작아지는 인터렉션을 추가하였습니다.
- 애플의 Network FrameWork 를 사용해 메인화면에서 NetworkMonitor 로 네트워크의 커넥션을 토스트 알림으로 보여주도록 구현하였습니다.

  
