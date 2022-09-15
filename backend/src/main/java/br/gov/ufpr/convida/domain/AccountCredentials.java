package br.gov.ufpr.convida.domain;

import java.io.Serializable;

public class AccountCredentials implements Serializable {
    

    private static final long serialVersionUID = 1L;
   
    private String username;
    private String password;


    public AccountCredentials() {
    }

    public String getUsername() {
        return this.username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    
    
}