$(function () {
    var waitTime = 1000 * 60 * 1;//分钟
    var startTime = endTime = new Date();
    var Timer = window.setInterval(function () {
        endTime = new Date();
        if (endTime.getTime() - startTime.getTime() > waitTime) {
            $.ajax('/list/?61_1.html?' + new Date().getTime(), {
                success: function (res) {
                    var json = JSON.parse(res);
                    var noticetime = new Date(json.date);
                    // 1.如果有当天公告显示公告 todo
                    if (new Date().getTime() - noticetime.getTime() < (1000 * 60 * 60 * 24)) {
                        window.location.href = json.link;
                    } else {
                        // 2.如果没有则显示轮播 todo
                        location.href = '/list/?60_1.html?' + new Date().getTime();
                        // $.ajax('/list/?60_1.html?' + new Date().getTime(), {
                        //     success: function (res) {
                        //         res = res.replace(",]", "]");
                        //         var json = JSON.parse(res);
                        //         alert(json);
                        //     }
                        // })

                    }
                }
            })

        }
        console.log(endTime.getTime() - startTime.getTime());
    }, 1000);
    $(document).scroll(function () {
        startTime = new Date();
    })
    $(document).click(function () {
        startTime = new Date();
    })

})