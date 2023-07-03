package classes;

public class Subscription {
	String Reader, Author, Timestamp;
	SubType Type;

	public Subscription(String Reader, String Author, String Timestamp, SubType Type) {
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

	public SubType getType() {
		return Type; }
}