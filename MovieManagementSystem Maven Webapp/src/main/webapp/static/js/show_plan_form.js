//新增影城表单验证js 
//及时验证用户名
 function checkfilm_id(){
   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
   var check; 
   var film_id = document.getElementById("film_id").value; 
   if (film_id == "") { 
    alert("影片编号不可为空");
    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
    document.getElementById("film_id").focus();
    check = false; 
   } else if(film_id){ 
    check = true;
   } 
   return check; 
  } 
 
function checkfilm_name(){
   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
   var check; 
   var film_name = document.getElementById("film_name").value; 
   if (film_name == "") { 
    alert("影片名称不可为空");
    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
    document.getElementById("film_name").focus();
    check = false;   
   } else { 
    check = true; 
   } 
   return check; 
  } 

function checkfilm_dirctor(){
   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
   var check; 
   var film_dirctor = document.getElementById("film_dirctor").value; 
   if (film_dirctor == "") { 
    alert("导演不可为空");
    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
    document.getElementById("film_dirctor").focus();
    check = false; 
   } else { 
    check = true; 
   } 
   return check; 
  } 

function checkfilm_major(){
	   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
	   var check; 
	   var film_major = document.getElementById("film_major").value; 
	   if (film_major == "") { 
	    alert("主演不可为空");
	    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
	    document.getElementById("film_major").focus();
	    check = false; 
	   } else { 
	    check = true; 
	   } 
	   return check; 
	  }

function checkfilm_show_time(){
	   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
	   var check; 
	   var film_show_time = document.getElementById("film_show_time").value; 
	   if (film_show_time == "") { 
	    alert("上映时间不可为空");
	    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
	    document.getElementById("film_show_time").focus();
	    check = false; 
	   } else { 
	    check = true; 
	   } 
	   return check; 
	  }

function checkfilm_duration(){
	   //在每个函数中定义check变量是为了在表单提交后，能够逐个验证每个函数是否通过，很好很好。（以下同理）
	   var check; 
	   var film_duration = document.getElementById("film_duration").value; 
	   if (film_duration == "") { 
	    alert("影片时长不可为空");
	    //此处甚妙，既然你在此处输入错误，那么按理说当然要在此处继续输入了。（在此处继续获取焦点！）
	    document.getElementById("film_duration").focus();
	    check = false; 
	   } else { 
	    check = true; 
	   } 
	   return check; 
	  }

 //提交表单时所有都验证一遍(若任何一个验证不通过，则返回为false，阻止表单提交)
 function check() { 
  var check = checkfilm_id() && checkfilm_name() && checkfilm_dirctor() && checkfilm_major() && checkfilm_show_time() && checkfilm_duration(); 
  if(check == true){
  	return check;
  }
  return check;
 }