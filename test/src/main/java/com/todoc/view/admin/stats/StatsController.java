package com.todoc.view.admin.stats;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.todoc.admin.stats.StatsService;

@Controller
@RequestMapping("/admin")
public class StatsController {
	@Autowired
	private StatsService statsService;
	
	@RequestMapping("/statsPage.do")
	public String statsPage() {
		return "admin/stats";
	}
	
    @RequestMapping(value = "/monthlyRevenue.do", method = RequestMethod.GET)
    public String getMonthlyRevenue(@RequestParam("startDate") String startDate,
                                    @RequestParam("endDate") String endDate,
                                    @RequestParam("type") String type,
                                    Model model) {
        List<Map<String, String>> revenue;
        Map<String, String> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        
        if ("user".equals(type)) {
            revenue = statsService.getUserMonthlyRevenue(params);
        } else {
            revenue = statsService.getHosMonthlyRevenue(params);
        }
        model.addAttribute("revenue", revenue);
        return "admin/monthlyRevenue";
    }
	
    @RequestMapping(value = "/paymentsByAccount.do", method = RequestMethod.GET)
    public String getPaymentsByAccount(@RequestParam("account") String account,
    								   @RequestParam("type") String type,
    								   Model model) {
    	List<?> payments;
    	Map<String, String> params = new HashMap<>();
    	params.put("account", account);
    	
    	if ("user".equals(type)) {
    		payments = statsService.getUserPaymentsByAccount(params);
    	} else {
    		payments = statsService.getHosPaymentsByAccount(params);
    	}
    	model.addAttribute("payments", payments);
    	model.addAttribute("type", type);
    	return "admin/paymentsByAccount";
    }
    
	
	
}
