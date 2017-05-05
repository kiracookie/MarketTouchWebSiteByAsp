$(function () {
    $("#myCarousel").swipe({
        swipeLeft: function () {
            $(this).carousel('next');
        },
        swipeRight: function () {
            $(this).carousel('prev');
        },
    });
    startMarquee();
});

function startMarquee() {
    $(".item").eq(0).addClass("active");
    $("#myCarousel").carousel('cycle');
}

function changeMarquee(pics, id) {
    var picList = pics.split("|");
    var html = "";
    for (var i = 0; i < picList.length; i++) {
        html += '<div class="item"><img src="' + picList[i] + '"/></div>';
    }
    // $("#" + id).fadeOut("normal", function () {
        $("#" + id).html(html);
    // });

    startMarquee();
}