package classes;

public class SubType {
	String Id, Name, Author, Description, Price;

	public SubType(String Id, String Name, String Author, String Description, String Price) {
		this.Id = Id;
		this.Name = Name;
		this.Author = Author;
		this.Description = Description;
		this.Price = Price;
	}

	public String getId() {
		return Id; }

	public String getName() {
		return Name; }

	public String getAuthor() {
		return Author; }

	public String getDescription() {
		return Description; }

	public String getPrice() {
		return Price; }
}