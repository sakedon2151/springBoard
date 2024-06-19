<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<html>
<head>
    <title>${boardDTO.id} | 게시물 수정하기</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous"
    >
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous">
    </script>
</head>
<body>

    <div class="container-fluid">
        <form action="/board/update/${boardDTO.id}" method="post">

            <div class="row justify-content-center">
                <div class="col-8 mb-3">
                    <input type="text" class="form-control" id="input_title" name="title" placeholder="제목" value="${boardDTO.title}">
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-8 mb-3">
                    <textarea name="content" id="input_content" class="form-control" placeholder="내용">${boardDTO.content}</textarea>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-8">
                    <input type="submit" class="btn btn-outline-primary w-100" value="수정하기">
                </div>
            </div>

        </form>
    </div>

</body>
</html>