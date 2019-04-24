package com.ssm.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

@Controller  
@RequestMapping("/file")  
public class FileController {  
 
    @RequestMapping("/upLoad")  
    public void fileUpload(HttpServletRequest request,MultipartFile file,ModelMap map) throws IOException {
    	HttpSession session = request.getSession();
    	//图片上传成功后，将图片的地址写到数据库
    	 String filePath = "E:\\upload";//保存图片的路径
    	 //获取原始图片的拓展名
    	 String originalFilename = file.getOriginalFilename();
    	 //新的文件名字
    	  String newFileName = UUID.randomUUID()+originalFilename;
    	  File targetFile = new File(filePath,newFileName); 
    	  file.transferTo(targetFile);
      	  session.setAttribute("filePath", newFileName);         
    }  
}  
