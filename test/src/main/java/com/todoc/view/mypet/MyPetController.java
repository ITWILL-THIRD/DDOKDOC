package com.todoc.view.mypet;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.todoc.googlecloudstorage.GCSService;
import com.todoc.mypet.MyPetService;
import com.todoc.mypet.MyPetVO;
import com.todoc.user.UserVO;

@RequestMapping("/mypage")
@Controller
public class MyPetController {
	
    @Autowired
    @Qualifier("myPetService")
    private MyPetService myPetService;
	
    @Autowired
    @Qualifier("gcsService")
    private GCSService gcsService;
	
	@RequestMapping("/insertMyPetView.do")
	public String insertMyPetView() {
		return "mypage/insertMyPet";
	}
	
    @RequestMapping("/insertMyPet.do")
	public String insertMyPet(@RequestParam("file") MultipartFile file, MyPetVO vo, Model model, HttpSession session) {
        try {
        	if (!file.isEmpty()) {
        		String petImg = gcsService.uploadFile(file); // 파일 업로드
        		vo.setPetImg(petImg);
        	} else {
        		vo.setPetImg(null);
        	}
            UserVO user = (UserVO) session.getAttribute("user");
            vo.setUserIdx(user.getUserIdx());
            myPetService.insertMyPet(vo);
            return "redirect:myPage.do";
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "파일 업로드 중 오류가 발생했습니다");
            return "redirect:mypage/insertMyPetView.do";
        }
	}

	@GetMapping("/updateMyPetView.do")
	public String updateMyPetView(@RequestParam("petIdx") int petIdx, Model model) {
		MyPetVO pet = myPetService.getMyPet(petIdx);
		System.out.println("pet: " + pet);
		model.addAttribute("pet", pet);
	    return "mypage/updateMyPet";
	}

	@PostMapping("/updateMyPet.do")
	public String updateMyPet(@RequestParam("file") MultipartFile file, MyPetVO vo, Model model) {
		try {
			MyPetVO currentImg = myPetService.getMyPet(vo.getPetIdx());
			vo.setAnimal(currentImg.getAnimal());
			if (!file.isEmpty()) { // 파일이 있으면 업로드 처리
				String petImg = gcsService.uploadFile(file);
				vo.setPetImg(petImg);
				if (currentImg != null && currentImg.getPetImg() != null) { // 기존 파일 GCS에서 삭제
					gcsService.deleteFile(currentImg.getPetImg());
				}
			} else { // 새 파일이 없으면 기존 파일 유지
				if (currentImg != null && currentImg.getPetImg() != null) {
					vo.setPetImg(currentImg.getPetImg());
				} else {
					vo.setPetImg(null);
				}
			}
			System.out.println("updating : " + vo); // 값 설정 확인
			myPetService.updateMyPet(vo);
	        return "redirect:myPage.do";
		} catch (IOException e) {
			e.printStackTrace();
	        model.addAttribute("errorMessage", "파일 업로드 중 오류가 발생했습니다");
	        return "redirect:mypage/updateMyPetView.do?petIdx=" + vo.getPetIdx();
		}
	}
	
	@PostMapping("/deleteMyPet.do")
	public String deleteMyPet(@RequestParam("petIdx") int petIdx, Model model) {
		MyPetVO pet = myPetService.getMyPet(petIdx);
		if (pet != null && pet.getPetImg() != null) {
			gcsService.deleteFile(pet.getPetImg()); // GCS에서 파일 삭제
		}
	    myPetService.deleteMyPet(petIdx);
	    return "redirect:myPage.do"; 
	}
	
}
