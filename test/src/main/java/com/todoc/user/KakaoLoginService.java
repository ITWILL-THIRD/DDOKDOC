package com.todoc.user;

public interface KakaoLoginService {
	String getAccessToken(String authorize_code) throws Throwable;
}
