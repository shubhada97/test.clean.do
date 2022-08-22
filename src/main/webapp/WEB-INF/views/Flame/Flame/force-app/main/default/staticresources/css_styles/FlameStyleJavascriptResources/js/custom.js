$(document).ready(function(){
	fullHt();
	
	$('#banner-mob').owlCarousel({
    loop:true,
    margin:0,
    nav:false,
	dots:false,
	autoplay:true,
	autoplayTimeout:1000,
	smartSpeed:600,
    responsive:{
        0:{
            items:1
        }
    }
	});
	
	$('#features').owlCarousel({
    loop:true,
    margin:5,
    nav:true,
	dots:false,
	navText:false,
    responsive:{
        0:{
            items:1
        },
		768:{
            items:2
        },
        992:{
            items:3
        }
    }
	});
	
	$('#lnf-slider').owlCarousel({
		center: true,
		items:6,
		loop:true,
		margin:10,
		responsive:{
			600:{
				items:3
			}
		}
	});

});

function fullHt(){
	var fullht = window.innerHeight;
	$(".fullHt").css("min-height", fullht + "px");
}
$(window).resize(function(){
	fullHt();
})

$(window).load(function(){
				
	$("#content-1,#content-2").mCustomScrollbar({
		theme:"minimal"
	});
	
});