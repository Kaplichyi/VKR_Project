package classes;

public class User {
	String Id, Login, Password, Nickname, About, SubsAmount, Role, EMail;

	public User(String Id, String Login, String Password, String Nickname, String About, String SubsAmount,
			String Role, String EMail) {
		this.Id = Id;
		this.Login = Login;
		this.Password = Password;
		this.Nickname = Nickname;
		this.About = About;
		this.SubsAmount = SubsAmount;
		this.Role = Role;
		this.EMail = EMail;
	}

	public String getId() {
		return Id; }

	public String getLogin() {
		return Login; }

	public String getPassword() {
		return Password; }

	public String getNickname() {
		return Nickname; }

	public String getAbout() {
		return About; }

	public String getSubsAmount() {
		return SubsAmount; }

	public String getRole() {
		return Role; }

	public String getEMail() {
		return EMail; }
}