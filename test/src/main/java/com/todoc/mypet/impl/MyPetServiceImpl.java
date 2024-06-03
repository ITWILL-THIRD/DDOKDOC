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

    @Override
    public void insertMyPet(MyPetVO vo) {
        myPetDAO.insertMyPet(vo);
    }

    @Override
    public void updateMyPet(MyPetVO vo) {
        myPetDAO.updateMyPet(vo);
    }

    @Override
    public void deleteMyPet(int petIdx) {
        myPetDAO.deleteMyPet(petIdx);
    }

    @Override
    public MyPetVO getMyPet(int petIdx) {
        return myPetDAO.getMyPet(petIdx);
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
