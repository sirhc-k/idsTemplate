package com.ibm.samples.trade;

import static com.eclipsesource.restfuse.Assert.assertOk;

import org.junit.Rule;
import org.junit.runner.RunWith;

import com.eclipsesource.restfuse.Destination;
import com.eclipsesource.restfuse.HttpJUnitRunner;
import com.eclipsesource.restfuse.Method;
import com.eclipsesource.restfuse.Response;
import com.eclipsesource.restfuse.annotation.Context;
import com.eclipsesource.restfuse.annotation.HttpTest;

@RunWith(HttpJUnitRunner.class)
public class RestAPITest {

	private String url = System.getProperty("TARGET_URL");

	@Rule
	public Destination destination = new Destination(this, url);

	@Context
	private Response response;
	
	@HttpTest(method = Method.GET, path = "/", order = 1)
	public void checkOnlineStatus() {
		System.out.println("Ensuring we get a response from newly deployed instance at: " + url);
		assertOk(response);
	}

	@HttpTest(method = Method.POST, path = "/app",content = "uid:uid:0, passwd:xxx, action:login", order = 2)
	public void checkLogin() {
		System.out.println("Attempt to login");
		assertOk(response);
	}
	
	@HttpTest(method = Method.GET, path = "/app?action=account", order = 3)
	public void checkAccount() {
		System.out.println("Ensuring we get a response from the account page");
		assertOk(response);
	}
	
	@HttpTest(method = Method.GET, path = "/app?action=portfolio", order = 4)
	public void checkPortfolio() {
		System.out.println("Ensuring we get a response from the portfolio page");
		assertOk(response);
	}
	
	@HttpTest(method = Method.GET, path = "/app?quotes&symbols=s:0,s:1,s:2,s:3,s:4", order = 5)
	public void checkQuotes() {
		System.out.println("Ensuring we get a response from the quotes page");
		assertOk(response);
	}
	
	@HttpTest(method = Method.GET, path = "/app?action=logout", order = 6)
	public void checkLogout() {
		System.out.println("Ensuring we can logout");
		assertOk(response);
	}
}
