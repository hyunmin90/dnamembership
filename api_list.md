# 필요 API

## Console

#### console
* 나의 App 목록
  * path : GET /rest/openapi/apps?userId={userId}
  * req : userid
  * res : list[앱 레벨, 권한]
* API Health
  * 내가 사용하는 API의 상태
  * path : GET /rest/openapi/health?userId={userId}
  * req : userid
  * res : list[api, api상태]

#### console-app
* App 상세
  * path : GET /rest/openapi/apps/{appId}
  * req : appId
  * res :
    * 기본정보 - 앱이름, 앱ID, 앱URL, 앱설명, 앱레벨, 나의권한
    * 팀 정보 - 소유자,개발자,사용자
    * 사용 API - 사용하는 API와 각 API의 사용량
    * Restriction + apikey

#### console-app-team
* 팀 관리
  * 팀원 목록 조회 - **등록일(필요한가요?)**, **등급(사용자 등급은 어디에 저장되나요?)**
  * path : GET /rest/openapi/apps/{appId}/users
  * req : appId
  * res : 담당자 list[userid], 참조자 list[userid],
* 권한 변경
  * 개발자 -> 사용자 등
  * path : POST /rest/openapi/apps/{appId}/users?userId={userId}&auth={auth}
  * req : userid, auth (개발자,사용자,관리자 등 ENUM으로 생성 예정)
  * res : T/F
* 등급 조회
  * **제휴 관리자 서비스에서 조회**
  * req : userid
  * res : 닉네임, 등급

#### console-app-team-addmember

* 초대 요청
  * path : POST /rest/openapi/invitations?appId={appId}userId={userId}&auth={auth}
  * req : appId, userId, auth
  * res : random token
* 초대 컨펌
  * path : POST /rest/openapi/invitations?token={token}
  * res : T/F

##### 아래 내용은 API가 아니라 Process입니다.

* 팀원 추가
  * apibook에 초대요청 API 호출, random으로 생성된 token을 받음
  * daum메일 계정으로 초대, 초대시 confirm link를 제공 - developers.daum.net/invite?token={token} 식으로
  * 개발자/사용자
* 초대장 발송
  * 초대컨펌 링크를 포함한 메일 발송
* 초대받은 사람의 confirm
  * 전달받은 token으로 apibook의 초대 컨펌 API를 호출. apibook에서 기존에 요청되었던 app에 userId등록
  * 이때 팀으로 등록됨.


#### console-app-team-deletemember
* 팀원 삭제
  * 팀에서 삭제
  * path : DELETE /rest/openapi/apps/{appId}/users/{userId}
  * req : appId, userid
  * res : T/F

#### console-app-apikey
* Restriction 상세 조회
  * path : GET /rest/openapi/apps/{appId}/restrictions
  * req : appId
  * res : 구분, apikey, whitelist, 생성일
* OAuth Client 조회
  * path : GET /rest/openapi/apps/{appId}/oauthClients
  * req : appId
  * res : secret ID, secret PW, callback url 등

#### console-app-apis
* 전체 API 목록
  * path : GET /rest/openapi/apis
  * req : X
  * res : API명, Policy, Policy별 quota
* 사용중인 API의 사용량 조회
  * path : GET /rest/openapi/usage?appId={appId}&providerId={providerId}
  * req : appId, providerId
  * res : call, quota

#### console-app-statistics
* App 통계 조회
  * path : GET /rest/openapi/apps/{appId}/statistics?from={from}&to={to}
  * req : appId, from, to (옵션, 없으면 7일)
  * res : 기간 통계 데이터

#### console-app-create
* App 생성
  * path : POST /rest/openapi/apps + body
  * req : name
  * res : appId, name, etc...

#### console-app-delete
* App 삭제
  * path : DELETE /rest/openapi/apps/{appId}
  * req : appId
  * res : T/F

#### console-app-contentscreen
* OAuthClient 수정
  * path : POST /rest/openapi/apps/{appId}/oauthClients/{clientId} + body
  * req : clientId, 변경 field들
  * res : 변경된 OAuthClient

#### console-app-contentscreen-prereview
* OAuthClient 조회
  * 중복 - console-app-apikey에 존재

#### console-app-apikey-addcallbackURL
* OAuth callback URL 추가
  * path : POST /rest/openapi/apps/{appId}/oauthClients/{clientId}/callbackUrls?url={url}
  * req : 추가되는 callback URL
  * res : 변경된 OAuthClient

#### console-app-apikey-addapi
* Appkey+Restriction 추가
  * path : POST /rest/openapi/apps/{appId}/restrictions?platform={platform}&whitelist={whitelist}
  * req : 플랫폼, whitelist(IP, referer 등)
  * res : appkey, 플랫폼, whitelist

#### affiliate center
* 제휴 회사 및 담당자 정보 추가
  * doamin : manage.daumtools.com
  * path : POST /rest/affiliate/company?userId={userId}&link={link}&contactName={contactName}&contactLevel={contactLevel}&contactEmail={contactEmail}&contactPhone={contactPhone}
  * req : userId, link, contactName, contactLevel, contactEmail, contactPhone
  * res : 변경된 Company

* 제휴기능 신청 목록
  * doamin : manage.daumtools.com
  * path : GET /rest/affiliate/{userId}/feature
  * req : userId
  * res : list[app, feature, featureState]

* 제휴기능 신청
  * doamin : manage.daumtools.com
  * path : POST /rest/affiliate/affiliate/{userId}/feature/{featureId}?reason={reason}
  * req : userId, featureId, reason
  * res : list[app, feature, featureState]

* 제휴관련 대화 조회(최근 30개만 보임)
  * doamin : manage.daumtools.com
  * path : GET /rest/affiliate/{userId}/chat
  * req : userId
  * res : list[Sender, message, messageType, created]

* 제휴관련 대화 전송
  * doamin : manage.daumtools.com
  * path : POST /rest/affiliate/chat?userId={userId}&message={message}&attachFile={attachFile}
  * req : userId, message, attachFile
  * res : list[Sender, message, messageType, created]
  
## global
* 나의 App 목록
  * 중복 - console에 존재

## affiliate
* 제휴 Policy 생성
  * path : POST /rest/openapi/providers/{providerId}/policies + body
  * req : providerId, policy_name, map[apiId:quota]
  * res : 변경된 Provider

## MemberShip
* 사용자 멤버쉽 정보
  * doamin : manage.daumtools.com
  * path : GET /rest/membership/{userId}
  * req : userId
  * res : level, badges