//新增影城表单验证js 
//及时验证用户名
 function checkName(){
   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
   var check; 
   var username = document.getElementById("name").value; 
   if (username == "") { 
    alert("请输入用户名");
    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
    document.getElementById("name").focus();
    check = false; 
   } else if(username){ 
    check = true; 
   } 
   return check; 
  } 
function checkPassword(){
   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
   var check; 
   var password = document.getElementById("password").value; 
   if (password == "") { 
    alert("请输入密码");
    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
    document.getElementById("password").focus();
    check = false;   
   } else { 
    check = true; 
   } 
   return check; 
  } 
 //提交表单时所有都验证一遍(若任何一个验证不通过，则返回为false，阻止表单提交)
 function check() { 
  var check = checkName() && checkPassword();
  if(check == true){
  	return check;
  }
  return check;
 }