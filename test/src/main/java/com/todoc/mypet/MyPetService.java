package com.todoc.mypet;

import java.util.List;

public interface MyPetService {
    void insertMyPet(MyPetVO vo);
    void updateMyPet(MyPetVO vo);
    void deleteMyPet(int petIdx);
    MyPetVO getMyPet(int petIdx);
    List<MyPetVO> getMyPetList(int userIdx);
}
