package com.simpleboard.home;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.simpleboard.api.CoronaApiGet;
import com.simpleboard.api.MovieApiGet;
import com.simpleboard.service.BoardService;
import com.simpleboard.service.MemberService;
import com.simpleboard.vo.BoardVO;
import com.simpleboard.vo.Criteria;
import com.simpleboard.vo.MemberVO;
import com.simpleboard.vo.PageMaker;
import com.simpleboard.vo.ReplyVO;
import com.simpleboard.vo.SearchCriteria;
import com.simpleboard.service.ReplyService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject //현재 인젝트가 설정대로 되지않지만 우선 import로 문제를 넘김 ( component scan의 문제?)
	BoardService service;
	
	@Inject
	ReplyService replyService;
	
	@Inject
	MemberService mbservice;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(Locale locale, Model model) {
				
		return "test";
	}
		
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Locale locale, Model model) {
				
		return "main";
	}
	
	@RequestMapping(value = "/api", method = RequestMethod.GET)
	public String api(Locale locale, Model model, HttpServletRequest req) throws Exception {
		//로그인관련 세션설정
		HttpSession session = req.getSession();
		
		//영화api 데이터 처리 
		MovieApiGet moviedata = new MovieApiGet();		
		List<String> movienamedata = moviedata.movieapiname();
		List<String> movieaudidata = moviedata.movieapiaudi();
 		model.addAttribute("moviename", movienamedata);
 		model.addAttribute("movieaudi", movieaudidata);
 		
 		//코로나 api 데이터 처리
 		CoronaApiGet coronadata = new CoronaApiGet();
 		List<String> coronadeathdata = coronadata.getdeath();
 		List<String> coronadatedata = coronadata.getdate();
 		model.addAttribute("coronadeath", coronadeathdata);
 		model.addAttribute("coronadate", coronadatedata);
		return "api";
	}
	
	//게시판 글작성 화면 
	@RequestMapping(value = "/writeView", method = RequestMethod.GET)
	public String board(HttpServletRequest req,Model model) {
		logger.info("writeView");
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("userid");
	    model.addAttribute("userid", id);
		return "writeView";
	}
	
	//게시판 글작성 쿼리동작
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String boardwrite(BoardVO boardVO, Model model, @ModelAttribute("scri")SearchCriteria scri) throws Exception {
		logger.info("insert");
		// getParameter 형식없이 파라미터를 받지 않아도 파라미터가 vo객체를 통해서 자연스럽게 값이 전해진다고함 (자동으로 처리해줌)
		service.write(boardVO);
		
		model.addAttribute("list", service.list(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		
		return "list";
	}
	
	// 게시판 목록 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, @ModelAttribute("scri")SearchCriteria scri, HttpServletRequest req) throws Exception {
									// 위 설명 scri라는 이름으로 모델객체에 scri를 담아놓음 
		                            // model.addAttribute없이 자동으로 값이 담겨져서 감
		logger.info("list");
		
		HttpSession session = req.getSession();
							
		model.addAttribute("list", service.list(scri)); //리스트라는 명으로 service리스트 값을 넣어서 보냄 
				
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri); //
		pageMaker.setTotalCount(service.listCount(scri));
		
		model.addAttribute("pageMaker", pageMaker); //페이징처리를 위해 페이지메이커를 보냄
		
		return "list";
	}
	
	//게시판 조회
	@RequestMapping(value = "/readView", method = RequestMethod.GET)
	public String read(BoardVO boardVO, Model model, @ModelAttribute("scri") SearchCriteria scri, HttpServletRequest req) throws Exception{
		logger.info("read");
		
		HttpSession session = req.getSession();
		model.addAttribute("userid", session.getAttribute("userid"));
		//request.getParameter 형식없이 파라미터가 vo객체를 통해서 자연스럽게 값이 전해진다고함
		// 인위적으로 파라미터를 받아오는 코드는 없지만 자동으로 되어있음 
		model.addAttribute("read", service.read(boardVO.getBno()));
		model.addAttribute("scri", scri);
		
		// replyList 댓글 
		List<ReplyVO> replyList = replyService.readReply(boardVO.getBno());
		model.addAttribute("replyList",replyList);
		return "readView";
		
	}
	
	// 게시판 수정뷰
	@RequestMapping(value = "/updateView", method = RequestMethod.GET)
	public String updateView(BoardVO boardVO, Model model, @ModelAttribute("scri")SearchCriteria scri) throws Exception{
		logger.info("updateView");
			
		model.addAttribute("update", service.read(boardVO.getBno()));
		model.addAttribute("scri", scri);	
		return "updateView";
	}
		
	// 게시판 수정
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(BoardVO boardVO,Model model, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception{
		logger.info("update");
			
		service.update(boardVO);
		//rttr
		/*rttr.addAttribute("page", scri.getPage());  
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		*/
		model.addAttribute("list", service.list(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		return "list";
	}

	// 게시판 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(BoardVO boardVO ,Model model,@ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception{
		logger.info("delete");
			
		service.delete(boardVO.getBno());
		/*rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		*/
		model.addAttribute("list", service.list(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
					
		return "list";
	}
	
	// 댓글 작성
	@RequestMapping(value="/replyWrite", method = RequestMethod.POST)
	public String replyWrite(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception{
		logger.info("reply Write");
		
		// 댓글작성
		replyService.writeReply(vo);
		
		//모델 대신?
		// redirect로 이동할때 사용가능 그외는 model로만 사용
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
						
		return "redirect:/readView";
	}
	
	//댓글 수정 GET
	@RequestMapping(value="/replyUpdateView", method = RequestMethod.GET)
	public String replyUpdateView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception {
		logger.info("reply Write");
			
		model.addAttribute("replyUpdate", replyService.selectReply(vo.getRno()));
		model.addAttribute("scri", scri);
			
		return "replyUpdateView";
	}
		
	//댓글 수정 POST
	@RequestMapping(value="/replyUpdate", method = RequestMethod.POST)
	public String replyUpdate(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		logger.info("reply Write");
			
		replyService.updateReply(vo);
			
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
			
		return "redirect:/readView";
	}
	
	//댓글 삭제 GET
	@RequestMapping(value="/replyDeleteView", method = RequestMethod.GET)
	public String replyDeleteView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception {
		logger.info("reply Write");
			
		model.addAttribute("replyDelete", replyService.selectReply(vo.getRno()));
		model.addAttribute("scri", scri);
			

		return "replyDeleteView";
	}
		
	//댓글 삭제
	@RequestMapping(value="/replyDelete", method = RequestMethod.POST)
	public String replyDelete(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		logger.info("reply Write");
			
		replyService.deleteReply(vo);
			
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
			
		return "redirect:/readView";
	}
	
	
	// 회원가입 get
	@RequestMapping(value="/register", method = RequestMethod.GET)
	public String getregister() throws Exception{
		logger.info("member register get");
		return "register";
	}
	
	// 회원가입 post
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String postregister(MemberVO vo) throws Exception{
		logger.info("member register post");
		int result = mbservice.idChk(vo);
		try {
			if(result == 1) {
				return "register";
			}else if(result == 0) {
				mbservice.register(vo);
			}
			
		}catch(Exception e) {
			throw new RuntimeException();
		}
		
	
		return "/main";
	}
	
	//로그인페이지이동
	@RequestMapping(value="/login" , method = RequestMethod.GET)
	public String loginpage() throws Exception{
		return "login";
	}
	
	//로그인기능 
	@RequestMapping(value="/login" , method = RequestMethod.POST)
	public String login(MemberVO vo, HttpServletRequest req, Model model) throws Exception{
		logger.info("post login");
		
		HttpSession session = req.getSession();
		MemberVO login = mbservice.login(vo);
		
		if(login == null) {
			session.setAttribute("member", null);
			model.addAttribute("msg", false);
			return "login";
		}else {
			session.setAttribute("userid", vo.getUserId());
			session.setAttribute("member", login);
		}
		return "main";
	}
	
	//로그아웃 
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		logger.info("logout");
		session.invalidate();
		return "main";
	}
	
	//회원정보수정페이지
	@RequestMapping(value="/memberUpdateView", method = RequestMethod.GET)
	public String registerUpdateView() throws Exception{
		logger.info("memberUpdateView");
		return "memberUpdateView";
	}
	
	//회원정보업데이트 기능
	@RequestMapping(value="/memberUpdate", method = RequestMethod.POST)
	public String registerUpdate(MemberVO vo, HttpSession session) throws Exception{
		logger.info("memberUpdate");
		mbservice.memberUpdate(vo);
		session.invalidate();
		return "login";
	}
	
	//회원탈퇴페이지
	@RequestMapping(value="/memberDeleteView", method = RequestMethod.GET)
	public String memberDeleteView() throws Exception{
		logger.info("memberDeleteView");
		return "memberDeleteView";
	}
	
	//회원탈퇴post
	@RequestMapping(value="/memberDelete", method = RequestMethod.POST)
	public String memberDelete(MemberVO vo, HttpSession session, Model model) throws Exception{
		logger.info("memberDelete");
		MemberVO member = (MemberVO)session.getAttribute("member");
		String sessionPass = member.getUserPass();
		String voPass = vo.getUserPass();
	
		if(!(sessionPass.equals(voPass))) {
			model.addAttribute("msg",false);
			return "memberDeleteView";
		}
		
		mbservice.memberDelete(vo);
		session.invalidate();
		logger.info("memberDelete session 제거? ");
		return "main";
	}
	
	// 패스워드 체크 (ajax 구현란)
	@ResponseBody 
	@RequestMapping(value="/passChk", method = RequestMethod.POST)
	public int passChk(MemberVO vo) throws Exception{
		logger.info("passChk");
		int result = mbservice.passChk(vo);
		return result;
	}
	
	// 아이디 중복체크 (ajax 구현란)
	@ResponseBody
	@RequestMapping(value="/idChk", method = RequestMethod.POST)
	public int idChk(MemberVO vo) throws Exception{
		int result = mbservice.idChk(vo);
		return result;
	}
	
	
}
