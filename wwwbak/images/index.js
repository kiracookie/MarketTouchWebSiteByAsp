jQuery(document).ready(function($){
		
$(function(){
  var _tab=$('ul#clnav>li');
 var _con=$('div#clcontents>div');
 var _conthis;
 var _index=0;
 _tab.click(function(){
  _index=_tab.index(this);
  $(this).addClass('current').siblings().removeClass('current');
  _con.filter(':visible').stop(true,true).fadeOut(200,function(){
   _con.eq(_index).fadeIn(200)
  })
 });
})
	
	//var _html_width = parseInt($('html').width());
	//var _html_height = parseInt($('html').height());
	var _html_height = parseInt(window.screen.availHeight);

	var _html_width = parseInt(window.screen.availWidth);
	//var _html_height = parseInt(window.screen.availHeight);

	$(window).resize(function(){//alert($('#index_body').width()+'='+(parseInt(window.screen.width)-21));
		if($('#index_body').width() < (parseInt(window.screen.width)-22)){
			$('#index_body').css({'overflow':'auto'});
		}else if($('#index_body').width() >= (parseInt(window.screen.width)-22)){
			$('#index_body').css({'overflow':'hidden'});
		}
		//alert($('#index_body').width()+'='+document.body.scrollWidth);
	});
	
	

	$('#bg_banner').width(_html_width);
	$('#bg_banner').height(_html_height);
	$('#bg_banner ul').width(_html_width*4);
	$('#bg_banner ul').height(_html_height);
	$('#bg_banner li').width(_html_width);
	$('#bg_banner li').height(_html_height);
	


	$('#pxs_container').width(_html_width);
	
	$('#pxs_container ul').width(_html_width*4);
	
	$('#pxs_container li').width(_html_width);
	
	
	

	var omouseenter;
	var omouseleave;
	/*
	*/
	$('#nav>li').hover(
		function(){
			var othis = $(this);
			
			omouseenter = window.setTimeout(function(){
				if(typeof(othis.find('.smenu')) == 'object'){
					othis.find('.smenu').fadeIn(200).animate({'top':'65px'},{queue:false},200).parent().siblings('li').find('.smenu').fadeOut(200).animate({'top':'0px'},{queue:false},200);
				}
			},50);
		},
		function(){
			var othis = $(this);
			window.clearTimeout(omouseenter);
			othis.find('.smenu').fadeOut(200).animate({'top':'0px'},{queue:false},200);
		}
		);
	
	var j = 0;
	var obanner;
	$('#pxs_container ul').append($('#pxs_container ul').html());
	$('#bg_banner ul').append($('#bg_banner ul').html());
	obanner = window.setInterval(function(){
		if($('#pxs_container').scrollLeft() == _html_width*3){$('#pxs_container').scrollLeft('0');}
		$('#pxs_container').animate({'scrollLeft':$('#pxs_container').scrollLeft() + _html_width},1500,'easeInExpo');
		if($('#bg_banner').scrollLeft() == _html_width*3){$('#bg_banner').scrollLeft('0');}
		$('#bg_banner').animate({'scrollLeft':$('#bg_banner').scrollLeft() + _html_width},2000,'easeInOutExpo');
	},8000);
	
	$('#pxs_container img').hover(
		function(){
			window.clearInterval(obanner);
		},
		function(){
			obanner = window.setInterval(function(){
		if($('#pxs_container').scrollLeft() == _html_width*3){$('#pxs_container').scrollLeft('0');}
		$('#pxs_container').animate({'scrollLeft':$('#pxs_container').scrollLeft() + _html_width},1500,'easeInExpo');
		if($('#bg_banner').scrollLeft() == _html_width*3){$('#bg_banner').scrollLeft('0');}
		$('#bg_banner').animate({'scrollLeft':$('#bg_banner').scrollLeft() + _html_width},2000,'easeInOutExpo');
	},8000);
		}
		);
	
	
	
	$('#clbutton').toggle(
		function(){
			$('#cleft').animate({'left':'0'},'slow');
			},
		function(){
			$('#cleft').animate({'left':'-235px'},'slow');
			}
		);
	
	$('#crbutton').click(
		function(){
			$('#cright').animate({'right':'-300px'},'slow',function(){$('#cright1').show().animate({'left':'-38px'});});
			}
		);
	
	$('#cright1').click(
		function(){
			$('#cright').animate({'right':'0px'},'slow');
			$(this).animate({'left':'0px'}).hide();
			}
		);


	var occ;
	window.clearTimeout(occ);
	occ = window.setTimeout(function(){$('.cclist').each(function(i){
		$('.textlist').fadeIn(2000);
		if($(this).hasClass('ccimgzte')){
			$(this).fadeIn(2000).animate({'left':'220px','top':'0px'},{duration:1000,queue:false},2000,'easeInOutExpo');
			}
		if($(this).hasClass('ccimgwieson')){
			$(this).fadeIn(2000).animate({'left':'50px','top':'155px'},{duration:1000,queue:false},2000,'easeInOutExpo');
			}
		if($(this).hasClass('ccimghitachi')){
			$(this).fadeIn(2000).animate({'left':'220px','top':'180px'},{duration:1000,queue:false},2000,'easeInOutExpo');
			}
		if($(this).hasClass('ccimghuawei')){
			$(this).fadeIn(2000).animate({'left':'390px','top':'107px'},{duration:1000,queue:false},2000,'easeInOutExpo');
			}
		if($(this).hasClass('ccimgemerson')){
			$(this).fadeIn(2000).animate({'left':'50px','top':'330px'},{duration:1000,queue:false},2000,'easeInOutExpo');
			}
		});},2000);



	$('#fnav_nav li').hover(
		function(){
			var nindex = $(this).index();
			$(this).find('img.bimg').fadeIn();
			$(this).find('h5').css({'color':'#a90000'});
		
			$(this).find('.fnav_content_span').show().parent().siblings('li').find('.fnav_content_span').hide();
			},
		function(){
			$(this).find('img.bimg').fadeOut();
			$(this).find('h5').css({'color':'#ffffff'});
			$(this).find('.fnav_content_span').hide();

			}
	);

		
	
	$('.cclist').hover(
		function(){
			var othis = $(this);
			var occc;
			window.clearTimeout(occc);
			occc = window.setTimeout(function(){
			othis.animate({borderTopColor:'#610000',borderRightColor:'#610000',borderBottomColor:'#610000',borderLeftColor:'#610000'});
			},200);
		},
		function(){
			var othis = $(this);
			var occch
			window.clearTimeout(occch);
			occch = window.setTimeout(function(){
			othis.animate({borderTopColor:'#fff',borderRightColor:'#fff',borderBottomColor:'#fff',borderLeftColor:'#fff'});
			},200);
			}
	);
	
	
	
	$('.list_content li').hover(
		function(){
			$(this).addClass('lihover');
			},
		function(){
			$(this).removeClass('lihover');
			}
	);
	
	
	
	
	
	
	});
