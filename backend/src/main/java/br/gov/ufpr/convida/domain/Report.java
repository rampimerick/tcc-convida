package br.gov.ufpr.convida.domain;

import java.io.Serializable;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Report implements Serializable{

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    @Id
    private String id;
    private String userId;
    private String userName;
    private String userLastName;
    private String report;
    private Boolean ignored;

    public Report(){}

    
    

    public String getId(){
        return this.id;
    }

    public void setId(String id){
        this.id = id;
    }

	public String getReport() {
        return this.report;
    }

    public void setReport(String report) {
        this.report = report;
    }

    public boolean isIgnored() {
        return this.ignored;
    }

    public boolean getIgnored() {
        return this.ignored;
    }

    public void setIgnored(Boolean ignored) {
        this.ignored = ignored;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserLastName() {
        return userLastName;
    }

    public void setUserLastName(String userLastName) {
        this.userLastName = userLastName;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Report other = (Report) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;
        return true;
    }
  
  
}