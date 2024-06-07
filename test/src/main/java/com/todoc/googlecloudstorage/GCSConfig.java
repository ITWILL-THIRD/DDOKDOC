	package com.todoc.googlecloudstorage;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;

@Configuration
public class GCSConfig {
	
    @Value("${gcp.credentials.file}") // 파일 값 주입
	private Resource gcsCredentials;
	
	@Bean
	public Storage storage() throws IOException {
		return StorageOptions.newBuilder()
				.setCredentials(GoogleCredentials.fromStream(gcsCredentials.getInputStream())) // 설정된 파일을 통한 인증 설정
	            .build()
	            .getService();
	}
	
	@Bean
	public MultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setMaxUploadSize(10000000); // 최대 파일 크기
		return multipartResolver;
	}
	
	
}
