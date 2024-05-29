package com.todoc.mypet;

import java.util.List;

public interface MyPetService {
	void insertMyPet(MyPetVO vo);
	void updateMyPet(MyPetVO vo);
	void deleteMyPet(MyPetVO vo);
	MyPetVO getMyPet(MyPetVO vo);
	List<MyPetVO> getMyPetList(MyPetVO vo);
	
}
