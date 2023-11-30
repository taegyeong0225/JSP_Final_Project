package diary;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BoardServlet")
public class diaryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public diaryServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getParameter("command");
		System.out.println("BoardServlet에서 요청을 받음을 확인: " + command);
		
		ActionFactory af = ActionFactory.getInstance();
		Action action = af.getAction(command);
		
        // 아직 모델을 만들지 않아서 액션 팩토리가 null 값을 갖는 액션을 반환하기 때문에 예외가 발생할 수 있다. 따라서 null이 아닐 때만 execute()를 호출하도록 조건문을 만들어 주었다.
		if(action != null) {
			action.execute(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}

}
