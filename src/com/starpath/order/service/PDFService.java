package com.starpath.order.service;

import com.starpath.order.domain.Order;

public interface PDFService {
	public String generatePDF(Order order, String pdfPath) throws PDFGenerationException;

}
