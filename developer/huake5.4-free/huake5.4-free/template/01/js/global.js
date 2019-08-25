$(function() {
 	//导航下拉
	$('#nav').slide({
		type: "menu",
		titCell: '.main',
		targetCell: '.sub',
		effect: 'fade',
		delayTime: 300,
		triggerTime: 100
	});
	//幻灯片
	$(".banner").slide({
		titCell: ".hd ul",
		mainCell: ".bd ul",
		effect: "fade",
		delayTime:1500,
		interTime: 5000,
		autoPlay: true,
		autoPage: true,
		trigger: "mouseover"
	});
    // 侧边栏pnav收缩展开
    $('.pnav-item>a').on('click',function(){
        if (!$('.pnav').hasClass('pnav-mini')) {
            if ($(this).next().css('display') == "none") {
                //展开未展开
                $('.pnav-item').children('ul').slideUp(300);
                $(this).next('ul').slideDown(300);
                $(this).parent('li').addClass('pnav-show').siblings('li').removeClass('pnav-show');
            }else{
                //收缩已展开
                $(this).next('ul').slideUp(300);
                $('.pnav-item.pnav-show').removeClass('pnav-show');
            }
        }
    });
    //nav-mini切换
    $('#mini').on('click',function(){
        if (!$('.pnav').hasClass('pnav-mini')) {
            $('.pnav-item.pnav-show').removeClass('pnav-show');
            $('.pnav-item').children('ul').removeAttr('style');
            $('.pnav').addClass('pnav-mini');
        }else{
            $('.pnav').removeClass('pnav-mini');
        }
    });
	//新闻滚动
	$('.index_news').slide({
		easing: 'easeInOutBack',
		autoPlay: true,
		interTime: 4000,
		delayTime: 500,
		scroll: 1,
		vis: 4,
		mainCell: '.bd',
		effect: 'topLoop'
	});
	//详情页多图
	$('#info_slideshow').slide({
		trigger : 'click'
	});
	$('.index_n1').slide({
		titCell : '.wrap',
		targetCell: '.bd',
		effect: 'slideDown'
	});
//屏幕滚动	
	var offsettop = $('#service').offset().top;
	$(window).scroll(function() {
		$('#service').animate({
			top: offsettop + $(window).scrollTop() + "px"
		}, {
			duration: 600,
			queue: false
		});
	});
//漂浮客服
	$('#service').slide({
		type: "menu",
		titCell: '.se',
		targetCell: '.content',
		effect: 'fade',
		delayTime: 0,
		triggerTime: 0
	});
	//返回顶部
	$('.gotop').click(function(){
        $('html , body').animate({scrollTop: 0},'slow');
    });
	//图片正方形
    $('.square_img img').jqthumb({
		width:$('.square_img').width(),
		height:$('.square_img').width()
	});
	$('.square_img2 img').jqthumb({
		width:$('.square_img2').width(),
		height:$('.square_img2').width()
	});
	$('.square_img3 img').jqthumb({
		width:$('.square_img3').width(),
		height:$('.square_img3').width()
	});
	$('.square_img4 img').jqthumb({
		width:$('.square_img4').width(),
		height:$('.square_img4').width()
	});
});





