/**
 * 
 */
package classes;

public class Post_u {
	String Id, Author, Heading, Content, Timestamp, Likes, Topic, SubRequire;
	Boolean Liked;

	public Post_u(String Id, String Author,String Heading, String Content, String Timestamp, String Likes, String Topic, String SubRequire, Boolean Liked) {
		this.Id = Id;
		this.Author = Author;
		this.Heading = Heading;
		this.Content = Content;
		this.Timestamp = Timestamp;
		this.Likes = Likes;
		this.Topic = Topic;
		this.SubRequire = SubRequire;
		this.Liked = Liked;
	}

	public String getId() {
		return Id; }

	public String getAuthor() {
		return Author; }

	public String getHeading() {
		return Heading; }

	public String getContent() {
		return Content; }

	public String getTimestamp() {
		return Timestamp; }

	public String getLikes() {
		return Likes; }

	public String getTopic() {
		return Topic; }

	public Boolean IsLiked() {
		return Liked; }
	
	public void setIsLiked(Boolean Liked) {
	       this.Liked = Liked; }
	
	public String getSubRequire() {
		return SubRequire; }
}
