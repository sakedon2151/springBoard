<%@page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
    <title>회원 가입</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous"
    >
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script> <%-- jQuery --%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

    <div class="container-fluid h-100">
        <form action="/user/register" method="POST">
            <div class="row justify-content-center">
                <div class="col-4">
                    <label for="username">아이디</label>
                    <input type="text" name="username" id="username" class="form-control" oninput="disableButton()">
                    <button type="button" class="btn btn-outline-primary" onclick="validateUsername()">중복확인</button>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-4">
                    <label for="password">비밀번호</label>
                    <input type="password" name="password" id="password" class="form-control">
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-4">
                    <label for="nickname">닉네임</label>
                    <input type="text" name="nickname" id="nickname" class="form-control">
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-4 text-center">
                    <input type="submit" id="btnSubmit" class="btn btn-outline-primary" value="회원 가입" disabled>
                </div>
            </div>
        </form>
    </div>

    <script>
        // jQuery 의 경우, 우리가 HTML DOM 객체를 선택할 때 사용하던
        // document.selectElement... 들을 간단하게 $() 로 사용하게 된다.

        // 일반 js 방식
        // let username = document.getElementById('username');
        // jQuery 방식
        // let username = $('#username');

        // jQuery 는 $() 로 선택된 객체의 속성값들을 수정할 수 있게 도와주는 함수가 다수 준비되어있다.

        // --- 해당 엘리먼트에 값을 넣는다.
        // $('#username').val('jQuery 로 입력함');

        // --- 해당 엘리먼트에 css를 적용. 여러 값을 적용하는 경우 중괄호로 감싼다.
        // $('#username').css({
        //     'color': 'red',
        //     'font-size': '32px'
        // });

        // --- 해당 엘리먼트의 속성을 적용한다.
        // $('#username').attr('disabled', 'true');

        function validateUsername() {
            let username = $('#username').val();
            $.ajax({
                url: '/user/validateUsername',
                type: 'get',// http 에서 메소드 타입? post, get, delete, put
                data: {
                    'username': username
                },
                success: (result) => { // result 값은 rest controller 에서 옵니다.
                    if (result.result === 'success') {
                        // 가입가능
                        Swal.fire({
                            'title': '가입 가능한 아이디입니다.',
                            'icon': 'success'
                        }).then(() => {
                            $('#btnSubmit').removeAttr('disabled');
                        })
                    } else {
                        // 가입불가
                        console.log('가입 불가능한 아이디')
                        Swal.fire({
                            'title': '중복된 아이디입니다.',
                            'icon': 'warning'
                        })
                    }
                }
            });
        }

        function disableButton() {
            $('#btnSubmit').attr('disabled', 'true');
        }
    </script>
</body>
</html>