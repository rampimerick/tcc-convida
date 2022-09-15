package br.gov.ufpr.convida.config;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

@Service
public class SendEmail {

    @Autowired
    private JavaMailSender javaMailSender;

    public void sendEmail(String email, String password) {

        
        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setTo(email);

        
        msg.setSubject("Recuperação de senha - Convida");
        msg.setText("Sua nova senha é: " + password
                + ". Utilize-a para se logar no nosso aplicativo e troque por uma senha de sua preferencia!");
        try {
            javaMailSender.send(msg);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}