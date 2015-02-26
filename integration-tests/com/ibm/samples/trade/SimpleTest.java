package com.ibm.samples.trade;

import static org.junit.Assert.*;

import org.junit.Test;

public class SimpleTest {
    
	@Test
	public void testTargetURL() {
//		fail("Not yet implemented");
		String url = System.getProperty("TARGET_URL");
		System.out.println("TARGET URL = " + url);
		assertNotNull("The TARGET_URL has not been set", url);
		//assertTrue("this better be true", true);
	}
    
}
