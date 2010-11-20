<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8" />
        <title>Solr Demo</title>
        <!-- add your meta tags here -->

        <link href="/solr-demo/css/my_layout.css" rel="stylesheet" type="text/css" />
        <!--[if lte IE 7]>
        <link href="/solr-demo/css/patches/patch_my_layout.css" rel="stylesheet" type="text/css" />
        <![endif]-->
    </head>
    <body>
        <div class="page_margins">
            <div class="page">
                <div id="header">
                    <h1>Suche mit Solr</h1>
                    <form action="/solr-demo/app/search">
                        <p>
                            <label for="searchform_search">Ihre Suche:</label>
                            <input id="searchform_search" type="text" name="query" value="<c:out value="${param.query}"/>"/>
                            <input type="submit" name="submit" value="Los!" />
                        </p>
                    </form>
                </div>
                <div id="main">
                    <div id="col1">
                        <div id="col1_content" class="clearfix">
                            <c:if test="${not empty facetValues}">
                                <ul>
                                    <%-- prepare additional keywords --%>
                                    <c:forEach var="keyword" items="${paramValues['keyword']}">
                                        <c:set var="keywordParams">${keywordParams}&keyword=${keyword}</c:set>
                                    </c:forEach>
                                    <c:forEach var="facet" items="${facetValues}">
                                        <c:set var="url">/solr-demo/app/search?query=<c:out value="${param.query}"/>&amp;keyword=<c:out value="${facet.name}"/><c:out value="${keywordParams}"/></c:set>
                                        <li><a href="${url}"><c:out value="${facet.name}"/> (${facet.count})</a></li>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </div>
                    </div>
                    <div id="col3">
                        <div id="col3_content" class="clearfix">
                            <c:if test="${not empty results}">

                                <p>${fn:length(results)} Ergebnisse gefunden.</p>

                                <c:forEach items="${results}" var="hit">

                                    <div class="searchresult">
                                        <h3>
                                            <c:choose>
                                                <c:when test="${not empty hit.title}">
                                                    <c:out value="${hit.title}"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:out value="${hit.id}"/>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                        </h3>
                                        <p>
                                            <c:forEach var="entry" items="${highlighting[hit.id]}">
                                                <c:forEach var="snippet" items="${entry.value}">
                                                    <c:out value="${snippet}" escapeXml="false"/>
                                                </c:forEach>
                                            </c:forEach>
                                        </p>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                        <!-- IE Column Clearing -->
                        <div id="ie_clearing"> &#160; </div>
                    </div>
                </div>
                <!-- begin: #footer -->
            </div>
        </div>
    </body>
</html>

