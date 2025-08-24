package com.simpleboard.home;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
import com.simpleboard.api.HeatApiGet;
import com.simpleboard.api.MovieApiGet;
import com.simpleboard.service.BoardService;
import com.simpleboard.service.MemberService;
import com.simpleboard.vo.BoardVO;
import com.simpleboard.vo.MemberVO;
import com.simpleboard.vo.PageMaker;
import com.simpleboard.vo.ReplyVO;
import com.simpleboard.vo.SearchCriteria;
import com.simpleboard.service.ReplyService;

/**
 * Handles requests for the application home page.
 */
	@Controller // <annotation-driven />으로 컨트롤러 찾아줌 
	public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	//로그 찍어주는것 
	
	
	// @Inject를 사용하기 위해서는 maven이나 gradle에 (POM.xml) javax 라이브러리 의존성을 추가해야한다.
	@Inject
	BoardService service; // 원래면 new 해서 객체를 생성하지만 스프링의 의존성 주입에 의해 @Inject로 new 같은거 상관없이 진행하는듯
	//결국 여기서 BoardService를 가져옴 그리고 인터페이스인 경우이니 BoardServiceImpl의 메서드를 가져옴
	@Inject
	ReplyService replyService;
	
	@Inject
	MemberService mbservice;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	// 연습용 div 정렬
	@RequestMapping(value = "/divalign", method = RequestMethod.GET)
	public String divalign(Locale locale, Model model) {
		return "divalign";
	}
		
	// 연습용 드롭다운 
	@RequestMapping(value = "/dropdown", method = RequestMethod.GET)
	public String dropdown(Locale locale, Model model) {
				
		return "dropdown";
	}
	
	// 연습용 클릭드롭다운
	@RequestMapping(value = "/clickdropdown", method = RequestMethod.GET)
	public String clickdropdown(Locale locale, Model model) {
				
		return "clickdropdown";
	}
	
	
	// 연습용 페이징처리 게시판
	@RequestMapping(value = "/testlist", method = RequestMethod.GET)
	public String testpagging(Model model) {
		
		// 원래였으면 아래처럼 주는게 아니라 쿼리문에서 전체글 수를 가져와서 시작하는거임
		// 
		
		ArrayList<String> array = new ArrayList<String>();
		array.add("테스트1");
		array.add("테스트2");
		array.add("테스트3");
		array.add("테스트4");
		model.addAttribute("list", array);
		
		return "testlist";
	}
	
		
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(Locale locale, Model model) {
				
		return "test";
	}
		
	// home임 
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
	public String main( Model model) {
				
		return "main";
	}
	
	@RequestMapping(value = "/api", method = RequestMethod.GET)
	public String api(Locale locale, Model model, HttpServletRequest req) throws Exception {
		//로그인관련 세션설정
		HttpSession session = req.getSession(); //세션을 만들어낸다라고 보는게 좋다  = 표현이 보여도 꼭 값을 대입하다라고 하면 이상
		
		//영화api 데이터 처리 
		MovieApiGet moviedata = new MovieApiGet();		
		List<String> movienamedata = moviedata.movieapiname();
		List<String> movieaudidata = moviedata.movieapiaudi();
 		model.addAttribute("moviename", movienamedata);
 		model.addAttribute("movieaudi", movieaudidata);
 		
 		//코로나 api 데이터 처리 (현재 작동 안됨)
 		/*CoronaApiGet coronadata = new CoronaApiGet();
 		List<String> coronadeathdata = coronadata.getdeath();
 		List<String> coronadatedata = coronadata.getdate();
 		model.addAttribute("coronadeath", coronadeathdata);
 		model.addAttribute("coronadate", coronadatedata);  
		
		*/
 		
 		// 온열질환자 api 데이터 처리
 		HeatApiGet heatdata = new HeatApiGet();
 		
 		List<String> heatcountdata = heatdata.getTot();
 		model.addAttribute("heatcount", heatcountdata);
 		
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
		logger.info("insert"); // 위 설명 "scri"라는 이름으로 scri(파란색글씨)를 담아놓음  SearchCriteria가 Criteria 파일을 상속받고있음
							   // @ModelAttribute란 scri의 명칭으로 model.addAttribute("scri", SearchCriteria scri) 이렇게 된다고 봐야함...; 
		
		
		// getParameter 형식없이 파라미터를 받지 않아도 화면에서 보낸 파라미터값들이 vo객체를 통해서 자연스럽게 값이 전해진다고함 (자동으로 처리해줌)
		// 위의 예시 writeView.jsp 파일에서 Post 방식으로 보내줄 경우 
		// 대게는 writeView.jsp의 form 태그의 name명칭을 이용해서 값을 가져온다
		// -> String param = request.getParameter("파라미터 명칭"); <- 이거 말고 vo객체로 대신한다고함 (신기신기~~)
		// 아래 파란글씨 boardVO에 form태그에서 넘어온 값들이 담겨있음(자동처리) 신기  
		service.write(boardVO);
		// 서비스 인터페이스에서 write 메서드 실행시 daoImpl 관련된 부분에서 메서드 가져옴
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
									// 위 설명 "scri"라는 이름으로 scri(파란색글씨)를 담아놓음  SearchCriteria가 Criteria 파일을 상속받고있음
									// @ModelAttribute란 scri의 명칭으로 model.addAttribute("scri", SearchCriteria scri) 이렇게 된다고 봐야함...; 
									// list.jsp의 내용과 비교하며 확인
		logger.info("list");
		
		HttpSession session = req.getSession();
		// 세션 만들기  로그인관련?
		model.addAttribute("list", service.list(scri)); //list라는 명으로 board service리스트 값을 뷰화면에 보냄  
		// service.list(scri)는 boardservice의 메서드  (내부에 boarddao의 service 값을 리턴함 )
		// 로그찍어보면 대략 느낌이옴 
		
		// 아래의 페이징메이커가 없으면 그냥 리스트전체가 나온다고 봐야함(? 확실한지?)
		
		PageMaker pageMaker = new PageMaker(); //페이징처리가 페이징버튼을 의미함  (이전 1 2 3 다음)
		//페이징 처리객체 생성
		pageMaker.setCri(scri); // 페이지메이커에서 scri로 값을 넣어놓음 
		pageMaker.setTotalCount(service.listCount(scri)); // 전체카운트를 설정해서
		
		model.addAttribute("pageMaker", pageMaker); //페이징처리를 위해 페이지메이커를 보냄
		
		return "list";
	}
	
	//게시판글 조회
	@RequestMapping(value = "/readView", method = RequestMethod.GET)
	public String read(BoardVO boardVO, Model model, @ModelAttribute("scri") SearchCriteria scri, HttpServletRequest req) throws Exception{
		logger.info("read");
		
		HttpSession session = req.getSession();
		model.addAttribute("userid", session.getAttribute("userid"));
		//request.getParameter 라는 형식없이 파라미터가 vo객체를 통해서 자연스럽게 값이 전해진다고함
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
		
		model.addAttribute("list", service.list(scri));
		// list라는 명칭으로 게시판글들 보내줌  
		// service.list(scri) -> service-> dao 통해서 게시판 리스트 가져옴
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.listCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		return "list";
	}

	// 게시글 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(BoardVO boardVO ,Model model,@ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception{
		logger.info("delete");
		replyService.deleteAllReply(boardVO);
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
		
		//모델 model 대신사용하는것도 있음
		
		// redirect 설명
		// 리다이렉트로 다른 페이지에 값을 전달  리다이렉트시에 model값은 사라짐(조심)
		// .addAttribute도 있고 .addFlashAttribute 있다
		// .addAttribute를 쓰면 주소창에 키값 밸류값 형식으로 보내지고   
		// .addFlashAttribute는 post방식처럼 주소창에 보이지 않고 보내진다( 데이터 값 나오더라도 새로고침하면 사라짐) 
		// 받는 뷰페이지에서는 ${키값} 형식으로 꺼내쓸수 있음 
		// ex) ${bno} , {page} 이런식으로 해당값이 있으면 나올것    
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		// 리다이렉트 해줄때 "redirect:/해당페이지 파일명 이렇게하는 듯함  
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
	public String replyUpdate(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr, HttpServletRequest request) throws Exception {
		
		String text = request.getParameter("getcontent");
		int rnumber = Integer.parseInt(request.getParameter("rno"));   
		int bnumber = Integer.parseInt(request.getParameter("bno"));   
		System.out.println("테스트1 "+ text);
		System.out.println("테스트2 "+ rnumber);
		System.out.println("테스트3 "+ bnumber);
		logger.info("reply Write");
		
		vo.setBno(bnumber);
		vo.setContent(text);
		vo.setRno(rnumber);
		
		System.out.println("테스트333 ");
		replyService.updateReply(vo);
			
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		logger.info("reply Write2");	
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
		
	//댓글 삭제 post
	@RequestMapping(value="/replyDelete", method = RequestMethod.POST)
	public String replyDelete(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr ,HttpServletRequest request) throws Exception {
		logger.info("reply Write");
		
		int rnumber = Integer.parseInt(request.getParameter("rno"));
		vo.setRno(rnumber);
		
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
	
	//로그인기능 !!! 이부분 중요 list파일 api파일에서 ${member} 부분으로 보내는듯함 
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
			session.setAttribute("userid", vo.getUserId().toLowerCase());
			session.setAttribute("member", login);
			// 세션을 만들고 userid에 vo.getuserId()값을   member에 login(MemberVo 객체를 담음) list jsp파일에 보내짐 
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
		if (member == null) {
	        return "redirect:/login"; // 로그인 안 된 상태
	    }
		
		String sessionPass = member.getUserPass();
		String voPass = vo.getUserPass();
		
		
		if(!(sessionPass.equals(voPass))) {
			model.addAttribute("msg",false);
			return "memberUpdateView";
		}
		
		mbservice.memberDelete(vo);
		session.invalidate();
		logger.info("memberDelete session 제거 ");
		return "redirect:/main";
	}
	
	// 패스워드 체크 (ajax 구현란)
	@ResponseBody 
	@RequestMapping(value="/passChk", method = RequestMethod.POST)
	public Map<String, Integer> passChk(MemberVO vo) throws Exception{
		logger.info("passChk");
		int result = mbservice.passChk(vo);
		Map<String , Integer> map = new HashMap<>();
		map.put("result", result);
		return map;
		
	}
	
	// 아이디 중복체크 (ajax 구현란)
	@ResponseBody
	@RequestMapping(value="/idChk", method = RequestMethod.POST)
	public int idChk(MemberVO vo) throws Exception{
		int result = mbservice.idChk(vo);
		return result;
	}
			
	
}
