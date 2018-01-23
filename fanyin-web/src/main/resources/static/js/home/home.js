$(function(){
	
	$("body").layout({
		fit:true
	});
	
	$(".change_pwd_btn").on("click",function(){
		changePwd();
	});
	
	$(".logout_btn").on("click",function(){
		logout();
	});
	//增加首页tabs信息
	addTabs("首页","/admin/portal");
	
	var accordion = new Accordion($('#accordion'), false);
	
	$("#accordion li a").on("click",function(){
		var url = $(this).attr("rel");
		addTabs($(this).text(),url,true);
	});
});

var Accordion = function(el, multiple) {
	this.el = el || {};
	this.multiple = multiple || false;
	var links = this.el.find('.link,.link2');
	links.on('click', {el: this.el, multiple: this.multiple}, this.dropdown);
}
Accordion.prototype.dropdown = function(e) {
	var $el = e.data.el;
		$this = $(this),
		$next = $this.next();

		$next.slideToggle();
		$this.parent().toggleClass('open');

	if (!e.data.multiple) {
		if($this.attr("class") == "link"){
			$el.find('.submenu').not($next).slideUp().parent().removeClass('open');
		}else{
			$el.find('.thirdmenu').not($next).not($this.parent('.link')).slideUp().parent().removeClass('open');
		}
		
	};
}	
/**
 * 修改原始密码
 */
var changePwd = function(){
	
};

/**
 * 注销
 */
var logout = function(){
	$.messager.confirm("提示","您确定要退出该系统吗?",function(r){
		if(r){
			$.post("/admin/logout",function(data){
				if(data.result){
					window.location.href = window.location.href;
				}
			},"json");
		}
	});
};
























