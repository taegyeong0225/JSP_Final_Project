package user;

public class User {
	private String userID;
    private String userPassword;
    private String userName;
    private String userEmail;

    // 기본 생성자
    public User() {
    }

    // 매개변수가 있는 생성자
    public User(String userID, String userPassword, String userName, String userEmail) {
        this.userID = userID;
        this.userPassword = userPassword;
        this.userName = userName;
        this.userEmail = userEmail;
    }

    // Getter와 Setter 메소드
    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

}