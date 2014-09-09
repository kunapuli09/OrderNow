package com.temesoft.security;

import java.io.InputStream;
import java.util.Properties;
import java.util.ResourceBundle;

/**
 * <a
 * href="http://skewpassim.sourceforge.net/">http://skewpassim.sourceforge.net
 * /</a> <br>
 * <b>Configuration file, reads the
 * /com/temesoft/security/skewpassimage.properties for configuration values</b>
 */
public class Config {

	static public final String MAX_NUMBER = "skewpassimage.passimage.max_number";
	static public final String LTR_WIDTH = "skewpassimage.passimage.letter_width";
	static public final String IMAGE_HEIGHT = "skewpassimage.passimage.height";
	static public final String PASS_CODE = "skewpassimage.encoding.passcode";
	static public final String ALGORITHM = "skewpassimage.encoding.algorithm";
	static public final String SKEW = "skewpassimage.passimage.skew";
	static public final String DRAW_LINES = "skewpassimage.passimage.draw_lines";
	static public final String DRAW_BOXES = "skewpassimage.passimage.draw_boxes";
	static public final String SKEW_PROCESSOR_CLASS = "skewpassimage.passimage.processor_class";

	static public final String CONFIG_FILE_CLASSPATH = "skewpassimage";

	static public final ResourceBundle myResources = ResourceBundle
			.getBundle(CONFIG_FILE_CLASSPATH);

	static boolean isDebugOn = true;

	public static String getProperty(String propName) {
		return myResources.getString(propName);
	}

	public static int getPropertyInt(String propName) {
		return new Long(myResources.getString(propName)).intValue();
	}

	public static long getPropertyLong(String propName) {
		return new Long(myResources.getString(propName)).longValue();
	}

	public static double getPropertyDouble(String propName) {
		return new Double(myResources.getString(propName)).doubleValue();
	}

	public static boolean getPropertyBoolean(String propName) {
		return new Boolean(myResources.getString(propName)).booleanValue();
	}

}
