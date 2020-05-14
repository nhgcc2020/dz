<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
</head>
<style>
    li {
        text-align: left;
        margin-top: 1.5rem;
    }
    @media only screen and (max-width: 1440px) {
        .reg_input {
            margin: 1.5rem 0;
            text-align: left;
        }
        .reg_rcon_padding {
            padding: 1rem 5rem;
        }
        .reg_bnt_mt {
            text-align: center;
            margin-top: 2rem;
        }
        .reg_info_mt {
            margin-top: 3rem;
            text-align: left;
        }
        .reg_log_width {
            width: 180px;
        }
    }

    @media only screen and (min-width: 1440px) {
        .reg_logo_margin {
            margin-top: 1rem;
            margin-right: 1rem;
            margin-bottom: 8rem;
        }
        .reg_input {
            margin: 1.5rem 0;
            text-align: left;
        }
        .reg_rcon_padding {
            padding: 1rem 7rem
        }
        .reg_bnt_mt {
            text-align: center;
            margin-top: 12.8rem;
        }
        .reg_info_mt {
            margin-top: 6rem;
            text-align: left;
        }
        .reg_log_width {
            width: 180px;
        }
        .reg_bnt {
            width: 145px;
            line-height: 35px !important;
            font-size: 1.2rem;
        }
        * {
            font-size: 1.1rem;
        }
        .li_left {
            margin-top: 1.5rem;
            display: inline-block;
        }
    }

    .dll_selected{
        text-align: center;background: #2196F3;color:white;padding: 10px;width: 100%;display: inline-block;
    }


    .dll_udselected{
        text-align: center;background: #76838F;color:white;padding: 10px;width: 100%;display: inline-block;
    }
    .check_icon{
        width: 1.7rem;vertical-align: bottom;
    }
    .dl_selected{
        border-bottom: 1px solid ;padding-bottom: 1rem;margin-bottom: 0.5rem;border-color: #2E94E1;
    }
    .dl_unselected{
        border-bottom: 1px solid ;padding-bottom: 1rem;margin-bottom: 0.5rem;border-color: #76838F;
    }

</style>
<body>

<div style="display: inline-block;background-color: white;height: 100%;text-align: center;" >

<div class="reg_rcon_padding">
    <div class="reg_input" style="text-align: left;">
        请选择一个小行业，我们会提供符合行业特点的功能与服务！

    </div>
    <c:forEach items="${industrys}" var="indus" varStatus="stat">
        <!---->
        <div style="text-align: left;margin-top: 3rem;">
            <!--左边部分 start-->
            <div style="display: inline-block">
                <img
                        <c:choose>
                            <c:when test="${stat.first}">
                                src="<c:url value="/images/u2.png"/>"
                            </c:when>
                            <c:otherwise>
                                src="<c:url value="/images/u48.png"/>"
                            </c:otherwise>
                        </c:choose>
                        class="check_icon"
                />
            </div>
            <!--左边部分 end-->
            <!--右边部分 start-->
            <div style="display: inline-block;margin-left: 1.5rem;width: 75%">
                <div
                        <c:choose>
                            <c:when test="${stat.first}">
                                class="dl_selected"
                            </c:when>
                            <c:otherwise>
                                class="dl_unselected"
                            </c:otherwise>
                        </c:choose>
                >
                    <label
                            <c:choose>
                                <c:when test="${stat.first}">
                                    class="dll_selected"
                                </c:when>
                                <c:otherwise>
                                    class="dll_udselected"
                                </c:otherwise>
                            </c:choose>
                    >
                            ${indus.industryName}
                    </label >
                </div>
                <ul class="small-block-grid-1 dium-block-grid-1 large-block-grid-1 xlarge-block-grid-1">
                    <c:forEach var="in" items="${indus.indus}">
                        <li>
                            <div c-widget="Checkbox;class:sIndusId;label:${in.industryName};value:${in.industryId}"></div>
                        </li>

                    </c:forEach>

                        <%--<li>
                            <div c-widget="Checkbox; label:综合媒体代理发布"></div>
                        </li>--%>
                </ul>
            </div>
            <!--右边部分 end-->
        </div>
        <!---->
    </c:forEach>

    <div class="reg_bnt_mt">
        <!--Next需要加icon-->
        <div c-widget="button; color:teal; caption:下一步 &nbsp;&nbsp;&nbsp; >;" class="reg_bnt" onclick="save()"></div>
    </div>
</div>
</div>
<script type="text/javascript">
    function save() {
        var ids = "";
        $(".sIndusId").each(function(index){
            if(index == 0){
                ids =$(this).val();
            }else{
                ids =ids+","+$(this).val();
            }
        })
        $.post("<c:url value="/company/saveSIndus"/>",{ids:ids},function (data) {
            if(data=="succ"){
                alert("成功");
            }else{
                slert("失败");
            }
        })

    }
</script>
</body>
</html>
