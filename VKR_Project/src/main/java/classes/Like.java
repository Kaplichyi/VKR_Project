package classes;

public class Like {
	String Postid, User, Timestamp;
	
	public Like(String Postid, String User, String Timestamp) {
		this.Postid = Postid;
		this.User = User;
		this.Timestamp = Timestamp;
	}

	public String getPostid() {
		return Postid; }

	public String getUser() {
		return User; }

	public String getTimestamp() {
		return Timestamp; }
}
