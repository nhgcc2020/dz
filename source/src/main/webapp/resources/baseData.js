var fields = {
    checkingNo: {
        property: "checkingNo",
        caption: "销售对账单编码"
    },
    salesNo: {
        property: "salesNo",
        caption: "订单号",
        width:"137px"
    },      purchaseNo: {
        property: "purchaseNo",
        caption: "订单号",
        width:"184px"
    },    orderDate: {
        property: "orderDate",
        caption: "下单日期",
        width:"90px"
    },
    itemNo: {
        property: "itemNo",
        caption: "行序号"
    },
    businessType: {
        property: "businessType",
        caption: "业务类型"
    },
    businessDesc: {
        property: "businessDesc",
        caption: "业务内容",
        width:"367px",
        align: "left"
    },  totalArea: {
        property: "totalArea",
        caption: "面积(㎡)",
        width:"81px",
        align:"center"
    },totalOrderPrice: {
        property: "totalOrderPrice",
        align:"right",
        width:"120px",
        caption: "订单金额"
    }, salesOrderPrice: {
		property: "salesOrderPrice",
		align:"right",
		width:"120px",
		caption: "合计金额"
	},purchaseOrderPrice: {
		property: "purchaseOrderPrice",
		align:"right",
		width:"120px",
		caption: "合计金额"
	},
    requirements: {
        property: "requirements",
        caption: "制作物料",
        width: "185px",
        align: "left"
    },
    specification: {
        property: "specification",
        caption: "规格(m)",
        width: "109px",
        align: "center"
    },
    length: {
        property: "length",
        caption: "长",
        width: "60px",
        align: "center"
    },
    width: {
        property: "width",
        caption: "宽",
        width: "60px",
        align: "center"
    },
    priceWay: {
        property: "priceWayDesc",
        caption: "计价方式",
        width: "80px",
        align: "center"
    },
    colorSize: {
        property: "colorSize",
        caption: "色数",
        width: "60px",
        align: "center"
    },
    pairsNum: {
        property: "pairsNum",
        caption: "付数",
        width: "60px",
        align: "center"
    },
    quantity: {
        property: "quantity",
        caption: "数量",
        width: "81px",
        align: "center"
    },
    unit: {
        property: "unit",
        caption: "单位",
        width: "81px",
        align: "center"
    },
    unitPrice: {
        property: "unitPrice",
        caption: "单价",
        width: "81px",
        align: "right"
    },

    totalPrice: {
        property: "totalPrice",
        caption: "行小计",
        width: "81px",
        align: "right"
    },
//                remarks: {
//                    property: "remarks",
//                    caption: "备注",
//                    width: "60px",
//                    align: "center"
//                },
    orderStatus: {
        property: "orderStatus",
        caption: "订单状态",
        width: "60px",
        align: "center"
    },
    isUrgent: {
        property: "isUrgent",
        caption: "是否加急",
        width: "60px",
        align: "center"
    },
    isValid: {
        property: "isValid",
        caption: "是否有效",
        width: "60px",
        align: "center"
    },
    isDel: {
        property: "isDel",
        caption: "是否删除",
        width: "60px",
        align: "center"

    },
    creator: {
        property: "creator",
        caption: "创建者",
        width: "80px",
        align: "center"
    },
    createTime: {
        property: "createTime",
        caption: "创建时间",
        width: "100px",
        align: "center"
    },
    operation: {
        caption: "操作",
        width: "60px",
        align: "center"
    }
};
(function ($) {
    $.fn.extend({
        //表格合并单元格，colIdx要合并的列序号，从0开始
        "rowspan": function (colIdx) {
            return this.each(function () {
                var that;
                $('tr', this).each(function (row) {
                    $('td:eq(' + colIdx + ')', this).filter(':visible').each(function (col) {
                        if (that != null && $(this).text() == $(that).text()) {

                            rowspan = $(that).attr("rowSpan");
                            if (rowspan == undefined) {
                                $(that).attr("rowSpan", 1);
                                rowspan = $(that).attr("rowSpan");
                            }
                            rowspan = Number(rowspan) + 1;
                            $(that).attr("rowSpan", rowspan);
                            $(this).hide();

                        } else {
                            that = this;
                        }
                    });
                });
            });
        },
        "rowspan2": function (colIdx) {
            return this.each(function () {
                var that;
                var thatVal;
                var valT2;
                $('tr', this).each(function (row) {


                    $(this).attr("data-id","1");
                    var $tdVal=$('td:eq(1)',this).text();
                    $('td:eq(' + colIdx + ')', this).filter(':visible').each(function (col) {

                        var valT1=$(this).text()+$tdVal;

                        var valT2=$(that).text()+thatVal;
                        if (that != null && valT1 == valT2) {
                            rowspan = $(that).attr("rowSpan");
                            if (rowspan == undefined) {
                                $(that).attr("rowSpan", 1);
                                rowspan = $(that).attr("rowSpan");
                            }
                            rowspan = Number(rowspan) + 1;
                            $(that).attr("rowSpan", rowspan);
//                                $(this).remove();
                            $(this).hide();
//                                $(this).html("");

                        } else {
                            that = this;
                            thatVal=$tdVal;
                        }
                    });
                });
            });
        }

    });

})(jQuery);