// JavaScript 文档
$(function(){
	$(".win-homepage").click(function() {
		if (document.all) {
			document.body.style.behavior = 'url(#default#homepage)';
			document.body.setHomePage(document.URL);
		} else {
			alert("设置首页失败，请手动设置！");
		}
	});
	$(".win-favorite").click(function() {
		var sURL = document.URL;
		var sTitle = document.title;
		try {
			window.external.addFavorite(sURL, sTitle);
		} catch (e) {
			try {
				window.sidebar.addPanel(sTitle, sURL, "");
			} catch (e) {
				alert("加入收藏失败，请使用Ctrl+D进行添加");
			}
		}
	});
	$(".win-forward").click(function() {
		window.history.forward(1);
	});
	$(".win-back").click(function() {
		window.history.back(-1);
	});
	$(".win-backtop").click(function() {
		$('body,html').animate({
			scrollTop: 0
		}, 1000);
		return false;
	});
	$(".win-refresh").click(function() {
		window.location.reload();
	});
	$(".win-print").click(function() {
		window.print();
	});
	$(".win-close").click(function() {
		window.close();
	});
	$('textarea, input, select').blur(function() {
		var e = $(this);
		if (e.attr("data-validate")) {
			e.closest('.field').find(".input-help").remove();
			var $checkdata = e.attr("data-validate").split(',');
			var $checkvalue = e.val();
			var $checkstate = true;
			var $checktext = "";
			if (e.attr("placeholder") == $checkvalue) {
				$checkvalue = "";
			}
			if ($checkvalue != "" || e.attr("data-validate").indexOf("required") >= 0) {
				for (var i = 0; i < $checkdata.length; i++) {
					var $checktype = $checkdata[i].split(':');
					if (!$finaluicheck(e, $checktype[0], $checkvalue)) {
						$checkstate = false;
						$checktext = $checktext + "<li>" + $checktype[1] + "</li>";
					}
				}
			};
			if ($checkstate) {
				e.closest('.form-group').removeClass("check-error");
				e.parent().find(".input-help").remove();
				e.closest('.form-group').addClass("check-success");
			} else {
				e.closest('.form-group').removeClass("check-success");
				e.closest('.form-group').addClass("check-error");
				e.closest('.field').append('<div class="input-help"><ul>' + $checktext + '</ul></div>');
			}
		}
	});
	$('textarea, input, select').focus(function(){
		$(this).parent().find(".input-help").remove();
	});
	$finaluicheck = function(element, type, value) {
		$finalui = value.replace(/(^\s*)|(\s*$)/g, "");
		switch (type) {
			case "required":
				return /[^(^\s*)|(\s*$)]/.test($finalui);
				break;
			case "chinese":
				return /^[\u0391-\uFFE5]+$/.test($finalui);
				break;
			case "number":
				return /^([+-]?)\d*\.?\d+$/.test($finalui);
				break;
			case "integer":
				return /^-?[1-9]\d*$/.test($finalui);
				break;
			case "plusinteger":
				return /^[0-9]\d*$/.test($finalui);
				break;
			case "unplusinteger":
				return /^-[1-9]\d*$/.test($finalui);
				break;
			case "znumber":
				return /^[1-9]\d*|0$/.test($finalui);
				break;
			case "fnumber":
				return /^-[1-9]\d*|0$/.test($finalui);
				break;
			case "double":
				return /^[-\+]?\d+(\.\d+)?$/.test($finalui);
				break;
			case "plusdouble":
				return /^[+]?\d+(\.\d+)?$/.test($finalui);
				break;
			case "unplusdouble":
				return /^-[1-9]\d*\.\d*|-0\.\d*[1-9]\d*$/.test($finalui);
				break;
			case "english":
				return /^[A-Za-z]+$/.test($finalui);
				break;
			case "username":
				return /^[a-z]\w{3,}$/i.test($finalui);
				break;
			case "mobile":
				return /^\s*(15\d{9}|13\d{9}|14\d{9}|17\d{9}|18\d{9})\s*$/.test($finalui);
				break;
			case "phone":
				return /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/.test($finalui);
				break;
			case "tel":
				return /^((\(\d{3}\))|(\d{3}\-))?13[0-9]\d{8}?$|15[89]\d{8}?$|170\d{8}?$|147\d{8}?$/.test($finalui) || /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/.test($finalui);
				break;
			case "email":
				return /^[^@]+@[^@]+\.[^@]+$/.test($finalui);
				break;
			case "url":
				return /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/.test($finalui);
				break;
			case "ip":
				return /^[\d\.]{7,15}$/.test($finalui);
				break;
			case "qq":
				return /^[1-9]\d{4,10}$/.test($finalui);
				break;
			case "currency":
				return /^\d+(\.\d+)?$/.test($finalui);
				break;
			case "zipcode":
				return /^[1-9]\d{5}$/.test($finalui);
				break;
			case "chinesename":
				return /^[\u0391-\uFFE5]{2,15}$/.test($finalui);
				break;
			case "englishname":
				return /^[A-Za-z]{1,161}$/.test($finalui);
				break;
			case "age":
				return /^[1-99]?\d*$/.test($finalui);
				break;
			case "date":
				return /^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/.test($finalui);
				break;
			case "datetime":
				return /^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-)) (20|21|22|23|[0-1]?\d):[0-5]?\d:[0-5]?\d$/.test($finalui);
				break;
			case "idcard":
				return /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/.test($finalui);
				break;
			case "bigenglish":
				return /^[A-Z]+$/.test($finalui);
				break;
			case "smallenglish":
				return /^[a-z]+$/.test($finalui);
				break;
			case "color":
				return /^#[0-9a-fA-F]{6}$/.test($finalui);
				break;
			case "ascii":
				return /^[\x00-\xFF]+$/.test($finalui);
				break;
			case "md5":
				return /^([a-fA-F0-9]{32})$/.test($finalui);
				break;
			case "zip":
				return /(.*)\.(rar|zip|7zip|tgz)$/.test($finalui);
				break;
			case "img":
				return /(.*)\.(jpg|gif|ico|jpeg|png)$/.test($finalui);
				break;
			case "doc":
				return /(.*)\.(doc|xls|docx|xlsx|pdf)$/.test($finalui);
				break;
			case "mp3":
				return /(.*)\.(mp3)$/.test($finalui);
				break;
			case "video":
				return /(.*)\.(rm|rmvb|wmv|avi|mp4|3gp|mkv)$/.test($finalui);
				break;
			case "flash":
				return /(.*)\.(swf|fla|flv)$/.test($finalui);
				break;
			case "radio":
				var radio = element.closest('form').find('input[name="' + element.attr("name") + '"]:checked').length;
				return eval(radio == 1);
				break;
			default:
				var $test = type.split('#');
				if ($test.length > 1) {
					switch ($test[0]) {
						case "compare":
							return eval(Number($finalui) + $test[1]);
							break;
						case "regexp":
							return new RegExp($test[1], "gi").test($finalui);
							break;
						case "length":
							var $length;
							if (element.attr("type") == "checkbox") {
								$length = element.closest('form').find('input[name="' + element.attr("name") + '"]:checked').length;
							} else {
								$length = $finalui.replace(/[\u4e00-\u9fa5]/g, "***").length;
							}
							return eval($length + $test[1]);
							break;
						case "ajax":
							var $getdata;
							var $url = $test[1] + $finalui;
							$.ajaxSetup({
								async: false
							});
							$.getJSON($url, function(data) {
								$getdata = data.getdata;
							});
							if ($getdata == "true") {
								return true;
							}
							break;
						case "repeat":
							return $finalui == jQuery('input[name="' + $test[1] + '"]').eq(0).val();
							break;
						default:
							return true;
							break;
					}
					break;
				} else {
					return true;
				}
		}
	};
	$('form').submit(function() {
		$(this).find('input[data-validate],textarea[data-validate],select[data-validate]').trigger("blur");
		var numError = $(this).find('.check-error').length;
		if (numError) {
			$(this).find('.check-error').first().find('input[data-validate],textarea[data-validate],select[data-validate]').first().focus().select();
			return false;
		}
	});
	$('.form-reset').click(function() {
		$(this).closest('form').find(".input-help").remove();
		$(this).closest('form').find('.form-submit').removeAttr('disabled');
		$(this).closest('form').find('.form-group').removeClass("check-error");
		$(this).closest('form').find('.form-group').removeClass("check-success");
	});
	$('.form-x .form-group').append('<div class="fc"></div>');
});