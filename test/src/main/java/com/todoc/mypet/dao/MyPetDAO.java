package com.todoc.mypet.dao;

import java.util.List;

import com.todoc.mypet.MyPetVO;

public interface MyPetDAO {
	void insertMyPet(MyPetVO vo);
	void updateMyPet(MyPetVO vo);
	void deleteMyPet(int petIdx);
	MyPetVO getMyPet(int petIdx);
	List<MyPetVO> getMyPetList(int userIdx);	
}
