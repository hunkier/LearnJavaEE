package cn.hunkier.user.thrift;

import cn.hunkier.thrift.message.MessageService;
import cn.hunkier.thrift.user.UserService;
import lombok.extern.slf4j.Slf4j;
import org.apache.thrift.TServiceClient;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.transport.TFramedTransport;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.transport.TTransport;
import org.apache.thrift.transport.TTransportException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class ServiceProvider {

    @Value("${thrift.user.ip}")
    private String userServerIp;
    @Value("${thrift.user.port}")
    private int userServerPort;

    @Value("${thrift.message.ip}")
    private String messageServerIp;
    @Value("${thrift.message.port}")
    private int messageServerPort;

    private enum ServiceType {
        USER,
        MESSAGE,
    }


    public UserService.Client getUserService(){
        return getService(userServerIp,userServerPort,ServiceType.USER);
    }

    public MessageService.Client getMessageService(){
        return getService(messageServerIp,messageServerPort,ServiceType.MESSAGE);
    }


    private <T> T getService(String ip, int port, ServiceType serviceType){
        log.info("ip:{},port:{}, serviceType: {}", ip, port, serviceType);
        TSocket socket = new TSocket(ip, port, 3000);
        TTransport transport = new TFramedTransport(socket);
        try {
            transport.open();
        } catch (TTransportException e) {
            e.printStackTrace();
            return  null;
        }
        TProtocol protocol = new TBinaryProtocol(transport);
        TServiceClient client = null ;
        switch (serviceType){
            case USER:
                client = new UserService.Client(protocol);
                break;

            case MESSAGE:
                client = new MessageService.Client(protocol);
                break;
        }
        return (T)client;
    }
}
