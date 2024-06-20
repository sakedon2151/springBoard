<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<html>
<head>
    <title>${boardDTO.id} | ${boardDTO.title}</title>

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
        <div class="row justify-content-center">
            <div class="col-6">
                <table class="table table-striped">
                    <tr>
                        <th>글번호</th>
                        <td>${boardDTO.id}</td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td>${boardDTO.title}</td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td>${boardDTO.nickname}</td>
                    </tr>
                    <tr>
                        <th>작성일</th>
                        <td><fmt:formatDate value="${boardDTO.entryDate}" pattern="yyyy년 MM월 dd일(E) HH시 mm분 ss초"/></td>
                    </tr>
                    <tr>
                        <th>수정일</th>
                        <td><fmt:formatDate value="${boardDTO.modifyDate}" pattern="yyyy년 MM월 dd일(E) HH시 mm분 ss초"/></td>
                    </tr>

                    <tr>
                        <th colspan="2" class="text-center">- 내용 -</th>
                    </tr>
                    <tr>
                        <td colspan="2">${boardDTO.content}</td>
                    </tr>

                    <%--
                    아래는 조건을 걸어줌으로써 해당 게시물의 writerId 의 값과
                    logIn 유저의 id 값이 같은 경우에만 사이에 있는 태그를 출력
                    --%>
                    <c:if test="${boardDTO.writerId eq logIn.id}">
                        <tr>
                            <td class="text-center" colspan="2">
                                <a class="btn btn-outline-success" href="/board/update/${boardDTO.id}">수정하기</a>
                                <a class="btn btn-outline-danger" href="/board/delete/${boardDTO.id}">삭제하기</a>
                            </td>
                        </tr>
                    </c:if>

                    <tr>
                        <td colspan="3" class="text-center">
                            <a class="btn btn-outline-secondary" href="/board/showAll">목록으로</a>
                        </td>
                    </tr>
                </table>

                ${replyList}
            </div>
        </div>
    </div>

</body>
</html>