        ////提取屏幕宽度 给控件属性赋值。
        //window.onload = function () {
        //    var widthNumber = screen.width;
        //    var rightNumber = -(widthNumber - $('.box').off().width()) / 2;
        //    $('.fl_r').css({ 'width': widthNumber, 'right': rightNumber })
        //    $('.fl_r li .flrDiv').css({ 'width': widthNumber })
        //}


        function setDiv(jobdiv, key, value) {
            var oDiv = document.getElementById(jobdiv);
            oDiv.style[key] = value;
        }


        $(function () {
            //设置标杆，窗体长度的1/3
            var _line = parseInt($(window).height() / 3);
            $(window).scroll(function () {
                //滚动第一个（内容块距离顶部的长度-1/3窗体长度），左侧导航固定定位
                if ($(window).scrollTop() >= $('.fl_r li').eq(0).offset().top - _line - 1) {
                    //距离顶部的位置，（窗体长度-控件长度）/2
                    var topNum = (document.documentElement.clientHeight - $('.fl_l').off().height()) / 2;

                    $('.fl_l').css({ 'position': 'fixed', 'top': topNum, 'right': 0, 'display': 'block' })
                } else {
                    $('.fl_l').css({ 'position': '', 'top': '', 'display': 'none' })
                };
                //给控件第一个子元素添加一个class:active。 active的描述在上面
                $('.fl_l li').eq(0).addClass('active');
                //滚动到标杆位置,左侧导航加active
                $('.fl_r li').each(function () {
                    //当右边文本顶部距离窗体宽度过半时，左边对应的li被选中
                    var _target = parseInt($(this).offset().top - $(window).scrollTop() - _line);
                    var _i = $(this).index();
                    if (_target <= 0) {
                        $('.fl_l li').removeClass('active');
                        $('.fl_l li').eq(_i).addClass('active');

                        //code00区域的DIV隐现。
                        if (_i == 0) {

                            //处理自己的
                            $(".code00").show();
                            $('.animationSandboxIn0').addClass('fadeInRight animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                                $(this).removeClass('fadeInRight animated');
                                $(this).removeClass('animationSandboxIn0');
                                $(this).addClass('animationSandboxOut0');
                            });
                            $('.animationSandboxIn1').addClass('fadeInLeft animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                                $(this).removeClass('fadeInLeft animated');
                                $(this).removeClass('animationSandboxIn1');
                                $(this).addClass('animationSandboxOut1');
                            });
                        }
                        if (_i == 1) {
                            //处理前面的
                            $('.animationSandboxOut0').addClass('fadeOutLeft animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                                $(this).removeClass('fadeOutLeft animated');
                                $(this).removeClass('animationSandboxOut0');
                                $(this).addClass('animationSandboxIn0');
                            });
                            $('.animationSandboxOut1').addClass('fadeOutRight animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                                $(this).removeClass('fadeOutRight animated');
                                $(this).removeClass('animationSandboxOut1');
                                $(this).addClass('animationSandboxIn1');
                                $(".code00").hide();
                            });
                        }

                    }
                        //如果到达页面底部，给左侧导航最后一个加active
                    else if ($(document).height() == $(window).scrollTop() + $(window).height()) {
                        $('.fl_l li').removeClass('active');
                        $('.fl_l li').eq($('.fl_r li').length - 1).addClass('active');
                    }
                    if (_i == 0 && _target > 0) {
                        //处理最上放Div动态情况
                        $('.animationSandboxOut0').addClass('fadeOutLeft animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                            $(this).removeClass('fadeOutLeft animated');
                            $(this).removeClass('animationSandboxOut0');
                            $(this).addClass('animationSandboxIn0');
                        });
                        $('.animationSandboxOut1').addClass('fadeOutRight animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                            $(this).removeClass('fadeOutRight animated');
                            $(this).removeClass('animationSandboxOut1');
                            $(this).addClass('animationSandboxIn1');
                            $(".code00").hide();
                        });
                    }
                });
            });
            //点击左边菜单跳转到相应右边内容
            $('.fl_l li').click(function () {
                $(this).addClass('active').siblings().removeClass('active');
                var _i = $(this).index();
                $('body, html').animate({ scrollTop: $('.fl_r li').eq(_i).offset().top - _line }, 500);
            });
        });