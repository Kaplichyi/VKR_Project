package classes;

public class Comment {
	String Id, PostId, Username, Content, Timestamp;

	public Comment(String Id, String PostId, String Username, String Content, String Timestamp) {
		this.Id = Id;
		this.PostId = PostId;
		this.Username = Username;
		this.Content = Content;
		this.Timestamp = Timestamp;
	}

	public String getId() {
		return Id; }

	public String getPostId() {
		return PostId; }

	public String getUsername() {
		return Username; }

	public String getContent() {
		return Content; }

	public String getTimestamp() {
		return Timestamp; }
}