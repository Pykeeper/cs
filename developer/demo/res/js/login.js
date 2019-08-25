$(function () {
    login();
})

function login() {
    var userObj = {
        'abcd': {
            user: 'abcd',
            password: '1234',
            page: 'main-1'
        }
    }
    $('#btnLogin').click(function () {
        var user = $('#user').val(),
            password = $('#password').val();
        if (user != '' && password != '') {
            if (userObj[user]) {
                if (password == userObj[user].password) {
                    layer('登录中');
                    setTimeout(function () {
                        layer('登录成功');
                    }, 500);
                    setTimeout(function () {
                        window.location.href = userObj[user].page + '.html';
                    }, 1500);
                } else {
                    layer('密码不正确');
                }
            } else {
                layer('不存在该用户');
            }
        } else {
            layer('用户名和密码不能为空');
        }
    });
    $(document).keydown(function (event) {
        if (event.keyCode == 13) {
            $("#btnLogin").click();
        }
    });

}

function layer(data) {
    console.log(data);
    var $layer = $('.layer');
    $layer.removeClass('hide').html(data);
    setTimeout(function () {
        $layer.addClass('hide')
    }, 3000);
}