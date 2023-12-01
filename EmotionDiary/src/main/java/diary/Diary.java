package diary;


public class Diary {

	private int diaryID;		 // 다이어리 아이디 
	private String DiaryTitle; 	 // 제목
	private String userID; 		 // 유저 아이디 
	private String diaryDate; // 날짜 
	private String diaryContent; // 내용  
	private String emotion;		 // 감정
	private int diaryAvailable;	 // 사용 가능 한지


	
	// 다이어리 아이디 
	public int getDiaryID() {
		return diaryID;
	}
	public void setDiaryID(int diaryID) {
		this.diaryID = diaryID;
	}
	
	// 제목
	public String getDiaryTitle() {
		return DiaryTitle;
	}
	public void setDiaryTitle(String DiaryTitle) {
		this.DiaryTitle = DiaryTitle;
	}
	
	// 유저 아이디 
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	// 날짜
	public String getDiaryDate() {
		return diaryDate;
	}
	public void setDiaryDate(String diaryDate) {
		this.diaryDate = diaryDate;
	}
	
	// 내용  
	public String getDiaryContent() {
		return diaryContent;
	}
	public void setDiaryContent(String diaryContent) {
		this.diaryContent = diaryContent;
	}
	// 감정
	
	public String getEmotion() {
		return emotion;
	}
	public void setEmotion(String emotion) {
		this.emotion = emotion;
	}
	// 사용 가능 여부
	public int getDiaryAvailable() {
		return diaryAvailable;
	}
	public void setDiaryAvailable(int diaryAvailable) {
		this.diaryAvailable = diaryAvailable;
	}
}
