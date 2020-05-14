(function() {
  var _columnsSetter,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  cola.ext = {};
  //=========
  _columnsSetter = function(table, columnConfigs) {
    var column, columnConfig, columns, k, l, len1, len2, ref;
    if (table != null ? table._columns : void 0) {
      ref = table._columns;
      for (k = 0, len1 = ref.length; k < len1; k++) {
        column = ref[k];
        column._setTable(null);
      }
    }
    columns = [];
    if (columnConfigs) {
      for (l = 0, len2 = columnConfigs.length; l < len2; l++) {
        columnConfig = columnConfigs[l];
        if (!columnConfig) {
          continue;
        }
        if (columnConfig instanceof cola.TableColumn) {
          column = columnConfig;
        } else {
          column = cola.create("table.column", columnConfig, cola.TableColumn);
          column.set("width", columnConfig.width);
        }
        column._setTable(table);
        columns.push(column);
      }
    }
    this._columns = columns;
  };

  cola.ext.AbstractTable = (function(superClass) {
    extend(AbstractTable, superClass);

    AbstractTable.attributes = {
      items: {
        refreshItems: true,
        setter: function(items) {
          if (this._items === items) {
            return;
          }
          this._set("bind", void 0);
          this._items = items;
        }
      },
      bind: {
        setter: function(bindStr) {
          this._set("items", void 0);
          this._bindSetter(bindStr);
        }
      },
      columns: {
        setter: function(columnConfigs) {
          _columnsSetter.call(this, this, columnConfigs);
          this._collectionColumnsInfo();
        }
      },
      dataType: {
        setter: cola.DataType.dataTypeSetter
      },
      showHeader: {
        type: "boolean",
        defaultValue: true
      },
      showFooter: {
        type: "boolean"
      },
      columnStrecthable: {
        type: "boolean",
        defaultValue: true
      },
      selectedProperty: {
        defaultValue: "selected"
      }
    };

    AbstractTable.EVENTS = {
      renderRow: null,
      renderCell: null,
      renderHeaderCell: null,
      renderFooterCell: null
    };

    AbstractTable.TEMPLATES = {
      "default": {
        tagName: "tr"
      },
      "checkbox-column": {
        tagName: "div",
        "c-widget": "checkbox;class:in-cell;bind:$default"
      },
      "input-column": {
        tagName: "div",
        "c-widget": "input;class:in-cell;bind:$default",
        style: {
          width: "100%"
        }
      },
      "group-header": {
        tagName: "tr",
        content: {
          tagName: "td",
          colSpan: 100
        }
      }
    };

    function AbstractTable(config) {
      this._columnMap = {};
      AbstractTable.__super__.constructor.call(this, config);
    }

    AbstractTable.prototype._getItems = function() {
      if (this._items) {
        return {
          items: this._items
        };
      } else {
        return AbstractTable.__super__._getItems.call(this);
      }
    };

    AbstractTable.prototype._regColumn = function(column) {
      if (column._name) {
        this._columnMap[column._name] = column;
      }
    };

    AbstractTable.prototype._unregColumn = function(column) {
      if (column._name) {
        delete this._columnMap[column._name];
      }
    };

    AbstractTable.prototype.getColumn = function(name) {
      return this._columnMap[name];
    };

    AbstractTable.prototype._collectionColumnsInfo = function() {
      var col, collectColumnInfo, columnsInfo, expression, k, len1, ref;
      collectColumnInfo = function(column, context, deepth) {
        var bind, col, cols, convertorIndex, info, k, len1, path, ref, ref1, width, widthType;
        info = {
          level: deepth,
          column: column
        };
        if (column instanceof cola.TableGroupColumn) {
          if (column._columns) {
            info.columns = cols = [];
            ref = column._columns;
            for (k = 0, len1 = ref.length; k < len1; k++) {
              col = ref[k];
              if (!col._visible) {
                continue;
              }
              if (context.rows.length === deepth) {
                context.rows[deepth] = [];
              }
              cols.push(collectColumnInfo(col, context, deepth + 1));
            }
            if (cols.length) {
              if (context.rows.length === deepth) {
                context.rows[deepth] = [];
              }
              context.rows[deepth].push(info);
            }
          }
        } else {
          if (column._bind) {
            bind = column._bind;
            if (bind.charCodeAt(0) === 46) {
              convertorIndex = bind.indexOf("|");
              if (convertorIndex < 0) {
                info.property = bind.substring(1);
              } else {
                info.property = bind.substring(1, convertorIndex);
                info.expression = cola._compileExpression(context.alias + bind);
              }
            } else {
              info.expression = cola._compileExpression(bind);
              path = (ref1 = info.expression) != null ? ref1.path : void 0;
              if (path instanceof Array) {
                path = path[0];
              }
              if (path && path.indexOf("*") < 0) {
                info.property = path;
              }
            }
          }
          if (column._width) {
            width = column._width;
            if (typeof width === "string") {
              if (width.indexOf("px") > 0) {
                widthType = "px";
              } else if (width.indexOf("%") > 0) {
                widthType = "percent";
              }
            }
            info.widthType = widthType;
            info.width = parseInt(width, 10);
            if (!widthType && info.width) {
              context.totalWidth += info.width;
            }
          }
          info.index = context.dataColumns.length;
          context.dataColumns.push(info);
          if (column instanceof cola.TableSelectColumn) {
            if (context.selectColumns == null) {
              context.selectColumns = [];
            }
            context.selectColumns.push(info);
          }
          if (context.rows.length === deepth) {
            context.rows[deepth] = [];
          }
          context.rows[deepth].push(info);
        }
        return info;
      };
      this._columnsInfo = columnsInfo = {
        totalWidth: 0,
        rows: [[]],
        dataColumns: [],
        alias: "item"
      };
      if (this._columns) {
        expression = this._itemsScope.expression;
        if (expression) {
          columnsInfo.alias = expression.alias;
        }
        ref = this._columns;
        for (k = 0, len1 = ref.length; k < len1; k++) {
          col = ref[k];
          if (!col._visible) {
            continue;
          }
          collectColumnInfo(col, columnsInfo, 0);
        }
      }
    };

    AbstractTable.prototype._getBindDataType = function() {
      var dataType, item, items;
      if (this._dataType) {
        return this._dataType;
      }
      items = this._getItems().originItems;
      if (items) {
        if (items instanceof cola.EntityList) {
          dataType = items.dataType;
        } else if (items instanceof Array && items.length) {
          item = items[0];
          if (item && item instanceof cola.Entity) {
            dataType = item.dataType;
          }
        }
      }
      return this._dataType = dataType;
    };

    AbstractTable.prototype._createDom = function() {
      var dom;
      if (this._doms == null) {
        this._doms = {};
      }
      dom = document.createElement("table");
      this._createInnerDom(dom);
      return dom;
    };

    AbstractTable.prototype._createInnerDom = function(dom) {
      if (dom.nodeName === "TABLE") {
        $fly(dom).xAppend([
          {
            tagName: "tbody",
            "class": "list",
            contextKey: "itemsWrapper"
          }
        ], this._doms);
      } else {
        $fly(dom).xAppend({
          tagName: "table",
          content: [
            {
              tagName: "tbody",
              "class": "list",
              contextKey: "itemsWrapper"
            }
          ]
        }, this._doms);
      }
      this._doms.tbody = this._doms.itemsWrapper;
    };

    AbstractTable.prototype._parseDom = function(dom) {
      var child, next, nodeName;
      if (!dom) {
        return;
      }
      if (this._doms == null) {
        this._doms = {};
      }
      child = dom.firstChild;
      while (child) {
        next = child.nextSibling;
        nodeName = child.nodeName;
        if (nodeName === "TEMPLATE") {
          this.regTemplate(child);
        } else {
          dom.removeChild(child);
        }
        child = next;
      }
      this._createInnerDom(dom);
    };

    AbstractTable.prototype._createNewItem = function(itemType, item) {
      var itemDom, template;
      template = this.getTemplate(itemType);
      itemDom = this._cloneTemplate(template);
      $fly(itemDom).addClass("item " + itemType);
      itemDom._itemType = itemType;
      return itemDom;
    };

    AbstractTable.prototype._refreshEmptyItemDom = function() {};

    return AbstractTable;

  })(cola.ItemsView);

  cola.ext.Table = (function(superClass) {
    extend(Table, superClass);

    function Table() {
      return Table.__super__.constructor.apply(this, arguments);
    }

    Table.CLASS_NAME = "table";

    Table.prototype._initDom = function(dom) {
      Table.__super__._initDom.call(this, dom);
      $fly(window).resize((function(_this) {
        return function() {
          var fixedFooter, fixedHeader;
          if (_this._fixedHeaderVisible) {
            fixedHeader = _this._getFixedHeader();
            $fly(fixedHeader).width(_this._doms.itemsWrapper.clientWidth);
          }
          if (_this._fixedFooterVisible) {
            fixedFooter = _this._getFixedFooter();
            $fly(fixedFooter).width(_this._doms.itemsWrapper.clientWidth);
          }
        };
      })(this));
    };

    Table.prototype._doRefreshItems = function() {
      var col, colInfo, colgroup, column, columnConfigs, div, i, k, l, len1, len2, nextCol, propertyDef, ref, ref1, tbody, tfoot, thead, width;
      if (!this._columnsInfo.dataColumns.length && this._dataType && this._dataType instanceof cola.EntityDataType) {
        columnConfigs = [];
        ref = this._dataType.getProperties().elements;
        for (k = 0, len1 = ref.length; k < len1; k++) {
          propertyDef = ref[k];
          columnConfigs.push({
            bind: propertyDef._property
          });
        }
        this.set("columns", columnConfigs);
      }
      tbody = this._doms.tbody;
      if (this._showHeader) {
        thead = this._doms.thead;
        if (!thead) {
          $fly(tbody).xInsertBefore({
            tagName: "thead",
            contextKey: "thead"
          }, this._doms);
          thead = this._doms.thead;
        }
        this._refreshHeader(thead);
      }
      colgroup = thead.firstChild;
      nextCol = colgroup.firstChild;
      ref1 = this._columnsInfo.dataColumns;
      for (i = l = 0, len2 = ref1.length; l < len2; i = ++l) {
        colInfo = ref1[i];
        col = nextCol;
        div = col.firstChild;
        nextCol = col.nextSibling;
        if (colInfo.widthType === "precent") {
          width = colInfo.width + "%";
        } else if (colInfo.widthType) {
          width = colInfo.width + colInfo.widthType;
        } else if (colInfo.width) {
          width = (colInfo.width * 100 / this._columnsInfo.totalWidth) + "%";
        }
        if (width != null) {
          $fly(div).width(width);
          $fly(col).width(width);
          width = null;
        }
        column = colInfo.column;
        col.valign = column._valign || "";
      }
      col = nextCol;
      while (col) {
        nextCol = col.nextSibling;
        colgroup.removeChild(col);
        col = nextCol;
      }
      Table.__super__._doRefreshItems.call(this, tbody);
      if (this._showFooter) {
        tfoot = this._doms.tfoot;
        if (!tfoot) {
          $fly(tbody).xInsertAfter({
            tagName: "tfoot",
            contextKey: "tfoot"
          }, this._doms);
          tfoot = this._doms.tfoot;
        }
        this._refreshFooter(tfoot);
        if (!this._fixedFooterVisible) {
          this._showFooterTimer = setInterval((function(_this) {
            return function() {
              var itemsWrapper;
              itemsWrapper = _this._doms.itemsWrapper;
              if (itemsWrapper.scrollHeight) {
                _this._refreshFixedFooter(300);
              }
            };
          })(this), 300);
        }
      }
    };

    Table.prototype._onItemInsert = function(arg) {
      Table.__super__._onItemInsert.call(this, arg);
      if (this._columnsInfo.selectColumns) {
        cola.util.delay(this, "refreshHeaderCheckbox", 100, (function(_this) {
          return function() {
            var colInfo, k, len1, ref;
            ref = _this._columnsInfo.selectColumns;
            for (k = 0, len1 = ref.length; k < len1; k++) {
              colInfo = ref[k];
              colInfo.column.refreshHeaderCheckbox();
            }
          };
        })(this));
      }
    };

    Table.prototype._onItemRemove = function(arg) {
      Table.__super__._onItemRemove.call(this, arg);
      if (this._showFooter) {
        this._refreshFixedFooter();
      }
      if (this._columnsInfo.selectColumns) {
        cola.util.delay(this, "refreshHeaderCheckbox", 100, (function(_this) {
          return function() {
            var colInfo, k, len1, ref;
            ref = _this._columnsInfo.selectColumns;
            for (k = 0, len1 = ref.length; k < len1; k++) {
              colInfo = ref[k];
              colInfo.column.refreshHeaderCheckbox();
            }
          };
        })(this));
      }
    };

    Table.prototype._refreshHeader = function(thead) {
      var cell, colInfo, column, contentWrapper, fragment, i, isNew, j, k, len, len1, row, rowInfo, rowInfos;
      fragment = null;
      rowInfos = this._columnsInfo.rows;
      i = 0;
      len = rowInfos.length;
      while (i < len) {
        row = thead.rows[i];
        if (!row) {
          row = $.xCreate({
            tagName: "tr"
          });
          if (fragment == null) {
            fragment = document.createDocumentFragment();
          }
          fragment.appendChild(row);
        }
        rowInfo = rowInfos[i];
        for (j = k = 0, len1 = rowInfo.length; k < len1; j = ++k) {
          colInfo = rowInfo[j];
          column = colInfo.column;
          cell = row.cells[j];
          while (cell && cell._name !== column._name) {
            row.removeChild(cell);
            cell = row.cells[j];
          }
          if (!cell) {
            isNew = true;
            cell = $.xCreate({
              "class": "center aligned",
              tagName: "th",
              content: {
                tagName: "div"
              }
            });
            cell._name = column._name;
            row.appendChild(cell);
          }
          cell._index = colInfo.index;
          if (colInfo.columns) {
            cell.rowSpan = 1;
            cell.colSpan = colInfo.columns.length;
          } else {
            cell.rowSpan = len - i;
            cell.colSpan = 1;
          }
          contentWrapper = cell.firstChild;
          this._refreshHeaderCell(contentWrapper, colInfo, isNew);
        }
        while (row.lastChild !== cell) {
          row.removeChild(row.lastChild);
        }
        i++;
      }
      while (row.lastChild !== cell) {
        row.removeChild(row.lastChild);
      }
      cola.xRender(row, this._scope);
      if (fragment) {
        thead.appendChild(fragment);
      }
      while (thead.lastChild !== row) {
        thead.removeChild(thead.lastChild);
      }
    };

    Table.prototype._refreshHeaderCell = function(dom, columnInfo, isNew) {
      var caption, column, dataType, propertyDef, template, templateName;
      column = columnInfo.column;
      if (column.renderHeader) {
        if (column.renderHeader(dom) !== true) {
          return;
        }
      }
      if (column.getListeners("renderHeader")) {
        if (column.fire("renderHeader", column, {
          dom: dom
        }) === false) {
          return;
        }
      }
      if (this.getListeners("renderHeaderCell")) {
        if (this.fire("renderHeaderCell", this, {
          column: column,
          dom: dom
        }) === false) {
          return;
        }
      }
      if (isNew) {
        template = column._realHeaderTemplate;
        if (template === void 0) {
          templateName = column._headerTemplate;
          if (templateName) {
            template = this.getTemplate(templateName);
          }
          column._realHeaderTemplate = template || null;
        }
        if (template) {
          template = this._cloneTemplate(template);
          dom.appendChild(template);
        }
      }
      if (column._realHeaderTemplate) {
        return;
      }
      dataType = this._getBindDataType();
      if (dataType && columnInfo.property) {
        propertyDef = dataType.getProperty(columnInfo.property);
      }
      caption = column._caption || (propertyDef != null ? propertyDef._caption : void 0);
      if (!caption) {
        caption = column._name;
        if ((caption != null ? caption.charCodeAt(0) : void 0) === 95) {
          caption = column._bind;
        }
      }
      dom.innerText = caption || "";
    };

    Table.prototype._refreshFooter = function(tfoot) {
      var cell, colInfo, colInfos, column, contentWrapper, i, isNew, k, len1, row;
      colInfos = this._columnsInfo.dataColumns;
      row = tfoot.rows[0];
      if (!row) {
        row = document.createElement("tr");
      }
      for (i = k = 0, len1 = colInfos.length; k < len1; i = ++k) {
        colInfo = colInfos[i];
        column = colInfo.column;
        cell = row.cells[i];
        while (cell && cell._name !== column._name) {
          row.removeChild(cell);
          cell = row.cells[i];
        }
        if (!cell) {
          isNew = true;
          cell = $.xCreate({
            tagName: "td",
            content: {
              tagName: "div"
            }
          });
          cell._name = column._name;
          row.appendChild(cell);
        }
        contentWrapper = cell.firstChild;
        this._refreshFooterCell(contentWrapper, colInfo, isNew);
      }
      while (row.lastChild !== cell) {
        row.removeChild(row.lastChild);
      }
      cola.xRender(row, this._scope);
      if (tfoot.rows.length < 1) {
        tfoot.appendChild(row);
      }
    };

    Table.prototype._refreshFooterCell = function(dom, columnInfo, isNew) {
      var column, template, templateName;
      column = columnInfo.column;
      if (column.renderFooter) {
        if (column.renderFooter(dom) !== true) {
          return;
        }
      }
      if (column.getListeners("renderFooter")) {
        if (column.fire("renderFooter", column, {
          dom: dom
        }) === false) {
          return;
        }
      }
      if (this.getListeners("renderFooterCell")) {
        if (this.fire("renderFooterCell", this, {
          column: column,
          dom: dom
        }) === false) {
          return;
        }
      }
      if (isNew) {
        template = column._realFooterTemplate;
        if (template === void 0) {
          templateName = column._footerTemplate;
          if (templateName) {
            template = this.getTemplate(templateName);
          }
          column._realFooterTemplate = template || null;
        }
        if (template) {
          template = this._cloneTemplate(template);
          dom.appendChild(template);
        }
      }
      if (column._realFooterTemplate) {
        return;
      }
      dom.innerHTML = "&nbsp;";
    };

    Table.prototype._doRefreshItemDom = function(itemDom, item, itemScope) {
      var cell, colInfo, colInfos, column, contentWrapper, i, isNew, itemType, k, len1;
      itemType = itemDom._itemType;
      if (this.getListeners("renderRow")) {
        if (this.fire("renderRow", this, {
          item: item,
          dom: itemDom,
          scope: itemScope
        }) === false) {
          return;
        }
      }
      if (itemType === "default") {
        colInfos = this._columnsInfo.dataColumns;
        for (i = k = 0, len1 = colInfos.length; k < len1; i = ++k) {
          colInfo = colInfos[i];
          column = colInfo.column;
          cell = itemDom.cells[i];
          while (cell && cell._name !== column._name) {
            itemDom.removeChild(cell);
            cell = itemDom.cells[i];
          }
          if (!cell) {
            isNew = true;
            cell = $.xCreate({
              tagName: "td",
              content: {
                tagName: "div"
              }
            });
            cell._name = column._name;
            itemDom.appendChild(cell);
          }
          contentWrapper = cell.firstChild;
          this._refreshCell(contentWrapper, item, colInfo, itemScope, isNew);
        }
        while (itemDom.lastChild !== cell) {
          itemDom.removeChild(itemDom.lastChild);
        }
      }
    };

    Table.prototype._refreshCell = function(dom, item, columnInfo, itemScope, isNew) {
      var $dom, column, context, template, templateName;
      column = columnInfo.column;
      dom.style.textAlign = column._align || "";
      if (column.renderCell) {
        if (column.renderCell(dom, item, itemScope) !== true) {
          return;
        }
      }
      if (column.getListeners("renderCell")) {
        if (column.fire("renderCell", column, {
          item: item,
          dom: dom,
          scope: itemScope
        }) === false) {
          return;
        }
      }
      if (this.getListeners("renderCell")) {
        if (this.fire("renderCell", this, {
          item: item,
          column: colInfo.column,
          dom: dom,
          scope: itemScope
        }) === false) {
          return;
        }
      }
      if (isNew) {
        template = column._realTemplate;
        if (template === void 0) {
          templateName = column._template;
          if (templateName) {
            template = this.getTemplate(templateName);
          }
          column._realTemplate = template || null;
        }
        if (template) {
          template = this._cloneTemplate(template);
          dom.appendChild(template);
          if (columnInfo.property) {
            context = {
              defaultPath: this._alias + "." + columnInfo.property
            };
          }
          cola.xRender(dom, itemScope, context);
        }
      }
      if (column._realTemplate) {
        return;
      }
      $dom = $fly(dom);
      if (columnInfo.expression) {
        $dom.attr("c-bind", columnInfo.expression.raw);
      } else {
        $dom.text(columnInfo.property ? item.get(columnInfo.property) : "");
      }
    };

    Table.prototype._refreshFakeRow = function(row) {
      var cell, colInfo, i, k, len1, nextCell, ref;
      nextCell = row.firstChild;
      ref = this._columnsInfo.dataColumns;
      for (i = k = 0, len1 = ref.length; k < len1; i = ++k) {
        colInfo = ref[i];
        cell = nextCell;
        if (!cell) {
          cell = $.xCreate({
            tagName: "td"
          });
          row.appendChild(cell);
        } else {
          nextCell = nextCell.nextSibling;
        }
      }
      while (nextCell) {
        cell = nextCell;
        nextCell = nextCell.nextSibling;
        row.removeChild(cell);
      }
    };

    Table.prototype._getFixedHeader = function(create) {
      var fakeThead, fixedHeaderWrapper;
      fixedHeaderWrapper = this._doms.fixedHeaderWrapper;
      if (!fixedHeaderWrapper && create) {
        fixedHeaderWrapper = $.xCreate({
          tagName: "div",
          contextKey: "fixedHeaderWrapper",
          "class": "fixed-header table-wrapper",
          content: {
            tagName: "table",
            contextKey: "fixedHeaderTable"
          }
        }, this._doms);
        this._dom.appendChild(fixedHeaderWrapper);
        this._doms.fakeThead = fakeThead = $.xCreate({
          tagName: "thead",
          content: {
            tagName: "tr"
          }
        });
        this._refreshFakeRow(fakeThead.firstChild);
        $fly(this._doms.tbody).before(fakeThead);
      }
      return fixedHeaderWrapper;
    };

    Table.prototype._getFixedFooter = function(create) {
      var fakeTfoot, fixedFooterWrapper;
      fixedFooterWrapper = this._doms.fixedFooterWrapper;
      if (!fixedFooterWrapper && create) {
        fixedFooterWrapper = $.xCreate({
          tagName: "div",
          contextKey: "fixedFooterWrapper",
          "class": "fixed-footer table-wrapper",
          content: {
            tagName: "table",
            contextKey: "fixedFooterTable"
          }
        }, this._doms);
        this._dom.appendChild(fixedFooterWrapper, this._doms);
        this._doms.fakeTfoot = fakeTfoot = $.xCreate({
          tagName: "tfoot",
          content: {
            tagName: "tr"
          }
        });
        this._refreshFakeRow(fakeTfoot.firstChild);
        $fly(this._doms.tbody).after(fakeTfoot);
      }
      return fixedFooterWrapper;
    };

    Table.prototype._refreshFixedColgroup = function(colgroup, fixedColgroup) {
      var col, fixedCol, nextCol, nextFixedCol;
      nextCol = colgroup.firstChild;
      nextFixedCol = fixedColgroup.firstChild;
      while (nextCol) {
        col = nextCol;
        nextCol = nextCol.nextSibling;
        fixedCol = nextFixedCol;
        if (!fixedCol) {
          fixedCol = document.createElement("col");
        } else {
          nextFixedCol = nextFixedCol.nextSibling;
        }
        fixedCol.width = col.width;
        fixedCol.valign = col.valign;
      }
      while (nextFixedCol) {
        fixedCol = nextFixedCol;
        nextFixedCol = nextFixedCol.nextSibling;
        fixedColgroup.removeChild(fixedCol);
      }
    };

    Table.prototype._setFixedHeaderSize = function() {
      var colgroup, fixedHeaderColgroup;
      colgroup = this._doms.colgroup;
      fixedHeaderColgroup = this._doms.fixedHeaderColgroup;
      if (!fixedHeaderColgroup) {
        this._doms.fixedHeaderColgroup = fixedHeaderColgroup = colgroup.cloneNode(true);
        this._doms.fixedHeaderTable.appendChild(fixedHeaderColgroup);
      } else {
        this._refreshFixedColgroup(colgroup, fixedHeaderColgroup);
      }
      $fly(this._doms.fakeThead.firstChild).height(this._doms.thead.offsetHeight);
    };

    Table.prototype._setFixedFooterSize = function() {
      var colgroup, fixedFooterColgroup;
      colgroup = this._doms.colgroup;
      fixedFooterColgroup = this._doms.fixedFooterColgroup;
      if (!fixedFooterColgroup) {
        this._doms.fixedFooterColgroup = fixedFooterColgroup = colgroup.cloneNode(true);
        this._doms.fixedFooterTable.appendChild(fixedFooterColgroup);
      } else {
        this._refreshFixedColgroup(colgroup, fixedFooterColgroup);
      }
      $fly(this._doms.fakeTfoot.firstChild).height(this._doms.tfoot.offsetHeight);
    };

    Table.prototype._refreshFixedHeader = function() {
      var fixedHeader, itemsWrapper, scrollTop, showFixedHeader;
      itemsWrapper = this._doms.itemsWrapper;
      scrollTop = itemsWrapper.scrollTop;
      showFixedHeader = scrollTop > 0;
      if (showFixedHeader === this._fixedHeaderVisible) {
        return;
      }
      this._fixedHeaderVisible = showFixedHeader;
      if (showFixedHeader) {
        fixedHeader = this._getFixedHeader(true);
        this._setFixedHeaderSize();
        $fly(this._doms.tbody).before(this._doms.fakeThead);
        this._doms.fixedHeaderTable.appendChild(this._doms.thead);
        $fly(fixedHeader).width(itemsWrapper.clientWidth).show();
      } else {
        fixedHeader = this._getFixedHeader();
        if (fixedHeader) {
          $fly(fixedHeader).hide();
          this._doms.fixedHeaderTable.appendChild(this._doms.fakeThead);
          $fly(this._doms.tbody).before(this._doms.thead);
        }
      }
    };

    Table.prototype._refreshFixedFooter = function(duration) {
      var $fixedFooter, fixedFooter, itemsWrapper, maxScrollTop, scrollTop, showFixedFooter;
      if (this._showFooterTimer) {
        clearInterval(this._showFooterTimer);
        delete this._showFooterTimer;
      }
      itemsWrapper = this._doms.itemsWrapper;
      scrollTop = itemsWrapper.scrollTop;
      maxScrollTop = itemsWrapper.scrollHeight - itemsWrapper.clientHeight;
      showFixedFooter = scrollTop < maxScrollTop;
      if (showFixedFooter === this._fixedFooterVisible) {
        return;
      }
      this._fixedFooterVisible = showFixedFooter;
      if (showFixedFooter) {
        fixedFooter = this._getFixedFooter(true);
        this._setFixedFooterSize();
        $fly(this._doms.tbody).after(this._doms.fakeTfoot);
        this._doms.fixedFooterTable.appendChild(this._doms.tfoot);
        $fixedFooter = $fly(fixedFooter).width(itemsWrapper.clientWidth);
        if (duration) {
          $fixedFooter.fadeIn(duration);
        } else {
          $fixedFooter.show();
        }
      } else {
        fixedFooter = this._getFixedFooter();
        if (fixedFooter) {
          $fly(fixedFooter).hide();
          this._doms.fixedFooterTable.appendChild(this._doms.fakeTfoot);
          $fly(this._doms.tbody).after(this._doms.tfoot);
        }
      }
    };

    Table.prototype._onItemsWrapperScroll = function() {
      if (this._showHeader) {
        this._refreshFixedHeader();
      }
      if (this._showFooter) {
        this._refreshFixedFooter();
      }
    };

    return Table;

  })(cola.ext.AbstractTable);

  cola.registerType("widget", "ext.Table", cola.ext.Table);

}).call(this);
