<%@page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
    <title>새 글 작성하기</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous"
    >
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous">
    </script>
    <script src="https://cdn.ckeditor.com/ckeditor5/41.4.2/classic/ckeditor.js"></script> <%-- WYSIWYG --%>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script> <%-- jQuery --%>
</head>
<body>

    <div class="container-fluid">
        <%-- form 태그 --%>
        <form method="post" action="/board/write" enctype="multipart/form-data">
            <div class="row justify-content-center">
                <div class="col-8 mb-3">
                    <input type="text" class="form-control" id="input_title" name="title" placeholder="제목">
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-8 mb-3">
                    <textarea name="content" id="input_content"></textarea>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-6">
                    <label for="input_file">첨부 파일</label>
                    <input type="file" class="form-control" id="input_file" name="file" multiple>
                    <%-- multiple 속성은 파일을 여러개 선택할 수 있다. --%>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-8">
                    <input type="submit" class="btn btn-outline-primary w-100" value="작성하기">
                </div>
            </div>

        </form>
    </div>

    <script>
        ClassicEditor
            .create(document.querySelector('#input_content'))
            .catch(error => {console.log(error);})
    </script>
</body>
</html>