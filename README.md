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
- URL Session 을 사용하여 검색어를 Query String 으로 사용해 Naver Open API 에 를 통하여 상품을 검색하고 화면에 표시합니다.
- CollectionView 의 UICollectionViewDataSourcePrefetching 프로토콜을 채택하여 페이지네이션 기능을 구현하였습니다.
- Realm Swift 를 사용해 검색된 상품 썸네일의 우측 하단에 아이콘을 넣어 찜하기 기능을 구현하고 데이터베이스에 저장 할 수 있도록 구현하였습니다.
- 데이터에 찜한 상품 목록을 저장 할 때 썸네일을 Realm 에 저장하여 저장된 목록에서 이미지를 표시 할 수 있도록 하였습니다.
- 상품 검색 결과 화면에서 '찜한 상품' 의 경우 아이콘의 컬러가 변경되어 표시되고 다시 터치 할 경우 '찜하기가 해제' 되고 데이터베이스에서 삭제 할 수 있도록 구현하였습니다.
- 찜하기에 등록된 상품은 애플리캐이션 하단의 찜한 상품을 모은 탭에서 모아서 볼 수 있도록 하였습니다.
- 찜한 상품의 뷰컨트롤러에서 UISearchResultsUpdating 프로토콜을 Conform 하여 저장된 상품의 목록을 실시간으로 검색 할 수 있도록 하였습니다.
- 찜한 상품을 모은 탭에서 등록된 상품을 해제하여 데이터베이스에서 삭제 할 수 있도록 하였습니다.
- 모든 페이지에서 상품 상세 정보에 대해 WebView 에서 상세정보를 볼 수 있으며 네비게이션 영역 우측 상단에 찜한 상품의 여부를 확인 할 수 있도록 아이콘의 컬러를 디스플레이 하였습니다.
- 상품 검색 결과 화면에서 상품을 찜할 때 아이콘이 잠시 커졌다 작아지는 인터렉션을 추가하였습니다.
- 애플의 Network FrameWork 를 사용해 메인화면에서 NetworkMonitor 로 네트워크의 커넥션을 토스트 알림으로 보여주도록 구현하였습니다.

## 개발시 고려 사항 💎
<p>
<img width="20%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/0aac04a0-91aa-4648-b9af-bc2a30edf301"/>
<img width="20%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/0673c4d5-0b3b-4fea-846a-8529913bb925"/>
<img width="20%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/f63d28b6-d689-4cf2-b4f9-c6ef4b227522"/>
<img width="20%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/46cde816-3124-422e-92e6-818b67f30427"/>
</p>
<br>
1.검색된 상품을 '정확도순', '등록일자순', '가격높은순', '가격낮은순' 으로 정렬하는 기능과 선택된 버튼의 표시
<br>
<img width="70%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/e5c2630d-8782-4a2b-acb8-306fcfc40358">

- 필터링 할 버튼을 배열의 Index 로 sender.tag 를 설정하고 버튼의 컬러설정, 애니매이션 동작에 대한 액션을 target 으로 등록했습니다.
<br>

<img width="40%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/f7a1d287-8121-407a-aa9c-7580f4e2a87a">

- 버튼이 선택 되었을 때 버튼 배열의 모든 컬러를 기본컬러(backgroundColor = white, tintCololr = green) 로 설정하고 선택된 버튼만 다른색으로 변경합니다.
<br>

<img width="40%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/85cfb1e0-ae2d-4262-a087-ebb42fea913e">

- 버튼의 컬러가 변경됨과 동시에 선택된 버튼이 커졌다가 작아지는 애니매이션으로 인터렉션을 실행합니다.
<br>

2. 찜한 상품 아이콘 표시 관리
<br>
<p>
<img width="40%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/115a6b45-e10f-482a-8f03-2461d63ff77e">
<img width="30%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/bdb1eb28-091c-460f-b4c5-e11012b86498"/>
</p>

- 프로덕트의 Schema 를 설정하였습니다. 기능 구현 이후 나서 한가지 불필요하다고 느낀 부분으로 굳이 여기에서 isLiked 컬럼을 관리 할 필요가 있었는가 하는 부분입니다.
  저장된 프로덕트의 productID 로 식별하면 될 일을 isLiked 라는 컬럼에서 관리 할 필요가 없엇기 때문입니다. 이는 회고에서 다시한번 언급하겠습니다.
- 셀을 표시 할 때 Realm 에 저장된 productID 가 검색 결과 응답값의 productID 와 같을 경우 찜 아이콘의 컬러가 Red 로 변경되도록 하였습니다.
<br>

3. 찜한 상품의 썸네일 저장과 삭제
<br>
<p>
<img width="40%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/c2e0b967-de33-45be-89fd-da1fc90a5f28">
<img width="40%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/9d0e8a79-1aef-4729-af44-3518f6222f44">
</p>
- Open API 에서 ProductID 로 상품을 검색하는 기능이 없기때문에 상품을 찜했을 때 목록에서 상품을 썸네일을 표시하기 위하여 썸네일을 Realm 에 저장하였습니다.
- Cell 내의 버튼에 대한 Sender.tag 는 고유해야 하므로 productID 를 할당하고 해당 tag 를 가진 버튼이 touch up inside 되었을 때 저장/제거 기능이 동작하도록 하였습니다.
<br>
<br>
4. 찜한 상품 내 검색 기능

<br>
<br>
<p>
<img width="30%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/992e341e-47aa-4d6e-a31a-4027941f15fc"/>
<img width="30%" src="https://github.com/UNICUS-FORTIS/NaverShoppingExplorer/assets/110699030/da56005e-9a2d-4b90-8e93-1eb9961fa021"/>
</p>

- NS Explorer 의 찜한 상품 내 검색 기능은 API 에 엑세스 하지 않고 Local 에서만 동작하므로 뷰컨트롤러에서 UISearchResultsUpdating 프로토콜을 채택하여 UISearchController 에서 실시간 검색 기능을 지원하도록 하였습니다.
<br>
<br>

## 회고
- NS Explorer 는 코딩을 시작하고 얼마 안되어 제작한 매우 심플한 애플리캐이션으로 Naver Open API 를 사용함으로서 Open API 에 대한 심리적 부담감이 사라지고 개발자 문서를 보고 적용하는 태도를 경험할 수 있었습니다.
- CollectionView 의 레이아웃을 선언 할 때 Extension 에 메서드화 하였는데 MVC 아키텍처를 적용했음에도 뷰컨트롤러를 최대한 가볍게 만들기 위한 고민을 할 수 있었습니다.
- Realm Database 를 사용하여 처음으로 Like It 기능을 구현하는데 있어서 isLiked 같은 불필요한 속성을 선언하였습니다. 돌이켜 생각했을 때 불필요한 속성이라는것을 깨닿고 스스로의 행동에서 잘못된점을 찾아 한걸음 앞으로 나아 갈 수 있었습니다.
- API 에서 검색된 상품을 Sort 하는 기능이 제공하기에 상품 정렬 기능을 구현하면서 버튼의 외관, 컬러와 같은 인터렉션 처리를 반복문을 통해 처리하는 방법을 알게되었고 이 외에도 또 다른 방법들이 존재하겠지만 이러한 프로그래밍 로직에 대해 고민 할 수 있는 기회가 되었습니다.
- 약 7개월전에 진행한 프로젝트를 보면서 아직도 많이 미숙하지만 스스로 작성한 코드를 보면서 이때는 왜 이렇게 했을까 라는 포인트들이 보였고 이 코드가 제 코드가 아니라는 가정을 했을 때 개발자의 의도를 다시 한번 파악하려는 열려있는 태도를 가질 수 있었습니다.


