package classes;

public class Subscription_adm {
	String Reader, Author, Timestamp, Type;

	public Subscription_adm(String Reader, String Author, String Timestamp, String Type) {
		this.Reader = Reader;
		this.Author = Author;
		this.Timestamp = Timestamp;
		this.Type = Type;
	}

	public String getReader() {
		return Reader; }

	public String getAuthor() {
		return Author; }

	public String getTimestamp() {
		return Timestamp; }

	public String getType() {
		return Type; }
}