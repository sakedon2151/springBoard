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

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                                <button class="btn btn-outline-danger" onclick="deleteBoard(${boardDTO.id})">삭제하기</button>
                            </td>
                        </tr>
                    </c:if>

                    <tr>
                        <td colspan="3" class="text-center">
                            <a class="btn btn-outline-secondary" href="/board/showAll">목록으로</a>
                        </td>
                    </tr>
                </table>

                <table class="table table-primary table-striped">
                    <tr class="text-center">
                        <th>댓글</th>
                    </tr>
                    <c:forEach items="${replyList}" var="reply">
                        <tr>
                            <td>${reply.id}</td>
                            <td>${reply.nickname}</td>

                            <c:choose>
                                <c:when test="${reply.writerId eq logIn.id}">
                                    <form action="/reply/update/${reply.id}" method="post">
                                        <td>
                                            <input type="text" class="form-control" name="content" value="${reply.content}">
                                        </td>
                                        <td>
                                            <span>
                                                AT <fmt:formatDate value="${reply.modifyDate}" pattern="y년M월d일"/>
                                            </span>
                                        </td>
                                        <td>
                                            <input type="submit" class="btn btn-outline-primary" value="수정">
                                        </td>
                                        <td>
                                            <a href="/reply/delete/${reply.id}" class="btn btn-outline-warning">삭제</a>
                                        </td>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <td>
                                        <input type="text" class="form-control" name="content" value="${reply.content}" disabled>
                                    </td>
                                    <td>
                                        <span>
                                            AT <fmt:formatDate value="${reply.modifyDate}" pattern="y년M월d일"/>
                                        </span>
                                    </td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>

                    <tr>
                        <form action="/reply/insert/${boardDTO.id}" method="post">
                            <td colspan="5">
                                <input type="text" name="content" class="form-control" placeholder="댓글">
                            </td>
                            <td>
                                <input type="submit" class="btn btn-outline-success" value="작성하기">
                            </td>
                        </form>
                    </tr>
                </table>

            </div>
        </div>
    </div>


    <script>
        function deleteBoard(id) {
            Swal.fire({
                title: '정말로 삭제하시겠습니까?',
                showCancelButton: true,
                confirmButtonText: '삭제하기',
                cancelButtonText: '취소',
                icon: 'warning'
            }).then((result) => {
                if (result.isConfirmed) {
                    Swal.fire({
                        title: '삭제되었습니다.'
                    }).then((result) => {
                        location.href='/board/delete/'+id;
                    })
                }
            });
        }
        // 화살표 함수
        // 화살표 함수란, 우리가 함수의 선언식(이름짓기) 없이
        // 해당 함수가 필요로 하는 파라미터만 선언하여 사용하는
        // 함수를 화살표 함수라고 한다.
        // 또는 익명 함수라고도 한다.
        // 사용방법은
        // (파라미터) => {
        //     함수의 내용
        // }
        // 이 된다.
        // 이 화살표 함수는 우리가 객체의 메소드를 정의할 때에도 사용이 가능하다.
        // 예시:
        let smaple = {
            'id': '1',
            'name': '조재영',

            'priceInfo': (id, name) => {
                console.log(id, name);
            }
        }

        // 또한 화살표 함수를 변수에 저장하는 것도 가능하다..
        let sameple2 = (id) => {
            console.log(id);
        }
    </script>
</body>
</html>