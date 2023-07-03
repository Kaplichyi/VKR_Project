package classes;

public class Topic {
	String Id, Name, Author;
	
	public Topic(String Id, String Name, String Author) {
		this.Id = Id;
		this.Name = Name;
		this.Author = Author;
	}

	public String getId() {
		return Id; }

	public String getName() {
		return Name; }

	public String getAuthor() {
		return Author; }
}
