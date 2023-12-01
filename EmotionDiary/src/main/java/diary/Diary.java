package diary;

import java.sql.Timestamp;

public class Diary {

	private int diaryID;		 // 다이어리 아이디 
	private String DiaryTitle; 	 // 제목
	private String userID; 		 // 유저 아이디 
	private Timestamp diaryDate; // 날짜 
	private String diaryContent; // 내용  
	private int diaryAvailable;	
	private int diaryCount;
	
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
	public Timestamp getDiaryDate() {
		return diaryDate;
	}
	public void setDiaryDate(Timestamp diaryDate) {
		this.diaryDate = diaryDate;
	}
	
	// 내용  
	public String getDiaryContent() {
		return diaryContent;
	}
	public void setDiaryContent(String diaryContent) {
		this.diaryContent = diaryContent;
	}
	public int getDiaryAvailable() {
		return diaryAvailable;
	}
	public void setDiaryAvailable(int diaryAvailable) {
		this.diaryAvailable = diaryAvailable;
	}
	public int getDiaryCount() {
		return diaryCount;
	}
	public void setDiaryCount(int diaryCount) {
		this.diaryCount = diaryCount;
	}
	
}
