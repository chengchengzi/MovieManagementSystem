        ////��ȡ��Ļ��� ���ؼ����Ը�ֵ��
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
            //���ñ�ˣ����峤�ȵ�1/3
            var _line = parseInt($(window).height() / 3);
            $(window).scroll(function () {
                //������һ�������ݿ���붥���ĳ���-1/3���峤�ȣ�����ർ���̶���λ
                if ($(window).scrollTop() >= $('.fl_r li').eq(0).offset().top - _line - 1) {
                    //���붥����λ�ã������峤��-�ؼ����ȣ�/2
                    var topNum = (document.documentElement.clientHeight - $('.fl_l').off().height()) / 2;

                    $('.fl_l').css({ 'position': 'fixed', 'top': topNum, 'right': 0, 'display': 'block' })
                } else {
                    $('.fl_l').css({ 'position': '', 'top': '', 'display': 'none' })
                };
                //���ؼ���һ����Ԫ�����һ��class:active�� active������������
                $('.fl_l li').eq(0).addClass('active');
                //���������λ��,��ർ����active
                $('.fl_r li').each(function () {
                    //���ұ��ı��������봰���ȹ���ʱ����߶�Ӧ��li��ѡ��
                    var _target = parseInt($(this).offset().top - $(window).scrollTop() - _line);
                    var _i = $(this).index();
                    if (_target <= 0) {
                        $('.fl_l li').removeClass('active');
                        $('.fl_l li').eq(_i).addClass('active');

                        //code00�����DIV���֡�
                        if (_i == 0) {

                            //�����Լ���
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
                            //����ǰ���
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
                        //�������ҳ��ײ�������ർ�����һ����active
                    else if ($(document).height() == $(window).scrollTop() + $(window).height()) {
                        $('.fl_l li').removeClass('active');
                        $('.fl_l li').eq($('.fl_r li').length - 1).addClass('active');
                    }
                    if (_i == 0 && _target > 0) {
                        //�������Ϸ�Div��̬���
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
            //�����߲˵���ת����Ӧ�ұ�����
            $('.fl_l li').click(function () {
                $(this).addClass('active').siblings().removeClass('active');
                var _i = $(this).index();
                $('body, html').animate({ scrollTop: $('.fl_r li').eq(_i).offset().top - _line }, 500);
            });
        });