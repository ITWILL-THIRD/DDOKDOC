package com.todoc.hospital.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import com.todoc.hospital.HospitalVO;

public interface TimeMapper {
	@Insert("INSERT INTO HOSTIME (HOSIDX, OPENTIME, CLOSETIME, LUNCHTIME, ENDLUNCHTIME, SATOPENTIME, SATCLOSETIME, SATLUNCHTIME, SATENDLUNCHTIME, SUNOPENTIME, SUNCLOSETIME, SUNLUNCHTIME, SUNENDLUNCHTIME)"
		+ "VALUES((SELECT MAX(NVL(HOSIDX, 0)) + 1 FROM HOSTIME), TO_DATE('1970-01-01 ' || #{openTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1970-01-01 ' || #{closeTimeStr}, 'YYYY-MM-DD HH24:MI:SS')"
		+ ", TO_DATE('1970-01-01 ' || #{lunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1970-01-01 ' || #{endLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS')"
		+ ", TO_DATE('1970-01-01 ' || #{satOpenTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1970-01-01 ' || #{satCloseTimeStr}, 'YYYY-MM-DD HH24:MI:SS')"
		+ ", TO_DATE('1970-01-01 ' || #{satLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1970-01-01 ' || #{satEndLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS')"
		+ ", TO_DATE('1970-01-01 ' || #{sunOpenTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1970-01-01 ' || #{sunCloseTimeStr}, 'YYYY-MM-DD HH24:MI:SS')"
		+ ", TO_DATE('1970-01-01 ' || #{sunLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('1970-01-01 ' || #{sunEndLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS')"
		+ ")")
	void insertTime(HospitalVO vo
		, @Param("openTimeStr")String openTimeStr, @Param("closeTimeStr")String closeTimeStr
		, @Param("lunchTimeStr")String lunchTimeStr, @Param("endLunchTimeStr")String endLunchTimeStr
		, @Param("satOpenTimeStr")String satOpenTimeStr, @Param("satCloseTimeStr")String satCloseTimeStr
		, @Param("satLunchTimeStr")String satLunchTimeStr, @Param("satEndLunchTimeStr")String satEndLunchTimeStr
		, @Param("sunOpenTimeStr")String sunOpenTimeStr, @Param("sunCloseTimeStr")String sunCloseTimeStr
		, @Param("sunLunchTimeStr")String sunLunchTimeStr, @Param("sunEndLunchTimeStr")String sunEndLunchTimeStr
	);
	
	 @Update("UPDATE HOSTIME " +
	            "SET OPENTIME = TO_DATE('1970-01-01 ' || #{openTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
	            "CLOSETIME = TO_DATE('1970-01-01 ' || #{closeTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
	            "LUNCHTIME = TO_DATE('1970-01-01 ' || #{lunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
	            "ENDLUNCHTIME = TO_DATE('1970-01-01 ' || #{endLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
	            "SATOPENTIME = TO_DATE('1970-01-01 ' || #{satOpenTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
	            "SATCLOSETIME = TO_DATE('1970-01-01 ' || #{satCloseTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
	            "SATLUNCHTIME = TO_DATE('1970-01-01 ' || #{satLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
	            "SATENDLUNCHTIME = TO_DATE('1970-01-01 ' || #{satEndLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
	            "SUNOPENTIME = TO_DATE('1970-01-01 ' || #{sunOpenTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
	            "SUNCLOSETIME = TO_DATE('1970-01-01 ' || #{sunCloseTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
	            "SUNLUNCHTIME = TO_DATE('1970-01-01 ' || #{sunLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
	            "SUNENDLUNCHTIME = TO_DATE('1970-01-01 ' || #{sunEndLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS') " +
	            "WHERE HOSIDX = #{hosIdx}")
	    void updateHosTime(HospitalVO vo,  @Param("hosIdx")int hosIdx
	    		, @Param("openTimeStr")String openTimeStr, @Param("closeTimeStr")String closeTimeStr
	    		, @Param("lunchTimeStr")String lunchTimeStr, @Param("endLunchTimeStr")String endLunchTimeStr
	    		, @Param("satOpenTimeStr")String satOpenTimeStr, @Param("satCloseTimeStr")String satCloseTimeStr
	    		, @Param("satLunchTimeStr")String satLunchTimeStr, @Param("satEndLunchTimeStr")String satEndLunchTimeStr
	    		, @Param("sunOpenTimeStr")String sunOpenTimeStr, @Param("sunCloseTimeStr")String sunCloseTimeStr
	    		, @Param("sunLunchTimeStr")String sunLunchTimeStr, @Param("sunEndLunchTimeStr")String sunEndLunchTimeStr
	    		);
}
