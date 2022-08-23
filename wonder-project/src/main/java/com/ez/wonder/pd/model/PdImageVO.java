package com.ez.wonder.pd.model;
import lombok.Data;

@Data
public class PdImageVO {
   private int pdImgNo;
   private int pdNo;
   private String fileName;
   private String originalFileName;
   private long fileSize;
   private String fileType;
}
