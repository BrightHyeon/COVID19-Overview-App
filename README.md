# COVID19-Overview-App
현재 코로나19 현황을 나타내는 앱입니다.

<API를 호출하고 응답받는 fetchCovidOverview()메서드 Description>

- completionHandler 클로저를 전달받을 수 있는 메서드입니다.

- 함수이름(매개변수이름: 매개변수타입) -> 반환값 {}

- 이 메서드는 반환값이 없고, 매개변수타입이 "@escaping (Result<CityCovidOverview, Error>) -> Void"인 클로저입니다.

- 여기서 쓰인 Result는 Generic Enumeration으로 각 case에 성공 또는 실패를 나타내는 관련값을 가집니다.

- 정의: @frozen enum Result<Success, Failure> where Failure : Error

- 첫 번째 제네릭, 즉 요청이 성공하면 CityCovidOverview구조체가 열거형연관값으로 전달되게합니다.

- 두 번째 제네릭, 즉 요청에 실패하거나 에러사항이면 Error객체가 열거형연관값으로 전달되게합니다.

- 상수 url에는 시도별발생동향 API주소를 넣어줍니다.(서비스키값 제외)

- 상수 param에는 딕셔너리를 대입해줍니다. key는 "serviceKey"라 하고, value에는 "서비스키값"을 넣어줍니다.

- 여기서 이를 query형식이라 칭하던데 url주소 뒤의 ?이후 적혀있는 것들을 [String: Any] 형태로 포장합니다. &로 연결되어있다면 딕셔너리 요소를 더 추가해주면됩니다.

- AF.request()는 Alamofire를 이용해서 해당 API를 호출하는 것입니다.

- 맨 첫 자리인 convertible: URLConvertible에는 아까 사이트주소를 저장한 url을 넘겨줍니다.

- 그 다음 method파라미터에는 HTTP메서드를 넣어주면되는데, 지금은 데이터를 받기만 하는 것이니 .get을 사용합니다.

- parameters파라미터에는 요청할 query파라미터를 넣어주면 됩니다. 음... 딕셔너리형태로 파라미터에 전달을 하면 알아서 메서드가  url뒤에 query파라미터를 추가해줍니다.

- 그 외에도 파라미터들이 있지만 필요한 매개변수만 사용할 것이기에 나머지는 다 지워줍니다.

- 이렇게 request메서드를 이용해 API호출을 하였으면 호출한 "응답데이터를 받을 수 있는" responseData메서드를 체이닝해줘야한다.

- responseData(completionHandler: )의 completionHandler를 정의해주면 응답데이터가 클로저파라미터로 전달되게됩니다.

- 요청에 대한 응답결과는 response.result 프로퍼티로 알 수 있습니다. 이때 응답결과가 열거형으로 되어있기에 switch문으로 작성합니다.

- 연관값 부를때는 case let으로 할당해줘야합니다.

- .success 케이스를 부르면 연관값으로 잘 응답받은 JSONdata가 있습니다.

- 응답데이터를 decode하는 decode()메서드는 throws를 지니고있습니다. 오류를 발생시킬 수 있는 것입니다. 그렇기에 try구문으로 시도를 해주고 오류가 나타났을 때 받을 수 있도록 do-catch구문을 사용합니다.

- 즉 1) 응답에 성공했어도 디코딩에 실패했을 때. 2) 응답데이터 호출자체를 실패했을 때 -> .failure를 호출하여 error를 전달하는 것입니다.

- fetchCovidOverview메서드의 파라미터를 Escaping클로저로 선언을 해줍니다. 이는 클로저가 함수를 탈출한다는 의미입니다. 함수의 인자로 클로저가 전달되지만 함수가 반환된 후에도 실행되는 것을 의미합니다.

- 함수의 인자가 함수의 영역 밖으로 탈출하여 밖에서도 사용할 수 있는 개념은 기존에 알고 있는 변수의 스코프개념을 완전히 무시합니다. 함수에서 선언된 로컬변수와 로컬변수의 영역을 뛰어넘어 함수밖에서도 유효하기 때문입니다.

- 대표적인 예로 비동기작업을 하는 경우 completionHandler로 Escaping클로저를 많이 사용합니다. 보통 네트워크 통신은 비동기적으로 작업되기때문에 코드에서와같이 responseData()메서드 파라미터에 정의한 
completionHandler클로저는 fetchCovidOverview함수가 반환된 후에 호출이될것입니다. 
서버에서 데이터를 언제 응답시켜줄지 모르기 때문입니다. 그렇기에 Escaping선언을 해주지않는다면, 서버의 비동기로 응답을 받기 전, 즉 responseData의 completionHandler가 호출되기전에 함수가 종료되어 
서버의 응답을 받아도 우리가 fetchCovidOverview에 정의한 completionHandler가 호출되지않을 것입니다.
