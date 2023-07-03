package classes;

public class Author {
	String Id, Nickname, About, SubsAmount, PostsAmount;

	public Author(String Id, String Nickname, String About, String SubsAmount, String PostsAmount) {
		this.Id = Id;
		this.Nickname = Nickname;
		this.About = About;
		this.SubsAmount = SubsAmount;
		this.PostsAmount = PostsAmount;
	}

	public String getId() {
		return Id;
	}

	public String getNickname() {
		return Nickname;
	}

	public String getAbout() {
		return About;
	}

	public String getSubsAmount() {
		return SubsAmount;
	}
	
	public String getPostsAmount() {
		return PostsAmount;
	}
}
