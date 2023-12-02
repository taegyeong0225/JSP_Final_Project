package diary;

import java.util.Arrays;
import java.util.List;

public class emotionAnalytics {

    // 확장된 긍정적 단어 및 형용사 목록
    private List<String> positiveWords = Arrays.asList(
        "행복한", "기쁨", "사랑", "긍정", "좋음", "좋았다", "좋다", "웃음", "웃은", "즐거움", "ㅋ", "ㅎ",
        "만족", "환희", "감동한", "흥분", "신난", "기쁜", "희열", "반가움", "안도", "활기", "밝음", "평온",
        "당당함", "자신감", "열정", "활발", "행복감", "애정", "따뜻한", "설렘", "만족감"
    );

    // 확장된 부정적 단어 및 형용사 목록
    private List<String> negativeWords = Arrays.asList(
        "슬픈", "불행", "싫음", "부정", "나쁨", "나빴다", "나쁘다", "울음", "울은", "고통", "ㅠ", "ㅜ",
        "실망", "우울한", "괴로움", "짜증", "불안", "스트레스", "좌절", "분노", "불쾌", "피곤", "우울감",
        "두려움", "슬픔", "절망", "홧김", "불만", "불안감", "초조", "불쾌감", "무기력"
    );
    
    public String analyzeSentiment(String diaryContent) {
        int positiveCount = 0;
        int negativeCount = 0;

        // 공백으로 단어를 구분하여 배열로 만든다.
        String[] words = diaryContent.split("\\s+");

        // 각 단어에 대해 긍정/부정 단어 목록에 있는지 확인한다.
        for (String word : words) {
            if (positiveWords.contains(word)) {
                positiveCount++;
            } else if (negativeWords.contains(word)) {
                negativeCount++;
            }
        }

        // 결과를 기반으로 감정을 분석한다.
        if (positiveCount > negativeCount) {
            return "긍정";
        } else if (positiveCount < negativeCount) {
            return "부정";
        } else {
            return "중립";
        }
    }
}

