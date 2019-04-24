//新增影城表单验证js 
//及时验证用户名
 function checkfilm_hall_id(){
   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
   var check; 
   var film_hall_id = document.getElementById("film_hall_id").value; 
   if (film_hall_id == "") { 
    alert("影厅编号不可为空");
    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
    document.getElementById("film_hall_id").focus();
    check = false; 
   } else if(film_hall_id){ 
    check = true; 
   } 
   return check; 
  } 
function checkfilm_hall_location(){
   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
   var check; 
   var film_hall_location = document.getElementById("film_hall_location").value; 
   if (film_hall_location == "") { 
    alert("影厅位置不可为空");
    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
    document.getElementById("film_hall_location").focus();
    check = false;   
   } else { 
    check = true; 
   } 
   return check; 
  } 
function checkfilm_hall_numbers(){
   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
   var check; 
   var film_hall_numbers = document.getElementById("film_hall_numbers").value; 
   if (film_hall_numbers == "") { 
    alert("影厅总座位数不可为空");
    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
    document.getElementById("film_hall_numbers").focus();
    check = false; 
   } else { 
    check = true; 
   } 
   return check; 
  } 
 //提交表单时所有都验证一遍(若任何一个验证不通过，则返回为false，阻止表单提交)
 function check() { 
  var check = checkfilm_hall_id() && checkfilm_hall_location() && checkfilm_hall_numbers(); 
  if(check == true){
  	return check;
  }
  return check;
 }