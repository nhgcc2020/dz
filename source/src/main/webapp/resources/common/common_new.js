//临时使用 修改首页工作台
(function() {
  var App, e, getAjaxID, language, properties, rootApp, rootWindow, startedAjaxList, title, win;

  win = window.parent;

  while (win) {
    try {
      if (win.App) {
        rootApp = win.App;
        rootWindow = win;
        break;
      }
      if (win === win.parent) {
        break;
      }
      win = win.parent;
    } catch (_error) {
      e = _error;
    }
  }

  if (!rootApp) {
    properties = {
      mainView: "./frame/main",
      loginPath: "./login",
      longPollingTimeout: 0,
      longPollingInterval: 2000,
      "service.messagePull": "./service/message/pull",
      "service.login": "./service/account/login",
      "service.logout": "/login/logout",
      "service.menus": "/service/menus",
      "service.user.detail": "/ydz/user/detailWithCom",
      "menu.exclusive": false,
      "menu.labelProperty": "name",
      "workbench": {
        path: "/frame/workbench.html",
        type: "subWindow",
        label: "工作台",
        closeable: true,
        icon: "icon dashboard"
      },
      "app.logo.path": "./resources/images/logo.png",
      "app.name": "Cola Frame",
      title: "欢迎使用易对账"
    };
  }

  App = window.App = {
    _tabs: {},
    getRootWindow: function() {
      if (rootApp) {
        return rootWindow;
      } else {
        return window;
      }
    },
      // 一级菜单触发click事件
      clickMenu:function (item) {
          $("#headerLeftMenu li[data-icon='"+item+"']").click();
      },
    open: function(path, config) {

        if (rootApp) {
            rootApp.open(path, config);
        } else {
            parent.mainConfigUrl(path);
        }

    },
    close: function(path) {
      return delete App._tabs[path];
    },
    goLogin: function(callback) {
      if (rootApp) {
        return rootApp.goLogin(callback);
      } else {
        return login(callback);
      }
    },
    setTitle: function(title) {
      if (rootApp) {
        return rootApp.setTitle(path);
      } else {
        return document.title = title;
      }
    },
    setFavicon: function(path) {
      var i, icon, len, ref, rel, results;
      if (rootApp) {
        return rootApp.setFavicon(path, config);
      } else {
        ref = ["icon", "shortcut icon"];
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          rel = ref[i];
          icon = $("link[rel='" + rel + "']");
          if (icon.length > 0) {
            results.push(icon.attr("href", path));
          } else {
            results.push(document.head.appendChild($.xCreate({
              tagName: "link",
              rel: "icon",
              href: path
            })));
          }
        }
        return results;
      }
    },
    refreshMessage: function() {
      if (rootApp) {
        return rootApp.refreshMessage();
      } else {
        return typeof refreshMessage === "function" ? refreshMessage() : void 0;
      }
    },
    prop: function(key, value) {
      var i, len, p, results;
      if (rootApp) {
        return rootApp.prop(key, value);
      } else {
        if (value === void 0 || arguments.length === 1) {
          if (typeof key === "string") {
            return properties[key];
          } else if (key) {
            results = [];
            for (i = 0, len = key.length; i < len; i++) {
              p = key[i];
              if (key.hasOwnProperty(p)) {
                results.push(properties[p] = key[p]);
              } else {
                results.push(void 0);
              }
            }
            return results;
          }
        } else {
          return properties[key] = value;
        }
      }
    },
    getLoginUser: function() {
      return {
        "username": "admin",
        "cname": "系统管理员",
        "companyName": "上海银联",
        "orgCode": "123",
        "companyId": "CUP-DATA"
      };
    }
  };

  title = App.prop("title");

  if (title && !rootApp) {
    App.setTitle(title);
  }

  if (window.cola) {
    cola.AbstractDropdown.prototype._doFocus = function () {
      	$(this._doms.valueContent).addClass("placeholder")

      	var value = this.get('value');
      	var $input = $(this._doms.input);
      	var inputValue = this._doms.valueContent.innerText;
      	if (typeof value === "undefined" || value === null) {
        	inputValue = null;
        	}
      	$input.val(inputValue);
      	this.fire("focus", this, {inputValue: inputValue, inputDom: this._doms.input});
      	};

    	cola.AbstractDropdown.prototype._doBlur = function () {
      	var $input = $(this._doms.input),
          	$valueContent = $(this._doms.valueContent);
      	var value = $input.val();
      	$valueContent.find("div").text(value);
      	$input.val(null);
      	$valueContent.removeClass("placeholder");
      	this.fire("blur", this, {inputValue: value, inputDom: this._doms.input});
      	};

    cola.defaultAction("setting", function(key) {
      return App.prop(key);
    });
    cola.defaultAction("numberString", function(number) {
      return ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen"][number - 1];
    });
    language =window.navigator.language;
    // language = $.cookie("_language") || window.navigator.language;
    if (language) {
      document.write("<script src=\"/resources/cola-ui/i18n/" + language + "/cola.js\"></script>");
      document.write("<script src=\"/resources/i18n/" + language + "/common.js\"></script>");
    }
    // $(NProgress.done);
    $(document).ajaxError(function(event, jqXHR) {
      var message;
      if (jqXHR.status === 401) {
        App.goLogin();
        return false;
      } else {
        message = jqXHR.responseJSON;
        if (message) {
          throw new cola.Exception(message);
        }
      }
    });
    getAjaxID = function(event) {
      var id, key, value;
      id = "";
      for (key in event) {
        value = event[key];
        if (key.indexOf("jQuery") === 0) {
          id = key;
          break;
        }
      }
      if (id) {
        if (!(parseInt(id.replace("jQuery", "")) > 0)) {
          id = "";
        }
      }
      return id;
    };
    startedAjaxList = [];
    $(document).ajaxStart(function(event) {
      var id;
      id = getAjaxID(event);
      startedAjaxList.push(id);
/*      if (!NProgress.isStarted()) {
        return NProgress.start();
      }*/
    });
    $(document).ajaxComplete(function(event) {
      var id, index;
      id = getAjaxID(event);
      index = startedAjaxList.indexOf(id);
      if (index > -1) {
        startedAjaxList.splice(index, 1);
      }
      if (startedAjaxList.length === 0) {
        // return NProgress.done();
      }
    });
  }

}).call(this);
