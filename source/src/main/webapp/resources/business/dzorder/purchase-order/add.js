// 保存采购单url config 全局配置
var savePurchaseUrl="/ydz/purchaseorder/addOrder";
var mainPurchaseUrl="/openPage?pageName=advert_purchase-order-list&type=";// 跳转到主界面
var savePaymentPurchaseUrl="/ydz/purchaseorder/addAndPayment";
var vendorListUrl="/ydz/purchaseorder/supplier";// 获取供应商下拉框
var contactListUrl="/system/partner/listPartnerContacter";// 获取联系人下拉框
// 统一配置页面的table显示的column
var jsonCl='[{"columns":["businessDesc","requirements","length","width","priceWay","quantity","unit","unitPrice","additionalService","additionalPrice","totalPrice"],"label":"通用类","modelName":"model00","type":"00"}]';
var globDtCl;
(function () {
    cola(function (model) {
        ///////////////////////////////model层  start////////////////////////////////////////////////////
        //上传栏提示信息
        model.set("uploadNote", "可以一次上传多个文件");
        model.set("purchaseOrder", {
            "partnerKey": "",
            "partnerName": "",
            "caseDesc": "",
            //本单金额
            "price":0,
            //折扣优惠比例
            "discountRate":0,
            //折扣优惠
            "discount":0,
            //减免
            "preferential":0,
            //合计金额
            "totalPrice":0,
            //预收金额
            "depositRequested":0,
            //应收金额
            "receivablesMoney":0
        });

        //计价方式
        model.set("options", [
            {
                value: "01",
                text: "按面积"
            }, {
                value: "02",
                text: "按数量"
            }, {
                value: "03",
                text: "按长度"
            }, {
                value: "04",
                text: "按宽度"
            }, {
                value: "05",
                text: "按较大值"
            }, {
                value: "06",
                text: "较大值平方"
            }]);
        //金额结算
        model.set("order", {
            //折扣百分比
            sales: 0,
            //减免
            minus: 0,
            //本单金额
            source: 0,
            //
            amount: 0
        });
        ///////////////////////////////////model层  end////////////////////////////////////////////////
        var createTable, fields, i, len, orderMap, tag, tagMap, tags, tbody_dom;
        //所有表格的配置列
        fields = {
            checkingNo: {
                property: "checkingNo",
                caption: "销售对账单编码",
                template: "input-column"
            },
            salesNo: {
                property: "salesNo",
                caption: "销售订单编码",
                template: "input-column"
            },
            itemNo: {
                property: "itemNo",
                caption: "行序号",
                template: "input-column"
            },
            businessType: {
                property: "businessType",
                caption: "业务类型",
                template: "input-column",
            },
            businessDesc: {
                property: "businessDesc",
                caption: "业务内容",
                template: "business-desc",//business-desc
                /*width: "200px"*/
                width: "240px"
            },
            requirements: {
                property: "requirements",
                caption: "物料/制作/说明",
                template: "input-column",//require-column
                width: "220px"
            },
            specification: {
                property: "specification",
                caption: "规格",
                template: "input-column"
            },
            length: {
                property: "length",
                caption: "长(米)",
                template: "valuation-column",
                width: "60px"
            },
            width: {
                property: "width",
                caption: "宽(米)",
                template: "valuation-column",
                width: "60px"

            },
            priceWay: {
                property: "priceWay",
                caption: "计价方式",
                template: "select-column",
                width:"105px"
            },
            colorSize: {
                property: "colorSize",
                caption: "色数",
                template: "input-column"
            },
            pairsNum: {
                property: "pairsNum",
                caption: "付数",
                template: "input-column"
            },
            quantity: {
                property: "quantity",
                caption: "数量",
                template: "valuation-column",
                width: "60px"
            },
            unit: {
                property: "unit",
                caption: "单位",
                template: "input-column",
                width: "60px"

            },
            unitPrice: {
                property: "unitPrice",
                caption: "单价(元)",
                template: "valuation-column",
                width: "100px"
            },
            totalPrice: {
                property: "totalPrice",
                caption: "行小计",
                template: "input-column",
                width:"130px"
            },
            remarks: {
                property: "remarks",
                caption: "备注",
                width:"100px",
                template: "input-column"
            },
            orderStatus: {
                property: "orderStatus",
                caption: "订单状态",
                template: "input-column"
            },
            isUrgent: {
                property: "isUrgent",
                caption: "是否加急",
                template: "input-column"
            },
            isValid: {
                property: "isValid",
                caption: "是否有效",
                template: "input-column"
            },
            isDel: {
                property: "isDel",
                caption: "是否删除",
                template: "input-column"

            },
            creator: {
                property: "creator",
                caption: "创建者",
                template: "input-column"
            },
            createTime: {
                property: "createTime",
                caption: "创建时间",
                template: "input-column"
            },
            operation: {
                caption: "操作",
                template: "operation-column",
                width: "60px",
                align: "center"
            }
        };
        orderMap = {};
        tagMap = {};

        $.ajax({
            url:'/order/listBusinessTypeVO',
            type:'GET',
            async:false,
            data:"", //传递参数
            dataType:"json",
            success:function(data){
                model.set("tags",data);
                 globDtCl=data;
            },
            error:function(){
                $("<div class='error_tips'>").fadeIn(250).html("数据请求失败").delay(500).fadeOut(250).appendTo("body");
            }
        });

        model.get("tags", function (tags) {
            tags.each(function (element, index) {
                //tag = tags[i];
                tagMap[element.get("modelName")] = element;
            })
        });
        model.set("ranges", {});
        model.widgetConfig({
            tableDropDown: {
                $type:"Dropdown",
                items: "{{country in options}}",
                valueProperty: "value",
                textProperty: "text",
                /*readOnly:true,*/
                //默认按面积计价
                value:"01"
            },



            priceTable: {
                $type: "Table",
                bind: "prices",
                showHeader: true,
                highlightCurrentItem: true,
                currentItem: "",
                "class": "celled compact",
                columns: [
                    {
                        width: "40px",
                        caption: "序号",
                        bind: ".index",
                        align: "center"
                    },
                    {
                        caption: "物料/制作/说明",
                        bind: ".categoryDesc",
                        align: "center"
                    },
                    {
                        caption: "计价方式",
                        bind: ".priceWayDesc",
                        align: "center"

                    },
                    {
                        caption: "计价单位",
                        bind: ".priceUnitDesc",
                        align: "center"
                    }, {
                        caption: "单价",
                        bind: ".unitPrice",
                        align: "center",
                        template: "int-template3"
                    }
                ]
            },

            remarkInput: {
                $type: "Textarea",
                bind: "remark",
                placeholder: "备注……"
            }
        });
        createTable = function (definition) {
            var $inputTemplate, businessDescTemplate, column, columns, config, container, context, j, len1, operationTemplate, ref, table, urgentBtn,
                $selectTemplate,
                $requireTemplate,
                $valuationTemplate;
            columns = [];
            ref = definition.columns;
            for (j = 0, len1 = ref.length; j < len1; j++) {
                column = ref[j];
                config = fields[column];
                columns.push(fields[column]);
                if (j == ref.length - 1) {
                    columns.push(fields["operation"]);
                }
            }
            model.set(definition.modelName, {
                isUrgent: false,
                businessType: definition.type,
                items: [
                    {},{},{}
                ]
            });
            table = new cola.Table({
                tag:definition.modelName+"table",
                bind: "item in " + definition.modelName + ".items",
                highlightCurrentItem: true,
                changeCurrentItem: true,
                currentPageOnly: true,
                sortable: false,
                columns: columns,
                renderCell: function (self, arg) {
                    //console.info(arg.column.get("property"));
                    if (arg.column.get("property") == "totalPrice") {
                        //var totalPrice = self.get("currentItem.totalPrice")
                        //if (totalPrice != undefined && totalPrice != null && totalPrice != "") {
                            var modelObj = model.get(definition.modelName);
                            //var amount = modelObj.get("amount");
                            var modelItem = modelObj.get("items");
                            var num = 0;
                            modelItem.each(function (element, index) {
                                num = num + model.action("float")(element.get("totalPrice"));
                            });
                            //amount = model.action("float")(amount) + model.action("float")(totalPrice);
                            model.set(definition.modelName + ".amount", num);
                        //}


                    }
                    if (arg.column.get("property") === "businessDesc") {
                        //console.info(arg.column.get("property"));
                        $(arg.dom).attr("name", arg.column.get("property"));
                        //console.info(arg.dom);
                        //console.info($(arg.dom).find())
                    }

                }
            });
            context = {};
            container = $.xCreate({
                tagName: "div",
                "class": "ui segment custom-table basic transition hidden",
                content: [
                    /*{
                        "class": "corner-ribbon",
                        content: "加急"
                    },*/ {
                        tagName: "div",
                        "class": "h-box bottom-box",
                        content: [
                            {
                                tagName: "div",
                                "class": "box",
                                content: {
                                    tagName: "div",
                                    "class": "left-box fluid-layout",
                                    content: [
                                        {
                                            tagName: "div",
                                            "class": "add-btn",
                                            contextKey: "addButton",
                                            content: {
                                                tagName: "i",
                                                "class": "icon plus"
                                            }
                                        }
                                    ]
                                }
                            }, {
                                tagName: "div",
                                "class": "flex-box"
                            }, {
                                tagName: "div",
                                "class": "box",
                                content: {
                                    tagName: "div",
                                    "class": "right-box",
                                    content: [
                                        {
                                            tagName: "span",
                                            content: "小计金额:"
                                        }, {
                                            tagName: "span",
                                            contextKey: "priceSum",
                                            "class": "price"
                                        }
                                    ]
                                }
                            }
                        ]
                    }
                ]
            }, context);
            $inputTemplate = $.xCreate({
                tagName: "div",
                "c-widget": "input; bind:$default; class:fluid;"
            });

            $valuationTemplate = $.xCreate({
                tagName: "div",
                "c-widget": "input; bind:$default; class:fluid;change:{{valuationChange(item)}}"
            });

            $requireTemplate = $.xCreate({
                tagName: "div",
                "c-widget": "input; bind:$default; class:fluid;",
                content: [{
                    tagName: "div",
                    "c-widget": "button; icon:angle double down;click:openProReq;",
                    style: "background-color:white;padding:8px !important;line-height:initial",
                }]
            });

            businessDescTemplate = $.xCreate({
                    tagName: "div",
                    "c-widget": "input; bind:$default; class:fluid;style:",
                    content: [{
                        tagName: "div",
                        "c-widget": "button; icon:upload;click:openUpload;",
                        style: "background-color:white;padding:8px !important;line-height:initial"
                        //size:mini;class:basic; color:grey;
                        //content:"上传"
                    }]
                });

            $selectTemplate = $.xCreate({
                tagName:"div",
                content:{
                    tagName:"div",
                    class:"fluid",
                    "c-widget":"#tableDropDown;bind:$default;change:{{valuationChange(item)}};"
                }
            });

            //$($dropDownTemplate).append($selectTemplate.getDom());

            operationTemplate = $.xCreate({
                tagName: "i",
                "class": "icon trash link",
                "c-onclick": "removeRow(item)"
            });
            table.regTemplate("input-column", $inputTemplate);
            table.regTemplate("business-desc", businessDescTemplate);
            table.regTemplate("operation-column", operationTemplate);
            table.regTemplate("select-column", $selectTemplate);
            //table.regTemplate("require-column", $requireTemplate);
            table.regTemplate("valuation-column",$valuationTemplate);
            $(container).prepend(table.getDom());
            urgentBtn = new cola.Toggle({
                bind: definition.modelName + ".isUrgent",
                change: function (self, arg) {
                    var value;
                    value = arg.value;
                    return $(container).toggleClass("urgent", value);
                }
            });
            $(context.addButton).on("click", function () {
                return model.get(definition.modelName + ".items").insert({});
            });
            $(context.removeButton).on("click", function () {
                return model.get("ranges").set(definition.modelName, false);
            });
            $(context.urgentLabel).after(urgentBtn.getDom());

            priceLabel = cola.xRender({
                tagName: "span",
                "c-bind": 'formatNumber(' + definition.modelName + '.amount,"#,##0.00")',
                "c-watch": "priceCount on " + definition.modelName + ".amount"
            }, model);
            $(context.priceSum).append(priceLabel);

            return container;
        };
        $("#bottomBox").find(".font-btn").on("click", function () {
            var $dom, box, boxClass, isActive, name;
            $dom = $(this);
            isActive = $dom.hasClass("active");
            name = $dom.attr("name");
            boxClass = "." + name + "-box";
            box = $("#bottomBox").find(boxClass);
            $dom.toggleClass("active", !isActive);
            if (isActive) {
                return box.hide();
            } else {
                return box.show();
            }
        });
        //action
        model.action({
            //账期订单
            saveAll: function (self, arg) {
                if(!validateForm()){return;}
                var clientsDpValue =  $("#clientsDp").val();
                if(clientsDpValue == "temp-customer"){
                    $("<div class='tips_contants'>").fadeIn(250).html("过路客不能保存为账期订单").delay(1500).fadeOut(250).appendTo('body');
                    return false;
                }
                self.set("disabled",true);
                self.set("state","loading");
                model.set("purchaseOrder.partnerKey", clientsDpValue);
                model.set("purchaseOrder.partnerName",  $("#clientsDp").find("option:selected").attr("data-n"));
                model.set("purchaseOrder.partnerShortname", $("#clientsDp").find("option:selected").attr("data-s"));



                var userData = self.get("userData");
                var modelArray = new Array();
                var contiNum=0;
                for (var a in model.get("ranges")._data) {
                    if (a != undefined) {
                        if (!model.get("ranges").get(a)) {continue;}
                        //modelArray.push()
                        var modelObj = model.get(a);
                        var modelObjItem = modelObj.get("items");
                        var dataUp = new Array();
                        var isUrgent = modelObj.get("isUrgent") == true ? "1" : "0";
                        var businessType = modelObj.get("businessType");
                        //////////////校验//////////////////////////////////////
                        //校验需要检验的列
                        var validatorCols;
                        model.get("tags").each(function(element,index){
                            var modelName = element.get("modelName");
                            if(a == modelName){
                                validatorCols = element.get("columns");
                            }
                        });
                        //////////////校验//////////////////////////////////////
                        /**
                         * 如校验不通过，由index(行)和i（列）进行判断
                         */
                        var tbody = cola.tag(a+"table")[0].get$Dom().find("tbody");
                        modelObjItem.each(function (data1,index) {

                            if(data1.get("businessDesc")!=undefined || Number((data1.get("totalPrice")))>0){
                                contiNum++;
                            }
                            data1.set("isUrgent", isUrgent);
                            data1.set("businessType", businessType);
                            data1.set("isValid", "1");
                            data1.set("isDel", "0");
                        });
                        modelArray = modelArray.concat(modelObjItem.toJSON());
                    }
                }
                var remark = model.get("remark");
                if (remark != undefined && remark != null) {
                    model.get("purchaseOrder").set("remarks", remark);
                }
                model.set("purchaseOrder.contactId", $("#contacterDp").val());
                model.set("purchaseOrder.contactName", $("#contacterDp").find("option:selected").text());
                var saveData = {};
                saveData.details = modelArray;
                saveData.purchaseOrder = model.get("purchaseOrder").toJSON();

                $.ajax({
                    url: savePurchaseUrl,
                    type: "post",
                    data: JSON.stringify(saveData),
                    dataType: "json",
                    contentType: "application/json",
                    success: function (callBack) {
                        if (callBack.status == '1') {
                            var cType = callBack.type;
                            var type = "order2";

                            if(cType == "02"){
                                type = "order4";
                            }else if(cType == "04"){
                                type = "order4";
                            }

                            self.set("disabled",false);
                            self.set("state","");
                            var config = {
                                menuUrl:  mainPurchaseUrl+type
                            };
                            parent.mainConfigUrl(config);
                        }else{
                            $("<div class='tips_contants'>").fadeIn(250).html(callBack.msg).delay(5000).fadeOut(250).appendTo('body');
                            self.set("disabled",false);
                            self.set("state","");
                        }


                    }, error: function () {
                        $("<div class='tips_contants'>").fadeIn(250).html("添加出错,请联系管理员").delay(5000).fadeOut(250).appendTo('body');
                        self.set("disabled",false);
                        self.set("state","");
                    }
                });
            },
            //是否确认现金订单
            ifSaveCash:function(self,arg){
                if(!validateForm()){return;}
                var depositRequested = model.get("purchaseOrder.depositRequested");
                if(depositRequested > 0){
                    $(".tips_contants").remove();
                    $("<div class='tips_contants'>").fadeIn(250).html("创建订单并付款即一次付清货款，不支持预付").delay(1500).fadeOut(250).appendTo('body');

                }else{
                    // model.action("saveCash")(self);
                    var saleMon=Number(model.get("purchaseOrder.receivablesMoney")).toFixed(2);
                    var saleMonA=accounting.formatNumber(Number(model.get("purchaseOrder.receivablesMoney")),2);
                    $("#orderMoney,#payAmout").text(saleMonA);//订单金额赋值
                    $("#orderMoneyActual").text(saleMon);//订单金额赋值
                    $("#rateAmount").text("0");
                    $("#rateNum").val("0");
                    $('#createOrderPop')
                        .modal({
                            transition : 'horizontal flip',
                            onApprove : function() {
                                model.action("saveCash")(self);
                                console.log("创建订单并付款...");
                            },
                            inverted: true
                        })
                        .modal('show');
                    $("#createOrderPop").parent("div").css("background-color","rgba(255, 255, 255, 0.85)");
                    // $("<div class='tips_contants'>").fadeIn(250).html("请填写预收金额").delay(1500).fadeOut(250).appendTo('body');
                }
            },
            //保存现金订单
            saveCash: function (self, arg) {

                self.set("disabled",true);
                self.set("state","loading");

                var userData = self.get("userData");
                var modelArray = [];
                for (var a in model.get("ranges")._data) {
                    if (a != undefined) {
                        if (!model.get("ranges").get(a)) {continue;}
                        var modelObj = model.get(a);
                        var modelObjItem = modelObj.get("items");
                        var dataUp = [];
                        var isUrgent = modelObj.get("isUrgent") == true ? "1" : "0";
                        var businessType = modelObj.get("businessType");
                        //////////////校验//////////////////////////////////////
                        //校验需要检验的列
                        var validatorCols;
                        model.get("tags").each(function(element,index){
                            var modelName = element.get("modelName");
                            if(a == modelName){
                                validatorCols = element.get("columns");
                            }
                        });

                        //////////////校验//////////////////////////////////////
                        /**
                         * 如校验不通过，由index(行)和i（列）进行判断
                         */
                        var tbody = cola.tag(a+"table")[0].get$Dom().find("tbody")
                        modelObjItem.each(function (data1,index) {
                            data1.set("isUrgent", isUrgent);
                            data1.set("businessType", businessType);
                            data1.set("isValid", "1");
                            data1.set("isDel", "0");
                        });
                        modelArray = modelArray.concat(modelObjItem.toJSON());
                    }
                }

                var remark = model.get("remark");
                if (remark != undefined && remark != null) {
                    model.get("purchaseOrder").set("remarks", remark);
                }

                model.set("purchaseOrder.partnerKey", $("#clientsDp").val());
                model.set("purchaseOrder.partnerName", $("#clientsDp").find("option:selected").attr("data-n"));
                model.set("purchaseOrder.partnerShortname", $("#clientsDp").find("option:selected").attr("data-s"));


                model.set("purchaseOrder.contactId", $("#contacterDp").val());
                model.set("purchaseOrder.contactName", $("#contacterDp").find("option:selected").text());

                model.set("purchaseOrder.taxRate", Number($("#rateNum").val())/100);

                var saveData = {};
                saveData.details = modelArray;
                saveData.purchaseOrder = model.get("purchaseOrder").toJSON();

                $.ajax({
                    url: savePaymentPurchaseUrl,
                    type: "post",
                    data: JSON.stringify(saveData),
                    dataType: "json",
                    contentType: "application/json",
                    success: function (callBack) {
                        if (callBack.status == '1') {
                            self.set("disabled",false);
                            self.set("state","");
                            var config = {
                                menuUrl:  mainPurchaseUrl+"order5"
                            };
                            parent.mainConfigUrl(config);
                        }else{
                            $("<div class='tips_contants'>").fadeIn(250).html(callBack.msg).delay(5000).fadeOut(250).appendTo('body');
                            self.set("disabled",false);
                            self.set("state","");
                        }
                    }, error: function () {
                        $("<div class='tips_contants'>").fadeIn(250).html("添加出错,请联系管理员").delay(5000).fadeOut(250).appendTo('body');
                        self.set("disabled",false);
                        self.set("state","");
                    }
                });
            },

            showRemark: function () {
                var hasClass;
                var self = $("#remarkBtn");
                hasClass = self.hasClass("secondary");
                self.toggleClass("secondary", !hasClass);
                if (hasClass) {
                    self.html("<i class='iconfont_new'>&#xe6ca;</i>添加备注").css("padding","5px 0px 10px 26px");
                    $("#remarkInput").hide();
                    return model.set("remark", "");
                } else {
                    self.html("备注").css("padding","5px 0px 10px 0px");
                    return $("#remarkInput").show();
                }
            },
            //计算公式
            formula:function(rowItem){
                var modelName = rowItem._pathCache[0];
                //计价方式
                var priceWay = rowItem.get("priceWay");
                //长
                var length = model.action("float")(rowItem.get("length"));
                //宽
                var width = model.action("float")(rowItem.get("width"));
                //数量
                var quantity = model.action("float")(rowItem.get("quantity"));
                //单价
                var unitPrice = model.action("float")(rowItem.get("unitPrice"));
                //附加费用
                //减免

                var totalPrice = 0;
                    switch (priceWay){
                        case "01" :
                            totalPrice = length * width * quantity * unitPrice;
                            break;
                        case "02" :
                            totalPrice = quantity * unitPrice;
                            break;
                        case "03" :
                            totalPrice = length * quantity * unitPrice;
                            break;
                        case "04" :
                            totalPrice = width * quantity * unitPrice;
                            break;
                        case "05" :
                            if(length > width){
                                totalPrice = length * quantity * unitPrice;
                            }else{
                                totalPrice = width * quantity * unitPrice;
                            }
                            break;
                        case "06" :
                            if(length > width){
                                totalPrice = Math.pow(length,2) * quantity * unitPrice;
                            }else{
                                totalPrice = Math.pow(width,2)  * quantity * unitPrice;
                            }
                            break;
                        default :
                            break;
                    }



                return Number(totalPrice).toFixed(2);
            },
            valuationChange:function(item) {
                var totalPrice = model.action("formula")(item);
                item.set("totalPrice",totalPrice);
            },
            //本单计算 小计金额变动时触发
            priceCount: function (dom, modelObjs) {
                var tAmount = 0;
                var ranges = modelObjs.get("ranges")._data;
                for (var key in ranges) {
                    if (ranges[key]) {
                        var amount = modelObjs.get(key).get("amount");
                        tAmount = tAmount + modelObjs.action("float")(amount);
                    }
                }
                modelObjs.set("purchaseOrder.price", tAmount);

                //pxy  测试不一定修改
                var orderSales = modelObjs.get("order.sales");
                if(isNaN(orderSales)){
                    $("<div class='tips_contants'>").fadeIn(250).html("折扣优惠为0-100").delay(500).fadeOut(250).appendTo('body');
                    return false;
                }
                modelObjs.set("purchaseOrder.discountRate",orderSales/100);
                var discount = model.get("purchaseOrder.price") * (orderSales/100);
                modelObjs.set("purchaseOrder.discount",discount);
                modelObjs.set("purchaseOrder.preferential",0);
                //pxy  测试不一定修改

            },
            //折扣变动
            discountChange:function(self,modelObj){

                var orderSales = modelObj.get("order.sales");
                if(isNaN(orderSales)){
                    $("<div class='tips_contants'>").fadeIn(250).html("折扣优惠为0-100").delay(500).fadeOut(250).appendTo('body');
                    //cola.alert("折扣优惠为0-100",{title: "提示", level: "warning"});
                    return false;
                }
                modelObj.set("purchaseOrder.discountRate",orderSales/100);
                var discount =  model.get("purchaseOrder.price") * (orderSales/100);
                var discountNum = 0;
                with(Math){
                    discountNum = round(discount*pow(10,2))/pow(10,2);
                }
                modelObj.set("purchaseOrder.discount",discountNum);
            },
            //绑定金额小计的值
            bindChange:function(value,name){
                var nameSet = "purchaseOrder."+name;
                model.set(nameSet,value);
                return model.action("formatNumber")(value,'#,##0.00');
            },
            //触发隐藏的file input的点击事件
            openHideUpload: function () {
                $("#fileButton").click();
            },
            testHard1: function (btn) {
                var currentItem = cola.widget("priceTable").get("currentItem")._data;
                var proReqModelName = model.get("proReqModelName");
                var modelObj = model.get(proReqModelName);
                var currentObj = modelObj.get("items").current;

                currentObj.set("requirements", currentItem.categoryDesc);
                currentObj.set("unitPrice", currentItem.unitPrice);
                currentObj.set("unit", currentItem.priceUnitDesc);
                currentObj.set("priceWay",currentItem.priceWay);

                model.action("closeProReq")();
                //console.info(model);
            },
            testHard2: function () {
                var currentItem = cola.widget("priceTable").get("currentItem")._data;
                var proReqModelName = model.get("proReqModelName");
                var modelObj = model.get(proReqModelName);

                var currentObj = modelObj.get("items").current;
                currentObj.set("requirements", currentItem.categoryDesc);
                currentObj.set("unitPrice", currentItem.unitPrice);
                currentObj.set("unit", currentItem.priceUnitDesc);
                currentObj.set("priceWay",currentItem.priceWay);
                while (currentObj._next != undefined) {
                    currentObj = currentObj._next;
                    currentObj.set("requirements", currentItem.categoryDesc);
                    currentObj.set("unitPrice", currentItem.unitPrice);
                    currentObj.set("unit", currentItem.priceUnitDesc);
                    currentObj.set("priceWay",currentItem.priceWay)
                }
                //
                model.action("closeProReq")();
                //console.info(model);
            },

            closeProReq: function (self, arg) {
                cola.widget("topBarPR").hide();
            },
            //打开服务定价窗口
            openProReq: function (self, arg) {
                var prices = model.get("prices");
                if(prices != undefined){
                    prices.empty();
                }
                //
                var $firstCategory = $(".ui.tabular.menu");
                $firstCategory.empty();
                $(".ui.tab.active").remove();
                var uploadModelName = self._scope.parent.data._targetData._data.modelName;
                model.set("proReqModelName", uploadModelName);
                var partnerKey = $("#clientsDp").val();
                var businessType =  uploadModelName.substring(5, uploadModelName.length);

                if(partnerKey == undefined || partnerKey=="" || partnerKey=="ALL"){
                    $("<div class='tips_contants'>").fadeIn(250).html("请选择客户").delay(2000).fadeOut(250).appendTo('body');
                    //cola.alert("请选择客户",{title: "提示", level: "warning"});
                    return false;
                }
                cola.widget("topBarPR").show();
                //获取服务定价并渲染
                model.describe("pps", {
                    provider: {
                       url:"/company/dpComProPrice",
                       parameter:{
                            pricingType: "1",
                            partnerKey:partnerKey,
                            businessType:businessType
                       }
                    }
                });

                var pps = model.get("pps","sync");
                /*创建分类*/
                if(pps == 0){
                    return false;
                }
                pps.each(function (pp, i) {
                    var active = ""
                    if (i === 0) active = " active"
                    var item = $("<a class='item" + active + "' data-tab='" + pp.get("categoryId") + "'>" + pp.get("categoryDesc") + "</a>");
                    var tab = $("<div class='ui tab" + active + "' data-tab='" + pp.get("categoryId") + "'></div>");
                    tab.data("c", pp);
                    $firstCategory.append(item);
                    var $secondCategory = tab;
                    var $secondCategoryTab = $("<div class='ui blue secondary menu'></div>");
                    $secondCategory.append($secondCategoryTab);
                    $firstCategory.after($secondCategory);
                    var second = pp.get("comProPriceVOs");

                    second.each(function (s, j) {
                        active = " active";
                        if (j !== 0) active = "";
                        var item = $("<a class='item" + active + "' data-tab='" + s.get("categoryId") + "'>" + s.get("categoryDesc") + "</a>");
                        var tab = $("<div class='ui tab' data-tab='" + s.get("categoryId") + "'></div>");
                        $secondCategoryTab.append(item);
                        $secondCategoryTab.after(tab);
                        var third = s.get("comProPriceVOs");

                        item.data("prices", third);
                        tab.data("prices", third);

                        if (i === 0 && j === 0) {
                            model.set("prices", third);
                        }
                        third.each(function (t, k) {
                            t.set("index", k + 1);
                            t.set("state", "隐藏");
                        });
                    });

                });

                $(".tabular.menu .item").tab({
                    onVisible: function (tabPath) {
                        var prices = $(this).find(".item.active").data("prices");
                        model.set("prices", prices || []);
                    }
                });
                $(".secondary.menu .item").tab({
                    onVisible: function (tabPath) {
                        model.set("prices", $(this).data("prices") || []);
                    }
                });
                $(".secondary.menu .item").click(function () {});
                //console.info(cola.model().get("pps"));
                //setTimeout('console.info(cola.model().get("pps"))',10000);
                /**/
            },
            //关闭上传窗口
            closeUpload: function (self, arg) {
                var fileLists = $("#file_div input").val("");
                $("#upload_box ul").children().remove();
                cola.widget("topBar").hide();
            },
            //打开上传窗口
            openUpload: function (self, arg) {
                model.set("uploadNote", "可以一次上传多个文件");
                // var uploadModelName = self._scope.parent.data._targetData._data.modelName;
                var uploadModelName = globDtCl[0].modelName;
                model.set("uploadModelName", uploadModelName);
                cola.widget("topBar").show();
            },
            //上传预览
            preview: function (btn) {
                var uploadBox1 = $("#upload_box ul").eq(0);
                var uploadBox2 = $("#upload_box ul").eq(1);

                uploadBox1.children().remove();
                uploadBox2.children().remove();
                var $fileList = $($("#topBar").find("input").prop("files"));
                //设置提示
                model.set("uploadNote", "本次上传文件数:    " + $fileList.length);
                $fileList.each(function (index, element) {
                    var showName = element.name.substring(0, element.name.lastIndexOf("."));
                    var lable_show = "<li><label>" + showName + "</label></li>";
                    var $lable_show = $(lable_show);
                    var btn = $.xCreate({
                        tagName: "button",
                        content: "删除",
                        "class":"ui button basic blue padd10",
                        click: function () {
                            var $li = $(this).parent("li");
                            $li.remove();
                        }
                    });
                    $lable_show.append(btn);
                    if (index > 14) {
                        uploadBox2.append($lable_show);
                    } else {
                        uploadBox1.append($lable_show);
                    }

                });

            },
            //解析上传的图片名称，保存对应数据至表单列
            saveUploadName: function (a, b) {
                var $tableWrap = $("#tableWrap");
                var uploadBoxLable = $("#upload_box ul li label");
                tbody_dom = b.dom;
                var $tbody = $tableWrap.find("table tbody");

                //首先获取 上传框中的上传信息
                var file_datas = new Array();
                uploadBoxLable.each(function (index, element) {
                    var file_name = $(element).text();
                    var file_data = util.setOrderData(file_name);
                    file_datas.push(file_data);
                });
                if (file_datas.length == 0) {
                    alert("不能为空!");
                    return;
                }


                var uploadModelName = model.get("uploadModelName");
                var modelObj = model.get(uploadModelName).get("items");
                var currentObj = modelObj.current;

                var num = 0;
                currentObj.set("length", file_datas[num].length);
                currentObj.set("width", file_datas[num].width);
                currentObj.set("quantity", file_datas[num].number);
                currentObj.set("businessDesc", file_datas[num].name);

                for(var i = 1;i<file_datas.length;i++){
                    if(currentObj._next != undefined){
                        currentObj = currentObj._next;
                        currentObj.set("length", file_datas[i].length);
                        currentObj.set("width", file_datas[i].width);
                        currentObj.set("quantity", file_datas[i].number);
                        currentObj.set("businessDesc", file_datas[i].name);
                    }else{
                        modelObj.insert({});
                        currentObj = currentObj._next;
                        currentObj.set("length", file_datas[i].length);
                        currentObj.set("width", file_datas[i].width);
                        currentObj.set("quantity", file_datas[i].number);
                        currentObj.set("businessDesc", file_datas[i].name);
                    }
                }
                var fileLists = $("#file_div input").val("");
                $("#upload_box ul").eq(0).children().remove();
                $("#upload_box ul").eq(1).children().remove();

                cola.widget("topBar").toggle();
            },
            //添加一行
            addFileRow: function (a, b) {
                $("#file_div").append('<input type="file"/><br>');
            },
            //alex start
            isRangeChecked: function (code) {
                var checked;
                checked = model.get("ranges." + code);
                return checked;
            },
            removeRow: function (entity) {
                entity.set("totalPrice",0);
                return entity.remove(true);
            },
            changeMain: function (self, arg) {

                var checkbox, dom, modelName, old, tag;
              //  var tag1 = self.get("userData");
                // tag=model.get("tags")[0];

                var tagObj = {};
                tagObj.columns =globDtCl[0].columns;
                tagObj.modelName =globDtCl[0].modelName;
                tagObj.label =globDtCl[0].label;
                tagObj.type =globDtCl[0].type;
                dom = createTable(tagObj);
                $("#tableWrap").append(dom);
                return $(dom).transition('vertical flip');

                modelName ="model01";
                // modelName = tag.get("modelName");
                checkbox = self;
                old = orderMap[modelName];
                var tf=false;
                console.log(arg=="undefined");
                console.log(arg==undefined);
                if(arg==undefined){
                    tf=true;
                }
                if (tf) {
                    if (old) {
                        return;
                    }


                } else {
                }
            }
        });
        //获取服务定价并渲染
        model.describe("pps", {
            provider: "/company/dpComProPrice"
        });
        parent.window.ddd = model;
    });


    cola.on("ready", function () {
        cola.tag("orderDate").set("value", new Date());
        //input 输入框默认全选
        cola.model().action("changeMain")();
        $("input").on("click",function(self,index){
            $(this).select();
        });
        $.ajax({
            url:vendorListUrl,
            dataType:"json",
            timeout:"8000",
            success:function(data){
                console.log(data);
                $("#clientsDp").html( returnopt(data,1)).val("");
                $("#clientsDp").select2({
//                        maximumInputLength:2,
                    templateResult: formatState
                });
/*
                $("#clientsDp").on("select2:open", function (e) {
                    alert("d");
                    $('.tips_sale').popup({
                    hoverable : true
                }); });*/
                $("#contacterDp").select2({  minimumResultsForSearch: Infinity});
            },
            error:function(){
            }
        })

    })

})();
function  returnopt(data,type) {
    var opt="";
    var partner="";
    // if(type=="1"){opt='<option  value="ALL">全部供应商</option>'}
    for(var i=0;i<data.length;i++){
        var dt=data[i];
        var dtn ="";
        if(type ==1){

                   // if(dt.partnerComKey==undefined){partner="";}else{partner=dt.partnerComKey};
            dtn =dt.myComShortname==undefined?"全部供应商":dt.myComShortname;
            opt +='<option data-s="'+dt.partnerShortname+'" data-n="'+dt.partnerName+'" data-p="'+dt.partnerStatus+'" value="'+dt.partnerKey+'">'+dtn+'</option>';
        }
        if(type ==2){
            opt +='<option value="'+dt.contacterId+'">'+dt.contacterName+'</option>';
        }
    }
    return opt;
}
function formatState (state) {
    var p=$(state.element).attr("data-p");
    var mark="";
    var css="  font-style:normal;font-size: 8px !important;background: #e9dfdf;color: #b89a9a;border-radius: 3px;height: 20px;margin-left: 10px;line-height: 20px;padding: 0 2px;position: absolute;right: 3px;top: 5px;";
    var cs="   position: absolute;right: 4px;top: 8px;border: 6px solid #f2711c;width: 0;height: 0;border-radius: 50%;";
    if(p==undefined || p=="" ||p==null){
        mark='';
    }else if(p=="1"){
        mark='<i  class="tips_sale">好友</i>';
    }
    var $state = $(
               '<span style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:160px;display: block;">'+state.text + '</span>' +mark

//                '<span><img src="/' + state.element.value.toLowerCase() + '.png" class="img-flag" /> ' + state.text + '</span>'
    );
    return $state;
}
function changeClients(o){
    console.log($(o).find("option:selected").text());
    $.ajax({
        url:contactListUrl,
        dataType:"json",
        data:{"partnerKey": $(o).val()},
        timeout:"8000",
        success:function(data){
            $("#contacterDp").html( returnopt(data,2));
            $("#contacterDp").select2({  minimumResultsForSearch: Infinity});
        },
        error:function(){
        }
    })
}
function validateForm() {
    var clientsDpValue =  $("#clientsDp").val();
    if(clientsDpValue == "" || clientsDpValue==null){
        $("<div class='tips_contants'>").fadeIn(250).html("请选择供应商").delay(1500).fadeOut(250).appendTo('body');
        return false;
    }
    return true;
}
console.log("purchase");