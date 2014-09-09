package com.starpath.order.service;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.ResourceBundle;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.starpath.order.domain.Address;
import com.starpath.order.domain.Customer;
import com.starpath.order.domain.Order;
import com.starpath.order.domain.OrderItem;

public class ITextPDFServiceImpl implements PDFService {
	private static final String EMPTY_STRING = "";
	private static final Log log = LogFactory.getLog(ITextPDFServiceImpl.class);

	
	public String generatePDF(Order order, String pdfPath) throws PDFGenerationException {
		// step 1: creation of a document-object
		DecimalFormat df = new DecimalFormat("0.00");
		Document document = new Document(PageSize.A4, 10, 10, 10, 10);		
		if(order == null){
			log.debug("ITextPDFServiceImpl was not able to retrieve order object reference from session");
			throw new NullPointerException("ITextPDFServiceImpl was not able to load struts properties");
		}
		if(order.getId() == null){
			log.debug("ITextPDFServiceImpl was not able to retrieve order object with  NULL ID");
			throw new NullPointerException("ITextPDFServiceImpl was not able to load struts properties");
		}
		String orderId = String.valueOf(order.getId().longValue());
		String fileName = pdfPath + File.separator + orderId + "_" + "order.pdf";
		System.out.println("PDF Path" + pdfPath);
		System.out.println("Order Id" + orderId);
		System.out.println("File Name"+fileName);
		try {
			PdfWriter writer = PdfWriter.getInstance(document,
					new FileOutputStream(fileName));
			document.open();
			Font font = FontFactory.getFont(FontFactory.HELVETICA, 16,
					Font.BOLD, Color.BLACK);
			Paragraph p = new Paragraph("SALES ORDER", font);
			p.setAlignment(Element.ALIGN_CENTER);
			document.add(p);
			Paragraph e = new Paragraph(EMPTY_STRING, font);
			e.setAlignment(Element.ALIGN_CENTER);
			document.add(e);
			Date date = GregorianCalendar.getInstance().getTime();
			Font f = FontFactory.getFont(FontFactory.HELVETICA, 8);
			PdfPTable outertable = new PdfPTable(1);
			outertable.setTotalWidth(150);
			outertable.getDefaultCell().setBorder(Rectangle.NO_BORDER);
			PdfPTable datetable = new PdfPTable(2);
			datetable.getDefaultCell().setBorder(Rectangle.NO_BORDER);
			float[] dateTableWidths = { 25, 125 };
			datetable.setWidths(dateTableWidths);
			datetable.addCell(new Paragraph("Ordered Date:", f));
			datetable.addCell(new Paragraph(order.getOrderDate(), f));
			datetable.addCell(new Paragraph("Order Number:", f));
			datetable.addCell(new Paragraph(order.getId().toString(), f));
			datetable.addCell(new Paragraph("Order Type:", f));
			datetable.addCell(new Paragraph(order.getShipment().getShipmentType(), f));
			datetable.addCell(new Paragraph("Order " +order.getShipment().getShipmentType(), f));
			datetable.addCell(new Paragraph(order.getOrderTime(), f));
			
			datetable.addCell(new Paragraph("Payment Status:", f));
			//TODO change this once accepting credit cards 
			datetable.addCell(new Paragraph("Accepted to Pay at "+order.getShipment().getShipmentType(), f));

			outertable.addCell(datetable);
			PdfPTable innertable = new PdfPTable(7);
			innertable.getDefaultCell().setBorder(Rectangle.NO_BORDER);
			float[] inner = { 20, 15, 25, 30, 20, 15, 25 };
			innertable.setWidths(inner);
			// title row
			innertable.addCell(new Paragraph("Ordered By", f));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			// empty column in the middle
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("Ordered To", f));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));

			Customer buyer = order.getBuyer();
			Customer seller = order.getSeller();
			// TODO throw exception if Buyer is null

			// name row
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("Name:", f));
			innertable.addCell(new Paragraph(buyer.getFirstName() + " "
					+ buyer.getLastName(), f));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("Store:", f));
			//TODO change this to reflect the restaurant name
			innertable.addCell(new Paragraph("Sai Grocery", f));

			Address address = buyer.getAddress();
			Address sellerAddress = seller.getAddress();
			// TODO throw exception if Address is null

			// address row
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("Address:", f));
			innertable.addCell(new Paragraph(address.getAddress(), f));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("Address:", f));
			innertable.addCell(new Paragraph(sellerAddress.getAddress(), f));
			// city row
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("City:", f));
			innertable.addCell(new Paragraph(address.getCity(), f));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("City:", f));
			innertable.addCell(new Paragraph(sellerAddress.getCity(), f));
			// state row
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("State:", f));
			innertable.addCell(new Paragraph(address.getState(), f));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("State:", f));
			innertable.addCell(new Paragraph(sellerAddress.getState(), f));
			// zipcode row
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("Zip:", f));
			innertable.addCell(new Paragraph(address.getZipCode(), f));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("Zip:", f));
			innertable.addCell(new Paragraph(sellerAddress.getZipCode(), f));
			// phone row
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("Phone:", f));
			innertable.addCell(new Paragraph(buyer.getPhoneNumber(), f));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("Phone:", f));
			innertable.addCell(new Paragraph(seller.getPhoneNumber(), f));

			// email row
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("Email:", f));
			innertable.addCell(new Paragraph(buyer.getEmail(), f));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph("Email:", f));
			innertable
					.addCell(new Paragraph(seller.getEmail(), f));

			// empty row
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			innertable.addCell(new Paragraph(EMPTY_STRING));
			outertable.addCell(innertable);
			PdfPTable detailTable = new PdfPTable(5);
			float[] details = { 25, 60, 20, 20, 25 };
			detailTable.setWidths(details);
			detailTable.addCell(new Paragraph("Item", f));
			detailTable.addCell(new Paragraph("Description", f));
			detailTable.addCell(new Paragraph("Quantity", f));
			detailTable.addCell(new Paragraph("Unit Price", f));
			detailTable.addCell(new Paragraph("Amount", f));
			Set<OrderItem> orderedItems = order.getOrderedItems();
			for (OrderItem orderedItem : orderedItems) {
				detailTable.addCell(new Paragraph(orderedItem.getItem()
						.getName(), f));
				detailTable.addCell(new Paragraph(orderedItem.getItem()
						.getDescription(), f));
				detailTable.addCell(new Paragraph(String.valueOf(orderedItem.getOrderedQuantity().intValue()), f));
				detailTable.addCell(new Paragraph(String.valueOf(orderedItem
						.getItem().getItemPrice().getValue().floatValue()), f));
				String lineTotal = df.format(orderedItem
						.getItem().getItemPrice().getValue().floatValue()
						* orderedItem.getOrderedQuantity().intValue()) ;
				detailTable.addCell(new Paragraph(lineTotal, f));
			}
			detailTable.addCell(new Paragraph(EMPTY_STRING));
			detailTable.addCell(new Paragraph(EMPTY_STRING));
			detailTable.addCell(new Paragraph(EMPTY_STRING));
			detailTable.addCell(new Paragraph("Sub Total", f));
			String a = df.format(order
					.calculateTotal()-order.getTax());			
			detailTable.addCell(new Paragraph(String.valueOf(Float.parseFloat(a)), f));
			detailTable.addCell(new Paragraph(EMPTY_STRING));
			detailTable.addCell(new Paragraph(EMPTY_STRING));
			detailTable.addCell(new Paragraph(EMPTY_STRING));
			detailTable.addCell(new Paragraph("Tax", f));	
			String a1 = df.format(order.getTax());	
			detailTable.addCell(new Paragraph(String.valueOf(Float.parseFloat(a1)), f));
			detailTable.addCell(new Paragraph(EMPTY_STRING));
			detailTable.addCell(new Paragraph(EMPTY_STRING));
			detailTable.addCell(new Paragraph(EMPTY_STRING));
			detailTable.addCell(new Paragraph("Grand Total", f));
			detailTable.addCell(new Paragraph(String.valueOf(order
					.calculateTotal()), f));
			outertable.addCell(detailTable);
			document.add(outertable);
		} catch (DocumentException de) {
			System.err.println(de.getMessage());
		} catch (IOException ioe) {
			System.err.println(ioe.getMessage());
		}

		// step 5: we close the document
		document.close();
		return fileName;
	}

}
