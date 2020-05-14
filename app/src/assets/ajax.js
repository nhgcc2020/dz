// export default (type='GET', url='', data={}, async=true) => {
// 	return new Promise((resolve, reject) => { //定义一个promise
// 		type = type.toUpperCase();

// 		let requestObj;
// 		if (window.XMLHttpRequest) {
// 			requestObj = new XMLHttpRequest();
// 		} else {
// 			requestObj = new ActiveXObject;
// 		}

// 		if (type == 'GET') {
// 			let dataStr = ''; //数据拼接字符串
// 			Object.keys(data).forEach(key => {
// 				dataStr += key + '=' + data[key] + '&';
// 			})
// 			dataStr = dataStr.substr(0, dataStr.lastIndexOf('&'));
// 			url = url + '?' + dataStr;
// 			requestObj.open(type, url, async);
// 			requestObj.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
// 			requestObj.send();
// 		}else if (type == 'POST') {
// 			requestObj.open(type, url, async);
// 			requestObj.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
// 			console.log(data);
// 			console.log(JSON.stringify(data));
// 			requestObj.send(JSON.stringify(data));
// 		}else {
// 			reject('error type');
// 		}

// 		requestObj.onreadystatechange = () => {
// 			if (requestObj.readyState == 4) {
// 				if (requestObj.status == 200) {
// 					let obj = requestObj.response
// 					if (typeof obj !== 'object') {
// 						obj = JSON.parse(obj);
// 					}
// 					resolve(obj);
// 				}else {
// 					reject(requestObj);
// 				}
// 			}
// 		}
// 	})
// }

// var request = function (url,type, params){
// 	if(type=="get"){
// 		 this.axios.get(url + localStorage.getItem('token'))
// 		 .then(function(data){
// 			if(data.code==0){
// 				_this.success(data)
// 			}else{
// 				_this.failed(data)
// 			}
// 		 })
// 		 .catch(err => {

//         })
// 	}else{
// 		this.axios.post(url + localStorage.getItem('token'),params)
// 		.then(function(data){
// 			if(data.code==0){
// 				_this.success(data)
// 			}else{
// 				_this.failed(data)
// 			}
// 		})
// 		.catch(err => {

//         })
// 	}
// }

// this.api = function (url, params, success, failed) {
//     if (arguments.length == 2) {
//         success = params;
//         params = null;
//     }
//     $rootScope.dialogIsHidden = false;
//     $http({
//         method: 'POST',
//         url: $rootScope.baseUrl + url,
//         timeout: 30000,
//         params: angular.extend({}, params, {
//             'longitude': $sessionStorage.longitude,
//             'latitude': $sessionStorage.latitude,
//             'inType': $rootScope.inType,
//             'XSessionId': $rootScope.XSessionId,
//             'certNo': $rootScope.certNo
//         })
//     }).success(function (ret) {
//         $rootScope.dialogIsHidden = true;
//         if (ret.errorCode > 0) {
//             $rootScope.errorHidden = false;
//             $rootScope.naomi = ret.message;
//             if (failed) {
//                 failed(ret);
//             }
//             return;
//         }
//         if (success) {
//             success(ret);
//             //$rootScope.naomi = ret.message;
//         }

//     }).error(function (data, status) {
//         var ret = {
//             errorCode: 1000,
//             message: "系统繁忙"
//         };
//         if (status == 404) {
//             ret.errorCode = status;
//             ret.message = "系统繁忙";
//         } else if (status == 408) {
//             ret.errorCode = status;
//             ret.message = "系统繁忙";
//         }
//         if (failed) {
//             $rootScope.errorHidden = false;
//             $rootScope.naomi = ret.message;
//             failed(ret);
//         }

//         $rootScope.dialogIsHidden = true;
//     });
// };