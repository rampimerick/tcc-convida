package br.gov.ufpr.convida.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;


@Document
public class User implements Serializable{

    private static final long serialVersionUID = 1L;
    
    @Id
    private String id;
    private String login;
    private String name;
    private String lastName;
    private String password;

    @Indexed(unique = true)
    
    private String email;
    private Date birth;
    private Boolean adm = false;

    @DBRef(lazy = true)
    private List<Event> fav = new ArrayList<>();
    @DBRef(lazy = true)
    private List<Event> confirmedEvents = new ArrayList<Event>();


    public User() {
    }    


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getLogin() {
		return login;
    }
    

	public void setLogin(String login) {
		this.login = login;
	}

	public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLastName() {
        return this.lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public Date getBirth() {
        return this.birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }


    public List<Event> getFav() {
        return this.fav;
    }

    public void setFav(List<Event> fav) {
        this.fav = fav;
    }

    public boolean isAdm() {
        return this.adm;
    }

    public boolean getAdm() {
        return this.adm;
    }

    public void setAdm(Boolean adm) {
        this.adm = adm;
    }

    
    public List<Event> getConfirmedEvents() {
        return confirmedEvents;
    }

    public void setConfirmedEvents(List<Event> confirmedEvents) {
        this.confirmedEvents = confirmedEvents;
    }

    



    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof User)) {
            return false;
        }
        User user = (User) o;
        return Objects.equals(id, user.id);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(id);
    }


   

    






}