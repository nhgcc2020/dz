<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <style>
        @media only screen and (max-width: 1440px) {
            .reg_input {
                margin: 1.5rem 0;
                text-align: left;
            }
            .reg_rcon_padding{

                padding: 1rem 5rem;
            }
            .reg_bnt_mt{
                text-align: center;
                margin-top: 2rem;
            }
            .reg_info_mt{
                margin-top: 3rem;
                text-align: left;
            }
            .reg_log_width{
                width: 180px;
            }
            .li_left{
                margin-top:2px;
                display: inline-block;

            }
            li{
                text-align: left;
            }
        }
        @media only screen and (min-width: 1440px) {
            .reg_logo_margin {
                margin-top: 1rem;
                margin-right: 1rem;
                margin-bottom: 6rem;
            }
            .reg_input {
                margin: 1.5rem 0;
                text-align: left;
            }

            .reg_rcon_padding{
                padding: 1rem 7rem
            }
            .reg_bnt_mt{
                text-align: center;
                margin-top: 2.5rem;

            }
            .reg_info_mt{
                margin-top: 6rem;text-align: left;
            }
            .reg_log_width{
                width: 180px;
            }
            .reg_bnt{
                width: 145px;
                line-height: 35px !important;
                font-size: 1.2rem;
            }

            *{
                font-size: 1.1rem;
            }
            .li_left{
                margin-top:1.5rem ;
                display: inline-block;

            }
            li{
                text-align: left;
            }
        }
    </style>
</head>
    <body style="margin: 20px">
    <!--右边 s-->
    <div style="display: inline-block;background-color: white;height: 100%;text-align: center;" >


        <div class="reg_rcon_padding">
            <div>
                <div class="reg_input" style="text-align: left;padding-bottom: 2rem;">
                    请选择一个大行业（单选项）

                </div>
                <input type="hidden" id="mId" />
                <div  style="border-bottom: 1px solid #2E94E1;text-align: left;padding-bottom: 1rem;margin-bottom: 0.5rem;">
                    <img src="<c:url value="/images/u2.png"/>" onclick="change(this)" name="check_right" data-value="1" style="width: 1.7rem;height: 1.7rem;" />
                    <label style="margin-left: 3rem;vertical-align: super;">
                        泛广告印刷包装行业上下游企业
                    </label >
                </div>
                <ul class="small-block-grid-2 medium-block-grid-3 large-block-grid-4 xlarge-block-grid-4">
                    <li><span class="li_left l-60">广告设计</span></li>
                    <li><span class="li_left l-60">媒体代理</span></li>
                    <li><span class="li_left l-60">喷绘写真</span> </li>
                    <li><span class="li_left l-60">字牌雕刻</span> </li>


                    <li><span class="li_left l-60">条幅制作</span> </li>
                    <li><span class="li_left l-60">婚庆公司</span> </li>

                    <li><span class="li_left l-60">印刷厂</span> </li>
                    <li><span class="li_left l-60">包装厂</span></li>
                    <li><span class="li_left l-60">CTP输出</span> </li>
                    <li><span class="li_left l-60">后道加工</span> </li>
                    <li><span class="li_left l-60">器材租赁</span> </li>
                    <li><span class="li_left l-60">会展公司</span> </li>
                    <li><span class="li_left l-85">广告耗材经销</span></li>
                    <li><span class="li_left l-85">印刷耗材经销</span></li>
                    <li><span class="li_left l-85">广印设备经销</span></li>
                </ul>
            </div>


            <div style="margin-top: 3rem;">
                <div  style="border-bottom: 1px solid #2E94E1;text-align: left;padding-bottom: 1rem;margin-bottom: 0.5rem;">
                    <img src="<c:url value="/images/u48.png"/>" <%--onclick="change(this)"--%> name="check_right" data-value="2" style="width: 1.7rem;height: 1.7rem;" />
                    <label style="margin-left: 3rem;vertical-align: super;">
                        现代服务业
                    </label >
                </div>
                <ul class="small-block-grid-2 medium-block-grid-3 large-block-grid-4 xlarge-block-grid-4">
                    <li><span class="li_left l-60">财务代账公司</span></li>
                    <li><span class="li_left l-60">孵化器/众创空间</span></li>
                    <li><span class="li_left l-60">
互联网软件行业
</span> </li>
                    <li><span class="li_left l-60">培训教育行业</span> </li>
                </ul>
            </div>

            <div style="margin-top: 3rem;">
                <div  style="border-bottom: 1px solid #2E94E1;text-align: left;padding-bottom: 1rem;margin-bottom: 0.5rem;">
                    <img src="<c:url value="/images/u48.png"/>" <%--onclick="change(this)"--%> name="check_right" data-value="3" style="width: 1.7rem;height: 1.7rem;" />
                    <label style="margin-left: 3rem;vertical-align: super;">
                        其他行业
                    </label >
                </div>
                <ul class="small-block-grid-2 medium-block-grid-3 large-block-grid-4 xlarge-block-grid-4">
                    <li><span class="li_left l-60">数码3C类</span></li>
                    <li><span class="li_left l-60">家用电器</span></li>
                    <li><span class="li_left l-60">五金建材</span> </li>
                    <li><span class="li_left l-60">文体用品</span> </li>

                    <li><span class="li_left l-60">家居装饰</span></li>
                    <li><span class="li_left l-60">电子电气</span></li>
                    <li><span class="li_left l-60">汽修汽配</span> </li>
                    <li><span class="li_left l-60">母婴用品</span> </li>
                </ul>
            </div>
            <div class="reg_bnt_mt">
                <!--Next需要加icon-->
                <div c-widget="button; color:teal; caption:下一步 &nbsp;&nbsp;&nbsp; >;" class="reg_bnt" onclick="save()"></div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function save() {
            window.location.href="<c:url value="/reg/detail-industry"/>";
        }
    </script>
    </body>
</html>
