package diary;
	
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

public class DiaryDAO {
	
	private Connection conn;//데이터베이스에 접근하게 해주는 하나의 객체
	private ResultSet rs;//정보를 담을 수 있는 객체
	
	public DiaryDAO() {//mysql에 접속을 하게 해줌,자동으로 데이터베이스 커넥션이 일어남
		try {//예외처리
			String dbURL = "jdbc:mysql://localhost:3306/DIARY?serverTimezone=UTC";
			String dbID="root";
			String dbPassword="rootpw";
			Class.forName("com.mysql.jdbc.Driver");//mysql드라이버를 찾는다.
			//드라이버는 mysql에 접속할 수 있도록 매개체 역할을 하는 하나의 라이브러리
			conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {//현재 서버 시간 가져오기
		String SQL="select now()";//현재 시간을 가져오는 mysql문장
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);//sql문장을 실행 준비 단계로
			rs=pstmt.executeQuery();//실행결과 가져오기
			if(rs.next()) {
				return rs.getString(1);//현재 날짜 반환
			}
			
		} catch(Exception e) {
			e.printStackTrace();//오류 발생
		}
		return "";//데이터베이스 오류
	}
	
	public int getNext() {
		String SQL="SELECT diaryID from DIARY order by diaryID DESC";//마지막 게시물 반환
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫 번째 게시물인 경우
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int write(String diaryTitle, String userID, String diaryContent, int diaryCount) {
		String SQL="INSERT INTO DIARY VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			
			pstmt.setInt(1, getNext());//게시글 번호
			pstmt.setString(2, diaryTitle);//제목
			pstmt.setString(3, userID);//아이디
//			pstmt.setString(4, getDiaryDate());//날짜
			
			Diary diary = new Diary();
			// ResultSet 객체에서 Timestamp 값을 가져옵니다.
			Timestamp diaryDate = rs.getTimestamp(4);
			// Diary 객체의 diaryDate 필드에 설정합니다.
			diary.setDiaryDate(diaryDate);
			
			pstmt.setString(5, diaryContent);//내용
			pstmt.setInt(6, 1);//삭제된 경우가 아니기 때문에 1을 넣어줌
			pstmt.setInt(7, diaryCount);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	//데이터베이스에서 글의 목록을 가져오는 소스코드 작성
	public ArrayList<Diary> getList(int pageNumber){//특정한 리스트를 받아서 반환
		String SQL="SELECT * from DIARY where diaryID < ? AND diaryAvailable = 1 order by diaryID desc limit 10";//마지막 게시물 반환, 삭제가 되지 않은 글만 가져온다.
		ArrayList<Diary> list = new ArrayList<Diary>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);//물음표에 들어갈 내용
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Diary diary = new Diary();
				diary.setDiaryID(rs.getInt(1));
				diary.setDiaryTitle(rs.getString(2));
				diary.setUserID(rs.getString(3));
				
				// ResultSet 객체에서 Timestamp 값을 가져옵니다.
				Timestamp diaryDate = rs.getTimestamp(4);
				// Diary 객체의 diaryDate 필드에 설정합니다.
				diary.setDiaryDate(diaryDate);

				
				diary.setDiaryContent(rs.getString(5));
				diary.setDiaryAvailable(rs.getInt(6));
				list.add(diary); // list에 해당 인스턴스를 담는다.
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;// 게시글 리스트 반환
	}
	
	public int getCount() {
		String SQL = "select count(*) from diary";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public boolean nextPage(int pageNumber) {//페이지 처리를 위한 함수
		String SQL="SELECT * from diary where diaryID < ? AND diaryAvailable =1";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return true;//다음 페이지로 넘어갈 수 있음
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Diary getDiary(int diaryID) {//하나의 글 내용을 불러오는 함수
		String SQL="SELECT * from DIARY where diaryID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, diaryID);//물음표
			rs=pstmt.executeQuery();//select
			if(rs.next()) {//결과가 있다면
				Diary diary = new Diary();
				diary.setDiaryID(rs.getInt(1));//첫 번째 결과 값
				diary.setDiaryTitle(rs.getString(2));
				diary.setUserID(rs.getString(3));

				Timestamp diaryDate = rs.getTimestamp(4);
				// Diary 객체의 diaryDate 필드에 설정합니다.
				diary.setDiaryDate(diaryDate);	
				
				diary.setDiaryContent(rs.getString(5));
				diary.setDiaryAvailable(rs.getInt(6));
//				int diaryCount=rs.getInt(7);
//				diary.setDiaryCount(diaryCount);
//				diaryCount++;
//				countUpdate(diaryCount,diaryID);

				return diary;//6개의 항목을 diary 인스턴스에 넣어 반환한다.
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int countUpdate(int diaryCount, int diaryID) {
		String SQL = "update diary set diaryCount = ? where diaryID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, diaryCount);//물음표의 순서
			pstmt.setInt(2, diaryID);
			return pstmt.executeUpdate();//insert,delete,update			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	
	public int update(int diaryID, String diaryTitle,String diaryContent ) {
		String SQL="update DIARY set diaryTitle = ?, diaryContent = ? where diaryID = ?";//특정한 아이디에 해당하는 제목과 내용을 바꿔준다. 
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, diaryTitle);//물음표의 순서
			pstmt.setString(2, diaryContent);
			pstmt.setInt(3, diaryID);
			return pstmt.executeUpdate();//insert,delete,update			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	public int delete(int diaryID) {
		String SQL = "update DIARY set diaryAvailable = 0 where diaryID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, diaryID);
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
	
	public ArrayList<Diary> getSearch(String searchField, String searchText){//특정한 리스트를 받아서 반환
	      ArrayList<Diary> list = new ArrayList<Diary>();
	      String SQL ="select * from diary WHERE "+searchField.trim();
	      try {
	            if(searchText != null && !searchText.equals("") ){
	                SQL +=" LIKE '%"+searchText.trim()+"%' order by diaryID desc limit 10";
	            }
	            PreparedStatement pstmt=conn.prepareStatement(SQL);
				rs=pstmt.executeQuery();//select
	         while(rs.next()) {
	        	Diary diary = new Diary();
	            diary.setDiaryID(rs.getInt(1));
	            diary.setDiaryTitle(rs.getString(2));
	            diary.setUserID(rs.getString(3));
				
				// ResultSet 객체에서 Timestamp 값을 가져옵니다.
				Timestamp diaryDate = rs.getTimestamp(4);
				// Diary 객체의 diaryDate 필드에 설정합니다.
				diary.setDiaryDate(diaryDate);
				
				
	            diary.setDiaryContent(rs.getString(5));
	            diary.setDiaryAvailable(rs.getInt(6));
	            list.add(diary);//list에 해당 인스턴스를 담는다.
	         }         
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
	      return list;//ㄱㅔ시글 리스트 반환
	   }
}