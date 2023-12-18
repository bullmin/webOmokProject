package game;

import jakarta.servlet.http.HttpSession;
import jakarta.websocket.server.ServerEndpointConfig;
import jakarta.websocket.HandshakeResponse;
import jakarta.websocket.server.HandshakeRequest;

public class HttpSessionConfigurator extends ServerEndpointConfig.Configurator{
	 @Override
	    public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
	        // HttpSession을 속성으로 추가
	        HttpSession httpSession = (HttpSession) request.getHttpSession();
	        if (config != null) {
	            // config 객체가 null이 아닌 경우에만 속성 추가
	            config.getUserProperties().put(HttpSession.class.getName(), httpSession);
	        }
	    }
}
