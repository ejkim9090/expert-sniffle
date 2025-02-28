package study.cloud.stc.chat;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class HandlerChat extends TextWebSocketHandler {
	
	// (<"room_id", 방ID>, <"session", 세션>) - (<"room_id", 방ID>, <"session", 세션>) - (<"room_id", 방ID>, <"session", 세션>) 형태 
		private List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();
		
		// 클라이언트가 서버로 메세지 전송 처리
		@Override
		protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

			super.handleTextMessage(session, message);
			
			// JSON --> Map으로 변환 이게 메세지 받는거
			ObjectMapper objectMapper = new ObjectMapper();
			Map<String, String> mapReceive = objectMapper.readValue(message.getPayload(), Map.class);
			
			/*  작업 시작  */
			
			// 날짜 선언
			Date date = new Date();
			Date now = Calendar.getInstance().getTime();

			// 캘린더 선언
			Calendar cal = Calendar.getInstance();
			
			// 포멧
			//SimpleDateFormat formatter = new SimpleDateFormat("yyyy년 MM월 dd일 a hh시 mm분 ss초");
			SimpleDateFormat formatter = new SimpleDateFormat("a hh:mm");
			String formatedNow = formatter.format(now);
			
			System.out.println(formatedNow);
			
			/*
			 * //날짜 더하기 - 추가 작업 필요 String asd = mapReceive.get("msg") + df;
			 * System.out.println();
			 * System.out.println("From HandlerChat msg: "+mapReceive.get("msg"));
			 */
			
			
			// 메일 전송자의 닉네임
			String division = mapReceive.get("division");
			System.out.println("From HandlerChat division: "+ division);
			
			
			
			switch (mapReceive.get("cmd")) {
			
			// CLIENT 입장
			case "CMD_ENTER":
				// 세션 리스트에 저장
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("room_id", mapReceive.get("room_id"));
				map.put("session", session);
				sessionList.add(map);
				
				// 같은 채팅방에 입장 메세지 전송
				for (int i = 0; i < sessionList.size(); i++) {
					Map<String, Object> mapSessionList = sessionList.get(i);
					String room_id = (String) mapSessionList.get("room_id");
					WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");
					
					System.out.println("입장 == session.getId(): "+session.getId()+ "sess.getId(): "+ sess.getId());
					
					if(room_id.equals(mapReceive.get("room_id"))) {
						Map<String, String> mapToSend = new HashMap<String, String>();
						mapToSend.put("room_id", room_id);
						mapToSend.put("cmd", "CMD_ENTER");
						mapToSend.put("msg", session.getPrincipal().getName() +  "님이 입장 했습니다.");
						
						String jsonStr = objectMapper.writeValueAsString(mapToSend);
						sess.sendMessage(new TextMessage(jsonStr));
					}
				}
				break;
				
			// CLIENT 메세지
			case "CMD_MSG_SEND":
				// 같은 채팅방에 메세지 전송
				for (int i = 0; i < sessionList.size(); i++) {
					Map<String, Object> mapSessionList = sessionList.get(i);
					String room_id = (String) mapSessionList.get("room_id");
					WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");

					if (room_id.equals(mapReceive.get("room_id"))) {
						Map<String, String> mapToSend = new HashMap<String, String>();
						mapToSend.put("room_id", room_id);
						mapToSend.put("cmd", "CMD_MSG_SEND");
						
						// 실질적인 메세지 			
						//mapToSend.put("msg", session.getPrincipal().getName() + " 같을때 <br> " + formatedNow + mapReceive.get("msg"));				
						mapToSend.put("msg", mapReceive.get("msg"));

						// 작성자
						mapToSend.put("sender", session.getPrincipal().getName() + "<br>");
						
						// 구분용 전송자의 principal 정보가 들어있음
						mapToSend.put("division", division);
						
						// 메세지 전송 시간이 들어있음
						mapToSend.put("formatedNow", formatedNow);

						String jsonStr = objectMapper.writeValueAsString(mapToSend);
						sess.sendMessage(new TextMessage(jsonStr));
					}
				}
				break;
			}
		}

		// 클라이언트가 연결을 끊음 처리
		@Override
		public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

			super.afterConnectionClosed(session, status);
	        
			ObjectMapper objectMapper = new ObjectMapper();
			String now_room_id = "";
			
			// 사용자 세션을 리스트에서 제거
			for (int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> map = sessionList.get(i);
				String room_id = (String) map.get("room_id");
				WebSocketSession sess = (WebSocketSession) map.get("session");
				
				if(session.equals(sess)) {
					now_room_id = room_id;
					sessionList.remove(map);
					break;
				}	
			}
			
			// 같은 채팅방에 퇴장 메세지 전송 
			for (int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> mapSessionList = sessionList.get(i);
				String room_id = (String) mapSessionList.get("room_id");
				WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");

				System.out.println("퇴장 == session.getId(): "+session.getId()+ "sess.getId(): "+ sess.getId());
				
				if (room_id.equals(now_room_id)) {
					Map<String, String> mapToSend = new HashMap<String, String>();
					mapToSend.put("room_id", room_id);
					mapToSend.put("cmd", "CMD_EXIT");
					mapToSend.put("msg", session.getPrincipal().getName() + "님이 퇴장 했습니다.");

					String jsonStr = objectMapper.writeValueAsString(mapToSend);
					sess.sendMessage(new TextMessage(jsonStr));
				}
			}
		}
}
