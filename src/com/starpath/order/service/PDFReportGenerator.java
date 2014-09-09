package com.starpath.order.service;

import java.io.FileOutputStream;

import com.lowagie.text.Element;
import com.lowagie.text.Image;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;

public class PDFReportGenerator {
	/**
     * Reads the pages of an existing PDF file, adds pagenumbers and a watermark.
     * @param args no arguments needed
     */
    public static void main(String[] args) {
        try {
        	PdfReader reader = new PdfReader(args[0]);
        	PdfContentByte under;
            PdfContentByte over;
            Image img = Image.getInstance(args[2]);
            BaseFont bf = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED);
            img.setAbsolutePosition(320, 10);
            int n = reader.getNumberOfPages();
        	byte[] streamBytes = reader.getPageContent(1);
        	StringBuffer buf = new StringBuffer();          
        	String contentStream = new String(streamBytes);
        	String searchString = "Google Analytics"; 
        	int pos = contentStream.indexOf(searchString);
        	buf.append(contentStream.substring(0, pos));
        	buf.append("Krishna");
        	buf.append(contentStream.substring(pos + searchString.length() + 1 ));
        	String modifiedString = buf.toString();  
        	PdfStamper stamper = new PdfStamper(reader, new 
        	FileOutputStream(args[1]));
        	reader.setPageContent(1, modifiedString.getBytes());
        	for(int i=2; i<=n;i++){
        		try {
					byte[] streamBytes1 = reader.getPageContent(i);
					if(streamBytes1 == null){
						break;
					}
					StringBuffer buf1 = new StringBuffer(); 
					String contentStream1 = new String(streamBytes1);
					int pos1 = contentStream1.indexOf(searchString);
					buf1.append(contentStream1.substring(0, pos1));
					buf1.append("Krishna");
					buf1.append(contentStream.substring(pos + searchString.length() + 1 ));
					String modifiedString1 = buf1.toString();  
					reader.setPageContent(i, modifiedString1.getBytes());
					under = stamper.getUnderContent(i);
	            	under.addImage(img);
	            	// text over the existing page
	            	over = stamper.getOverContent(i);
	            	over.beginText();
	            	over.setFontAndSize(bf, 18);
	            	over.setTextMatrix(30, 30);
	            	over.showText("page " + i);
	            	over.setFontAndSize(bf, 16);
	            	over.showTextAligned(Element.ALIGN_LEFT, "Web Presence LLC Copyright 2009", 230, 430, 45);
	            	over.endText();
	        		
				} catch (Exception e) {
					e.printStackTrace();
					break;
				}
            	
        	}
        	// closing PdfStamper will generate the new PDF file
        	stamper.close();
        }
        catch (Exception de) {
            de.printStackTrace();
        }
        System.out.println("Successfully Generated Custom Report");
        
    }

}
