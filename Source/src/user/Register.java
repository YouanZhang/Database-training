package user;

import java.io.IOException;

public class Register {

    public Register() throws IOException{
        User user = new User();

        try {
            // TO-DO: get infomation from web
            user.setUserId(0);
        } catch (Exception e) {
            //TO-DO: send error message to web
        }
        
        try {
            // TO-DO: get infomation from web
            user.setUserName(null);
        } catch (Exception e) {
            //TO-DO: send error message to web
        }
        
        try {
            // TO-DO: get infomation from web
            user.setPassword(null);
        } catch (Exception e) {
            //TO-DO: send error message to web
        }
        
        try {
            // TO-DO: get infomation from web
            user.setName(null);
        } catch (Exception e) {
            //TO-DO: send error message to web
        }
        
        try {
            // TO-DO: get infomation from web
            user.setAddress(null);
        } catch (Exception e) {
            //TO-DO: send error message to web
        }
        
        try {
            // TO-DO: get infomation from web
            user.setEmailAddress(null);
        } catch (Exception e) {
            //TO-DO: send error message to web
        }
        
        try {
            // TO-DO: get infomation from web
            user.setPhoneNumber(null);
        } catch (Exception e) {
            //TO-DO: send error message to web
        }

        // send suceess message to web

    }

}