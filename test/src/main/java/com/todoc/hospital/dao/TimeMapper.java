package com.todoc.hospital.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import com.todoc.hospital.HospitalVO;

public interface TimeMapper {
	 @Insert("INSERT INTO HOSTIME (HOSIDX, OPENTIME, CLOSETIME, LUNCHTIME, ENDLUNCHTIME, SATOPENTIME, SATCLOSETIME, SATLUNCHTIME, SATENDLUNCHTIME"
			+ ", SUNOPENTIME, SUNCLOSETIME, SUNLUNCHTIME, SUNENDLUNCHTIME, LUNCHOFF, SATLUNCHOFF, SUNDAYOFF, SUNLUNCHOFF)"
			+ "VALUES((SELECT MAX(NVL(HOSIDX, 0)) + 1 FROM HOSTIME), TO_DATE(SYSDATE || ' ' || #{openTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), TO_DATE(SYSDATE || ' ' || #{closeTimeStr}, 'YYYY-MM-DD HH24:MI:SS')"
			+ ", TO_DATE(SYSDATE || ' ' || #{lunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), TO_DATE(SYSDATE || ' ' || #{endLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS')"
			+ ", TO_DATE(SYSDATE || ' ' || #{satOpenTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), TO_DATE(SYSDATE || ' ' || #{satCloseTimeStr}, 'YYYY-MM-DD HH24:MI:SS')"
			+ ", TO_DATE(SYSDATE || ' ' || #{satLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), TO_DATE(SYSDATE || ' ' || #{satEndLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS')"
			+ ", TO_DATE(SYSDATE || ' ' || #{sunOpenTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), TO_DATE(SYSDATE || ' ' || #{sunCloseTimeStr}, 'YYYY-MM-DD HH24:MI:SS')"
			+ ", TO_DATE(SYSDATE || ' ' || #{sunLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), TO_DATE(SYSDATE || ' ' || #{sunEndLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS')"
			+ ", COALESCE(#{lunchOff}, 'N'), COALESCE(#{satLunchOff}, 'N'), COALESCE(#{sunDayOff}, 'N'), COALESCE(#{sunLunchOff}, 'N'))")
	 int insertTime(int hosIdx
			 , @Param("openTimeStr")String openTimeStr, @Param("closeTimeStr")String closeTimeStr
			 , @Param("lunchTimeStr")String lunchTimeStr, @Param("endLunchTimeStr")String endLunchTimeStr
			 , @Param("satOpenTimeStr")String satOpenTimeStr, @Param("satCloseTimeStr")String satCloseTimeStr
			 , @Param("satLunchTimeStr")String satLunchTimeStr, @Param("satEndLunchTimeStr")String satEndLunchTimeStr
			 , @Param("sunOpenTimeStr")String sunOpenTimeStr, @Param("sunCloseTimeStr")String sunCloseTimeStr
			 , @Param("sunLunchTimeStr")String sunLunchTimeStr, @Param("sunEndLunchTimeStr")String sunEndLunchTimeStr
			 , @Param("lunchOff")String lunchOff, @Param("satLunchOff")String satLunchOff
			 , @Param("sunDayOff")String sunDayOff, @Param("sunLunchOff")String sunLunchOff
	);

	
	 @Update("UPDATE HOSTIME " +
		        "SET OPENTIME = TO_DATE(SYSDATE || ' ' || #{openTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
		        "CLOSETIME = TO_DATE(SYSDATE || ' ' || #{closeTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
		        "LUNCHTIME = TO_DATE(SYSDATE || ' ' || #{lunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
		        "ENDLUNCHTIME = TO_DATE(SYSDATE || ' ' || #{endLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
		        "SATOPENTIME = TO_DATE(SYSDATE || ' ' || #{satOpenTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
		        "SATCLOSETIME = TO_DATE(SYSDATE || ' ' || #{satCloseTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
		        "SATLUNCHTIME = TO_DATE(SYSDATE || ' ' || #{satLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
		        "SATENDLUNCHTIME = TO_DATE(SYSDATE || ' ' || #{satEndLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
		        "SUNOPENTIME = TO_DATE(SYSDATE || ' ' || #{sunOpenTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
		        "SUNCLOSETIME = TO_DATE(SYSDATE || ' ' || #{sunCloseTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
		        "SUNLUNCHTIME = TO_DATE(SYSDATE || ' ' || #{sunLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
		        "SUNENDLUNCHTIME = TO_DATE(SYSDATE || ' ' || #{sunEndLunchTimeStr}, 'YYYY-MM-DD HH24:MI:SS'), " +
		        "LUNCHOFF = COALESCE(#{lunchOff}, 'N'), " +
		        "SATLUNCHOFF = COALESCE(#{satLunchOff}, 'N'), " +
		        "SUNDAYOFF = COALESCE(#{sunDayOff}, 'N'), " +
		        "SUNLUNCHOFF = COALESCE(#{sunLunchOff}, 'N') " +
		        "WHERE HOSIDX = #{hosIdx}")
		void updateHosTime(HospitalVO vo, @Param("hosIdx") int hosIdx,
		                   @Param("openTimeStr") String openTimeStr, @Param("closeTimeStr") String closeTimeStr,
		                   @Param("lunchTimeStr") String lunchTimeStr, @Param("endLunchTimeStr") String endLunchTimeStr,
		                   @Param("satOpenTimeStr") String satOpenTimeStr, @Param("satCloseTimeStr") String satCloseTimeStr,
		                   @Param("satLunchTimeStr") String satLunchTimeStr, @Param("satEndLunchTimeStr") String satEndLunchTimeStr,
		                   @Param("sunOpenTimeStr") String sunOpenTimeStr, @Param("sunCloseTimeStr") String sunCloseTimeStr,
		                   @Param("sunLunchTimeStr") String sunLunchTimeStr, @Param("sunEndLunchTimeStr") String sunEndLunchTimeStr,
		                   @Param("lunchOff") String lunchOff, @Param("satLunchOff") String satLunchOff,
		                   @Param("sunDayOff") String sunDayOff, @Param("sunLunchOff") String sunLunchOff);
}
