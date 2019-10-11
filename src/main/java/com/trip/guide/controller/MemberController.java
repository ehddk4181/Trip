package com.trip.guide.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.trip.guide.auth.SNSLogin;
import com.trip.guide.auth.SnsValue;
import com.trip.guide.dao.MemberDAO;
import com.trip.guide.vo.MemberVO;


@RequestMapping("/member")
@Controller
public class MemberController {
	@Autowired
	MemberDAO dao;
	@Inject    //���񽺸� ȣ���ϱ� ���ؼ� �������� ����
	    JavaMailSender mailSender;     //���� ���񽺸� ����ϱ� ���� �������� ������.
	   /* MemberService memberservice; //���񽺸� ȣ���ϱ� ���� �������� ����
	*/    
	@Inject
	private SnsValue googleSns; 
	
	@Inject
	private GoogleConnectionFactory googleConnectionFactory;
	
	@Inject
	private OAuth2Parameters googleOAuth2Parameters;
	
	@RequestMapping(value = "/auth/google/callback", method = {RequestMethod.GET, RequestMethod.POST})
	public String snsLoginCallback(Model model, @RequestParam String code) throws Exception{
		SNSLogin snsLogin = new SNSLogin(googleSns);
		MemberVO snsUser = snsLogin.getUserProfile(code); //1,2�� ����
		System.out.println("Profile>>" + snsUser);
		return "/member/loginResult";
	}
	@RequestMapping(value = "/loginForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String loginForm(Model model) {
		/* ����code ������ ���� URL ���� */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("google_url", url);
		return "/member/loginForm";
	}
	
	@RequestMapping(value = "/start", method = {RequestMethod.GET, RequestMethod.POST})
	public String start() {
		return "/start"; 
	}
	
	@RequestMapping(value = "/signupForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String signupForm() {
		return "/member/signupForm";
	}
	
	@RequestMapping(value = "/deleteForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String deleteId() {
		return "/member/deleteForm";
	}
	
	@RequestMapping(value = "/myPage", method = {RequestMethod.GET, RequestMethod.POST})
	public String updateForm(Model m) {
		return "/member/updateForm";
	}

	@ResponseBody
	@RequestMapping(value = "/checkId", method = {RequestMethod.GET, RequestMethod.POST})
	public boolean checkId(MemberVO vo) {
		if(dao.checkId(vo) == null) {
			return true;
		}else {
			return false;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkidEmail", method = {RequestMethod.GET, RequestMethod.POST})
	public boolean checkidEmail(MemberVO vo) {
		System.out.println(vo);
		if(dao.checkidEmail(vo) != null) {
			return true;
		}else {
			return false;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateInfo", method = {RequestMethod.GET, RequestMethod.POST})
	public MemberVO updateInfo(MemberVO vo) {
		System.out.println(dao.checkId(vo));
		return dao.checkId(vo);
	}
	
	@RequestMapping(value = "/signup", method = {RequestMethod.GET, RequestMethod.POST})
	public String signup(MemberVO vo) {
		if (dao.selectOne(vo) == null) {
		if (dao.signup(vo) != 0) {
			return "/member/loginForm";
		}else {
			return "/member/signupForm";
			}
		
		}
	return "/member/signupForm";
	}
	@ResponseBody
	@RequestMapping(value = "login", method = {RequestMethod.GET, RequestMethod.POST})
	public boolean login(MemberVO vo, HttpSession hs) {
		System.out.println(vo);
		if(dao.login(vo) != null) {
			hs.setAttribute("memberId", vo.getMemberId());
			return true;
		}else {
			return false;
		}
		
	}
	
	@RequestMapping(value = "/logout", method = {RequestMethod.GET, RequestMethod.POST})
	public String logout(MemberVO vo, HttpSession hs) {
			hs.invalidate();
			return "redirect:/";
	}
	
	@RequestMapping(value = "idfind", method = {RequestMethod.GET, RequestMethod.POST})
	public boolean idfind(MemberVO vo) {
		if(dao.idfind(vo) == null) {
			return true;
		}else {
			return false;
		}
	}
	
	@RequestMapping(value = "idfindForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String idfindForm() {
			return "/member/idfindForm";
	}
	
	@RequestMapping(value = "/deleteId", method = {RequestMethod.GET, RequestMethod.POST})
	public String deleteId(MemberVO vo, HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		vo.setMemberId(memberId);
		session.invalidate();
		dao.deleteId(vo);
		return "redirect:/";
	}
	
	@RequestMapping(value = "updateId", method = {RequestMethod.GET, RequestMethod.POST})
	public String updateId(MemberVO vo, HttpSession session) {
		String memberId = (String)session.getAttribute("memberId");
		vo.setMemberId(memberId);
		dao.updateId(vo);
		return "redirect:/";
	}
	
 
    
    
    
    //�α��� ���� ����
    private static final Logger logger=
    LoggerFactory.getLogger(EmailController.class);
    private static final String String = null;

    // mailSending �ڵ�
        @RequestMapping( value = "auth" , method=RequestMethod.POST )
        public ModelAndView mailSending(HttpServletRequest request, String memberEmail, HttpServletResponse response_email) throws IOException {
 
            Random r = new Random();
            int dice = r.nextInt(4589362) + 49311; //�̸��Ϸ� �޴� �����ڵ� �κ� (����)
            
            String setfrom = "tkddml8950@gmail.com";
            String tomail = request.getParameter("memberEmail"); // �޴� ��� �̸���
            String title = "ȸ������ ������ȣ�Դϴ�."; // ����
            String content =
            
            System.getProperty("line.separator")+ //���پ� �ٰ����� �α����� �ۼ� 
            System.getProperty("line.separator")+         
            "�ȳ��ϼ��� ȸ���� ���� Ȩ�������� ã���ּż� �����մϴ�"
            +System.getProperty("line.separator")+
            System.getProperty("line.separator")+
            " ������ȣ�� " +dice+ " �Դϴ�. "
            +System.getProperty("line.separator")+
            System.getProperty("line.separator")+
            "������ ������ȣ�� Ȩ�������� �Է��� �ֽø� �������� �Ѿ�ϴ�."; // ���� 
  
            try {
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper messageHelper = new MimeMessageHelper(message,
                        true, "UTF-8");
 
                messageHelper.setFrom(setfrom); // �����»�� �����ϸ� �����۵��� ����
                messageHelper.setTo(tomail); // �޴»�� �̸���
                messageHelper.setSubject(title); // ���������� ������ �����ϴ�
                messageHelper.setText(content); // ���� ����
                
                mailSender.send(message);
            } catch (Exception e) {
                System.out.println(e);
            }
            ModelAndView mv = new ModelAndView();    //ModelAndView�� ���� �������� �����ϰ�, ���� ���� �����Ѵ�.
            mv.setViewName("/member/signupForm");    //�����̸�
            mv.addObject("dice", dice);
            mv.addObject("member", memberEmail);
            System.out.println("mv : "+mv);
            System.out.println("dice : "+dice); 
            response_email.setContentType("text/html; charset=UTF-8");
            PrintWriter out_email = response_email.getWriter();
            out_email.println("<script>alert('�̸����� �߼۵Ǿ����ϴ�. ������ȣ�� �Է����ּ���.');</script>");
            out_email.flush();
            
            return mv;
        }

    
    
    //�̸��Ϸ� ���� ������ȣ�� �Է��ϰ� ���� ��ư�� ������ ���εǴ� �޼ҵ�.
    //���� �Է��� ������ȣ�� ���Ϸ� �Է��� ������ȣ�� �´��� Ȯ���ؼ� ������ ȸ������ �������� �Ѿ��,
    //Ʋ���� �ٽ� ���� �������� ���ƿ��� �޼ҵ�
    @RequestMapping(value = "join_injeung1{dice}", method = RequestMethod.POST)
    public ModelAndView join_injeung1(String email_injeung, @PathVariable String dice, HttpServletResponse response_equals) throws IOException {
        System.out.println("������ : email_injeung : "+email_injeung);       
        System.out.println("������ : dice : "+dice); 
        //�������̵��� �ڷḦ ���ÿ� �ϱ����� ModelAndView�� ����ؼ� �̵��� �������� �ڷḦ ����
         
        ModelAndView mv = new ModelAndView();
        /*mv.setViewName("/member/signupForm");*/
        mv.addObject("member", email_injeung);
        if (email_injeung.equals(dice)) {
            	
            //������ȣ�� ��ġ�� ��� ������ȣ�� �´ٴ� â�� ����ϰ� ȸ������â���� �̵���
            
            
            
            mv.setViewName("/member/signupform");
            mv.addObject("memberEmail", email_injeung);
            
            
            //���� ������ȣ�� ���ٸ� �̸����� ȸ������ �������� ���� �Ѱܼ� �̸�����
            //�ѹ��� �Է��� �ʿ䰡 ���� �Ѵ�.
            
            response_equals.setContentType("text/html; charset=UTF-8");
            PrintWriter out_equals = response_equals.getWriter();
            out_equals.println("<script>alert('������ȣ�� ��ġ�Ͽ����ϴ�. ��й�ȣ ����â���� �̵��մϴ�.');</script>");
            out_equals.flush();
    
            return mv;
            
        }else if (email_injeung != dice) {
            
            
           ModelAndView mv2 = new ModelAndView(); 
          
            mv2.setViewName("/member/loginForm");
            response_equals.setContentType("text/html; charset=UTF-8");
            PrintWriter out_equals = response_equals.getWriter();
            out_equals.println("<script>alert('������ȣ�� ��ġ�����ʽ��ϴ�. ������ȣ�� �ٽ� �Է����ּ���.'); history.go(-1);</script>");
            out_equals.flush();
            

            return mv2;
        }    
    

        return mv;   
    }
    

}   
    

