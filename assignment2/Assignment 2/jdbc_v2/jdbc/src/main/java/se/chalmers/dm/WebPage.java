package se.chalmers.dm;

public class WebPage {
	private String url;
	private String author;
	private String content;
	private int pop;
	
	public  WebPage(String url, String author, String content, int pop) {
		this.url = url;
		this.author = author;
		this.content = content;
		this.pop = pop;
	}
	
	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getPop() {
		return pop;
	}

	public void setPop(int pop) {
		this.pop = pop;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Override
	public String toString() {
		return "WebPage [url=" + url + ", author=" + author + ", content=" + content + ", pop=" + pop + "]";
	}
	
}
