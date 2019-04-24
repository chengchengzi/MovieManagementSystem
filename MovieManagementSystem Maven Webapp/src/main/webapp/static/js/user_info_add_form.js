//新增影城表单验证js 
//及时验证用户名
 function checkuser_info_id(){
   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
   var check; 
   var film_hall_id = document.getElementById("user_info_id").value; 
   if (film_hall_id == "") { 
    alert("员工编号不可为空");
    document.getElementById("user_info_id").focus();
    check = false; 
   } else if(film_hall_id){ 
    check = true; 
   } 
   return check; 
  } 
function checkuser_info_name(){
   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
   var check; 
   var film_hall_location = document.getElementById("user_info_name").value; 
   if (film_hall_location == "") { 
    alert("员工姓名不可为空");
    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
    document.getElementById("user_info_name").focus();
    check = false;   
   } else {  
    check = true; 
   } 
   return check; 
  }  
function checkuser_info_password(){
	   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
	   var check; 
	   var film_hall_numbers = document.getElementById("user_info_password").value; 
	   if (film_hall_numbers == "") { 
	    alert("员工初始密码不可为空");
	    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
	    document.getElementById("user_info_password").focus();
	    check = false; 
	   } else { 
	    check = true; 
	   } 
	   return check; 
	  }
function checkuser_info_grade(){
	   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
	   var check; 
	   var film_hall_numbers = document.getElementById("user_info_grade").value; 
	   if (film_hall_numbers == "") { 
	    alert("员工等级不可为空");
	    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
	    document.getElementById("user_info_grade").focus();
	    check = false; 
	   } else { 
	    check = true; 
	   } 
	   return check; 
	  }
 //提交表单时所有都验证一遍(若任何一个验证不通过，则返回为false，阻止表单提交)
 function check() { 
  var check = checkuser_info_id() && checkuser_info_name() && checkuser_info_password() && checkuser_info_grade(); 
  if(check == true){
  	return check;
  }
  return check;
 }