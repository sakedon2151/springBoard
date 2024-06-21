<%@page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
    <title>인덱스</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous"
    >
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous">
    </script>

    <style>
        .logo{}
        .logo>img{
            width: 50px;
            height: 50px;
        }
    </style>
</head>
<body>

    <div class="container-fluid">
        <div class="main h-100">

            <div class="row justify-content-center">
                <div class="col-6 text-center">
                    <a href="" class="logo">
                        <img src="/logo_blue.png" alt="로고 이미지">
                    </a>
                </div>
            </div>

            <form action="/user/auth" method="post">

                <div class="row justify-content-center">
                    <div class="col-4">
                        <label for="username">아이디</label>
                        <input type="text" class="form-control" name="username" id="username">
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-4">
                        <label for="password">비밀번호</label>
                        <input type="password" class="form-control" name="password" id="password">
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-2 text-center">
                        <input type="submit" class="btn btn-outline-primary" value="로그인">
                    </div>
                    <div class="col-2 text-center">
                        <a href="/user/register" class="btn btn-outline-secondary">회원가입</a>
                    </div>
                </div>

            </form>
        </div>
    </div>

</body>
</html>