package com.todoc.view.membership;

//import jakarta.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.membership.HosMembershipService;
import com.todoc.membership.HosMembershipVO;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;


@RequestMapping("/membership")
@Controller
public class PayController {
	@Autowired
	HospitalService hospitalService;
	private HosMembershipService hosmembershipService;
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	public PayController(HosMembershipService hosmembershipService) {
		System.out.println("=========> PayController(hosmembershipService) 객체생성");
		System.out.println(":: HosMembershipService hosmembershipService : " + hosmembershipService);
		this.hosmembershipService = hosmembershipService;
	}

    @RequestMapping(value = "/confirm.do")
    public ResponseEntity<JSONObject> confirmPayment(@RequestBody String jsonBody, HttpSession session) throws Exception {

        JSONParser parser = new JSONParser();
        String orderId;
        String amount;
        String paymentKey;
        
        try {
            // 클라이언트에서 받은 JSON 요청 바디입니다.
            JSONObject requestData = (JSONObject) parser.parse(jsonBody);
            paymentKey = (String) requestData.get("paymentKey");
            orderId = (String) requestData.get("orderId");
            amount = (String) requestData.get("amount");
        } catch (ParseException e) {
            throw new RuntimeException(e);
        };
        JSONObject obj = new JSONObject();
        obj.put("orderId", orderId);
        obj.put("amount", amount);
        obj.put("paymentKey", paymentKey);

        // TODO: 개발자센터에 로그인해서 내 결제위젯 연동 키 > 시크릿 키를 입력하세요. 시크릿 키는 외부에 공개되면 안돼요.
        // @docs https://docs.tosspayments.com/reference/using-api/api-keys
        String widgetSecretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";

        // 토스페이먼츠 API는 시크릿 키를 사용자 ID로 사용하고, 비밀번호는 사용하지 않습니다.
        // 비밀번호가 없다는 것을 알리기 위해 시크릿 키 뒤에 콜론을 추가합니다.
        // @docs https://docs.tosspayments.com/reference/using-api/authorization#%EC%9D%B8%EC%A6%9D
        Base64.Encoder encoder = Base64.getEncoder();
        byte[] encodedBytes = encoder.encode((widgetSecretKey + ":").getBytes(StandardCharsets.UTF_8));
        String authorizations = "Basic " + new String(encodedBytes);

        // 결제 승인 API를 호출하세요.
        // 결제를 승인하면 결제수단에서 금액이 차감돼요.
        // @docs https://docs.tosspayments.com/guides/payment-widget/integration#3-결제-승인하기
        URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestProperty("Authorization", authorizations);
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);


        OutputStream outputStream = connection.getOutputStream();
        outputStream.write(obj.toString().getBytes("UTF-8"));

        int code = connection.getResponseCode();
        boolean isSuccess = code == 200;

        InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();
        
        
        // TODO: 결제 성공 및 실패 비즈니스 로직을 구현하세요.
        if (isSuccess) {
            HosMembershipVO vo = new HosMembershipVO();

            vo.setPaymentKey(paymentKey);
            vo.setOrderId(orderId);
            vo.setAmount(Integer.parseInt(amount));
            hosmembershipService.insertHosMembership(vo);
        }

        Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
        JSONObject jsonObject = (JSONObject) parser.parse(reader);
        responseStream.close();

        return ResponseEntity.status(code).body(jsonObject);
    }

    /**
     * 인증성공처리
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/success.do", method = RequestMethod.GET)
    public String paymentRequest(HttpServletRequest request, HttpSession session, Model model, HosMembershipVO vo) throws Exception {
		HospitalVO hvo= (HospitalVO) session.getAttribute("hoUser");
		model.addAttribute("hoUser", hvo);
    	vo.setHosIdx(hvo.getHosIdx());
       	hosmembershipService.insertHosMembership(vo); 
       	
        hvo.setCondition("결제완료");
    	hosmembershipService.updateHosCondition(hvo); 
    	
    	session.setAttribute("hoUser", hvo);
        return "membership/success";
    }

    @RequestMapping(value = "/checkout.do", method = RequestMethod.GET)
    public String index(HttpServletRequest request, HttpSession session, Model model) throws Exception {
    	HospitalVO hvo = (HospitalVO) session.getAttribute("hoUser");
    	hvo = hospitalService.selectOne(hvo.getHosIdx());
    	System.out.println("hvo.getCondition() : " + hvo.getCondition());
    	session.setAttribute("hoUser", hvo);
    	
        boolean isApproved = hvo != null && "승인완료".equals(hvo.getCondition());
        model.addAttribute("isApproved", isApproved);
        boolean notApproved = hvo != null && "승인전".equals(hvo.getCondition());
        model.addAttribute("notApproved", notApproved);
        boolean isMember = hvo != null && "결제완료".equals(hvo.getCondition());
        model.addAttribute("isMember", isMember);
        
        return "membership/checkout";
    }

    /**
     * 인증실패처리
     * @param request
     * @param model
     * @return 
     * @throws Exception
     */
    @RequestMapping(value = "/fail.do", method = RequestMethod.GET)
    public String failPayment(HttpServletRequest request, HttpSession session, Model model) throws Exception {
        String failCode = request.getParameter("code");
        String failMessage = request.getParameter("message");

        model.addAttribute("code", failCode);
        model.addAttribute("message", failMessage);

        return "membership/fail";
    }
    
    
}
