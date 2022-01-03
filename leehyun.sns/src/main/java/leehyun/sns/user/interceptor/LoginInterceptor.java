package leehyun.sns.user.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

   @Override
   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
         throws Exception {
      boolean isLogin = true;
      if(!request.getRequestURI().equals("/sns/user/login") 
    		  && !request.getRequestURI().equals("/sns/admin/main")
    		  && !request.getRequestURI().equals("/sns/user/addUser") 
    		  && !request.getRequestURI().equals("/sns/user/findUser")
    		  && !request.getRequestURI().equals("/sns/user/mail")
    		  && !request.getRequestURI().equals("/sns/user/findId")
    		  && !request.getRequestURI().equals("/sns/user/findIdOut")
    		  && !request.getRequestURI().equals("/sns/user/findPw")
    		  && !request.getRequestURI().equals("/sns/user/findPwProc")
    		  && !request.getRequestURI().equals("/sns/user/findPwOut")
    		  && !request.getRequestURI().equals("/sns/user/modifyPw")
    		  && !request.getRequestURI().equals("/sns/user/pwChange")
    		  && !request.getRequestURI().equals("/sns/post/login")
    		  && !request.getRequestURI().equals("/sns/post/complaintPost")
    		  && !request.getRequestURI().equals("/sns/user/search")
    		  && !request.getRequestURI().equals("/sns/attach/common/logo")){
         String userId = (String)request.getSession().getAttribute("userId");
         if(userId != null){
            isLogin = true;
         }else{
        	response.sendRedirect("/sns/user/login");
            isLogin = false;
         }
      }
      return isLogin;
   }
}