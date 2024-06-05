package com.todoc.googlecloudstorage;

import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;

@Service("gcsService")
public class GCSService {
	
    @Autowired
    private Storage storage;
	
    @Value("${gcp.bucket.name}") // 버킷 이름 값 주입
    private String bucketName;
	
    // 파일 업로드
    public String uploadFile(MultipartFile file) throws IOException {
        String fileName = UUID.randomUUID().toString() + "-" + file.getOriginalFilename(); // 파일 이름 생성
        BlobInfo blobInfo = BlobInfo.newBuilder(bucketName, fileName) // 버킷이름, 파일이름 설정
                .setContentType(file.getContentType()) // 콘텐츠 타입 설정
                .build();
        storage.create(blobInfo, file.getBytes()); // GCS에 파일업로드
        return String.format("https://storage.googleapis.com/%s/%s", bucketName, fileName); // 업로드된 파일 URL 반환
	}
    
    // 파일 삭제
    public void deleteFile(String url) {
    	String fileName = url.substring(url.lastIndexOf("/") + 1); // 파일 이름의 마지막 '/' 위치를 찾고 그 이후의 모든 문자열 추출
    	BlobId blobId = BlobId.of(bucketName, fileName);
    	storage.delete(blobId); // GCS에서 파일 삭제
    }
}
