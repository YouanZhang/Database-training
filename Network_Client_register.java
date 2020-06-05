//Create by hbc 2020/6/2
import netscape.javascript.JSObject;
import org.json.JSONObject;

import java.io.*;
import java.net.*;
import java.util.*;

public class Network_Client_register {


      public static void main(String[] args)  throws IOException
      {
          System.out.println("This is client");
         InetAddress inetAddress=InetAddress.getLocalHost();
          String Server_IP=inetAddress.getHostAddress().toString();
       // String Server_IP="106.55.23.156";
          JSONObject json;
          //input the account msg
          String account_name;
          String account_password;
          Scanner sc=new Scanner(System.in);
          System.out.println("Please input Register name");
          account_name=sc.next();
          System.out.println("Please input Register password");
          account_password=sc.next();

          //transfer the input msg to json format
          Map<String,String> map =new HashMap<String, String>();
          map.put("option","0");
          map.put("UID",account_name);
          map.put("passWord",account_password);
          json=new JSONObject(map);

          //transfer json to string Byte
           String jsonString=json.toString();
          //request to connect the server
          Socket client =new Socket(Server_IP,8888);
          InputStream in = client.getInputStream();
          OutputStream out = client.getOutputStream();
          boolean RegisterOver=false;

          //send the json String to the server
          out.write(jsonString.getBytes());
          out.flush();
          System.out.println(jsonString);

          //receiver reply from server
          ByteArrayOutputStream baos=new ByteArrayOutputStream();
          byte[] buf = new byte[1024];
          int len = 0;
          while((len=in.read(buf))!=-1)
          {
           baos.write(buf,0,len);
          }
          String rec = new String(baos.toByteArray());
          json=new JSONObject(rec);

          System.out.println("test3");

          //show information to the screen.
          System.out.println("Msg From Server: isSuccess " + json.getString("isSuccess"));
          System.out.println("Msg From Server: whereError" + json.getString("whereError"));
         RegisterOver=Boolean.parseBoolean((String)json.get("isSuccess"));
          if(RegisterOver==true)
          System.out.println("Account is registered successfully");
          else       System.out.println("Account registered fail");
      }

}
