package com.todoc.mypet.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.mypet.MyPetService;
import com.todoc.mypet.MyPetVO;
import com.todoc.mypet.dao.MyPetDAO;

@Service("myPetService")
public class MyPetServiceImpl implements MyPetService {
	@Autowired
	private MyPetDAO myPetDAO;
	
	public MyPetServiceImpl() {
		System.out.println(">> MyPetServiceImpl() 객체 생성");
	}
	
	@Override
	public void insertMyPet(MyPetVO vo) {
		myPetDAO.insertMyPet(vo);
	}

	@Override
	public void updateMyPet(MyPetVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMyPet(MyPetVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MyPetVO getMyPet(MyPetVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MyPetVO> getMyPetList(int userIdx) {
		List<MyPetVO> pets = myPetDAO.getMyPetList(userIdx);
		if (pets == null) {
			pets = new ArrayList<>();
		}
		return pets;
	}

}
