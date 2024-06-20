<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<html>
<head>
    <title>게시판</title>

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
        .clickableTr{
            cursor: pointer;
        }
        .clickableTr:hover>td{
            color: blue;
            text-decoration: underline;
        }
        .clickableTr:hover>td:nth-child(4) {
            color: black;
            text-decoration: none;
        }

        /*.paginationTr a{*/
        /*    display: inline-block;*/
        /*    width: 30px; height: 30px;*/
        /*    color: #999;*/
        /*    text-decoration: none;*/
        /*    border: 1px solid #999;*/
        /*    border-radius: 3px;*/
        /*    font-size: 13px;*/
        /*    line-height: 28px;*/
        /*}*/
        /*.paginationTr a:hover{*/
        /*    color: black;*/
        /*    background-color: #eeeeee;*/
        /*}*/
    </style>
</head>
<body>

    <div class="container-fluid">
        <div class="main h-100">
            <%--
                taglib c 는 기본적으로 JSP 에서 자바 코드 대신 Marked-up Language 형식으로
                변수의 값, 조건문, 반복문, 등을 출력할 수 있도록 만들어주는 태그 라이브러리 이다.
            --%>

            <%--
                가장 대표적으로 사용할 수 있는 Core 태그는 바로 ForEach 태그이다.
                바로 반복문 이다.

                item 어트리뷰트에는 순차적으로 꺼내올 콜렉션 개체를 지정한다.
                var 어트리뷰트는 하나씩 뽑아온 것을 뭐라고 호칭할지 지정한다.
                즉, 아래의 forEach 태그는
                for (BoardDTO b : list) {
                }
                와 같은 의미가 된다.

                fmt 는 formatter 와 관련이 있다.
                주로 시간의 포맷을 정할때 사용된다.
            --%>

            <div class="row justify-content-center">
                <div class="col-8 text-center">
                    <table class="table table-striped">
                        <tr>
                            <th>글 번호</th>
                            <th colspan="3">제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                        </tr>

                        <c:forEach items="${list}" var="b">
                            <tr class="clickableTr" onclick="javascript:location.href='/board/showOne/${b.id}'"> <%-- onclick action --%>
                                <td>${b.id}</td>
                                <td colspan="3">${b.title}</td>
                                <td>${b.nickname}</td>
                                <td><fmt:formatDate value="${b.entryDate}" pattern = "yyMMdd HH:mm:ss"/></td>
                            </tr>
                        </c:forEach>

                        <tr>
                            <td colspan="6">
                                <ul class="pagination justify-content-center">

                                    <li class="page-item">
                                        <a class="page-link" href="/board/showAll/1"> ≪ </a>
                                    </li>

                                    <c:if test="${curPage > 5}">
                                        <li class="page-item">
                                            <a class="page-link" href="/board/showAll/${curPage - 5}"> < </a>
                                        </li>
                                    </c:if>

                                    <c:forEach var="page" begin="${startPage}" end="${endPage}">
                                        <c:choose>
                                            <c:when test="${page eq curPage}">
                                                <li class="page-item">
                                                    <a class="page-link" href="/board/showAll/${page}">[${page}]</a>
                                                </li>
                                            </c:when>

                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="/board/showAll/${page}">${page}</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>

                                    <c:if test="${curPage < maxPage - 5}">
                                        <li class="page-item">
                                            <a class="page-link" href="/board/showAll/${curPage + 5}"> > </a>
                                        </li>
                                    </c:if>

                                    <li class="page-item">
                                        <a class="page-link" href="/board/showAll/${maxPage}"> ≫ </a>
                                    </li>

                                </ul>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="row justify-content-end">
                <div class="col-3">
                    <a class="btn btn-outline-success" href="/board/write">글 작성하기</a>
                </div>
            </div>

        </div>
    </div>

</body>
</html>