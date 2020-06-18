//Created by hbc 2020/6/2
import netscape.javascript.JSException;
import netscape.javascript.JSObject;
import org.json.JSONObject;

import java.io.*;
import java.net.*;
import java.util.*;

public class Network_Server_register {

    public static void main (String[] args)throws IOException {

        System.out.println("This is server");


        //listen the coming requests from clients
        ServerSocket listen = new ServerSocket(8888);
        while(true) {
            Socket server = listen.accept();//阻塞的那种，如果听到了client的request
            //就会创建socket
            new Thread(new Task(server)).start();
        }

    }
}
class Task implements Runnable{
    private Socket server;
    public Task(Socket s){
        this.server=s;
    }

    @Override
    public void run() {
        try {
            System.out.println("new connection is built");

            InputStream in = server.getInputStream();
            OutputStream out = server.getOutputStream();
            String strInput="";


            //receive request data from client

            byte[] buf = new byte[1024];
            int len = 0;
            len=in.read(buf);
            strInput+=new String(buf,0,len);


            //处理进来的客户端数据

            //1,将socket接受的数据还原为JSONObject
            JSONObject json =new JSONObject(strInput);
            int op=Integer.parseInt((String)json.get("option"));

            System.out.println(strInput);

            //2,do the special operation according to the option
            switch(op)
            {
                case 0://申请注册
                    String UID=json.getString("UID");
                    String passWord=json.getString("passWord");
                    System.out.println("register: UID:" + UID);
                    System.out.println("register: password:" + passWord);
                    System.out.println("**************************");
                    Map<String,String> map =new HashMap<String, String>();
                    map.put("option","1");
                    map.put("isSuccess","true");
                    //tell the client where is error if can't register the account
                    map.put("whereError","no");
                    json=new JSONObject(map);

                    //reply to the client
                    String jsonString=json.toString();
                    out.write(jsonString.getBytes());
                    out.flush();
                    out.close();
                    break;
            }



        }catch (Exception e){
      System.out.println("服务器run异常:"+e.getMessage());
        }//end catch
        finally {
            if(server!=null) try{
                server.close();
            }catch (Exception e){
                server=null;
                System.out.println("服务器finally异常");
            }
        }//end finally
    }//end run
}//end class Task thread