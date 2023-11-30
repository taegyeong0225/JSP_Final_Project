package diary;

import diary.Action;

public class ActionFactory {
	
	//싱글톤 패턴으로 정의
	private static ActionFactory instance = new ActionFactory();
	
	public static ActionFactory getInstance() {
		return instance;
	}
	
	public Action getAction(String command) {
		Action action = null;
		System.out.println("ActionFactory :" + command);
		return action;
	}
}
