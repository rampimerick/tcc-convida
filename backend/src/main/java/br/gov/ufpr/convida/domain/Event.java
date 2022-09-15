package br.gov.ufpr.convida.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;


import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;



//LDAP


@Document
public class Event implements Serializable{


    private static final long serialVersionUID = 1L;
    
    @Id
    private String id;
    
    private String name;
    private String target;
    private Date dateStart;
    private Date dateEnd;
    private Date hrStart;
    private Date hrEnd;
    private String desc;
    private Date startSub;
    private Date endSub;
    private String link;
    private String type;
    private String complement;
    private double lat;
    private double lng;   
    private String author;
    private String address;
    private boolean active = true;
    private boolean online = false;
    private boolean reported = false;
    private int nbmrConfirmed;
    private int nbmrFavorites;

    @DBRef
    private List<Report> reports = new ArrayList<>();

    private List<String> confirmed = new ArrayList<String>();
  

    public Event(){

    }

    


    public Event(Event event) {
      this.id = event.getId();
      this.name = event.getName();
      this.target = event.getTarget();
      this.dateStart = event.getDateStart();
      this.dateEnd = event.getDateEnd();
      this.hrStart = event.getHrStart();
      this.hrEnd = event.getHrEnd();
      this.desc = event.getDesc();
      this.startSub = event.getStartSub();
      this.endSub = event.getEndSub();
      this.link = event.getLink();
      this.type = event.getType();
      this.complement = event.getComplement();
      this.lat = event.getLat();
      this.lng = event.getLng();
      this.author = event.getAuthor();
      this.address = event.getAddress();
      this.active = event.getActive();
      this.online = event.getOnline();
      this.reported = event.getReported();
      this.nbmrConfirmed = event.getNbmrConfirmed();
      this.nbmrFavorites = event.getNbmrFavorites();
      this.reports = event.getReports();
      this.confirmed = event.getConfirmed();
    }




    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTarget() {
        return this.target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public Date getDateStart() {
        return this.dateStart;
    }

    public void setDateStart(Date dateStart) {
        this.dateStart = dateStart;
    }

    public Date getDateEnd() {
        return this.dateEnd;
    }

    public void setDateEnd(Date dateEnd) {
        this.dateEnd = dateEnd;
    }

    public Date getHrStart() {
        return this.hrStart;
    }

    public void setHrStart(Date hrStart) {
        this.hrStart = hrStart;
    }

    public Date getHrEnd() {
        return this.hrEnd;
    }

    public void setHrEnd(Date hrEnd) {
        this.hrEnd = hrEnd;
    }

    public String getDesc() {
        return this.desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public Date getStartSub() {
        return this.startSub;
    }

    public void setStartSub(Date startSub) {
        this.startSub = startSub;
    }

    public Date getEndSub() {
        return this.endSub;
    }

    public void setEndSub(Date endSub) {
        this.endSub = endSub;
    }

    public String getLink() {
        return this.link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getComplement() {
        return this.complement;
    }

    public void setComplement(String complement) {
        this.complement = complement;
    }

    public double getLat() {
        return this.lat;
    }

    public void setLat(double lat) {
        this.lat = lat;
    }

    public double getLng() {
        return this.lng;
    }

    public void setLng(double lng) {
        this.lng = lng;
    }

    public String getAuthor() {
        return this.author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }


    public String getAddress() {
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }



    public List<Report> getReports() {
        return this.reports;
    }

    public void setReports(List<Report> reports) {
        this.reports = reports;
    }

    public boolean isActive() {
        return this.active;
    }

    public boolean getActive() {
        return this.active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }
   
    public boolean isOnline() {
        return this.online;
    }

    public boolean getOnline() {
        return this.online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }

    public boolean isReported() {
        return this.reported;
    }

    public boolean getReported() {
        return this.reported;
    }

    public void setReported(boolean reported) {
        this.reported = reported;
    }

    public List<String> getConfirmed() {
        return confirmed;
    }

    public void setConfirmed(List<String> confirmed) {
        this.confirmed = confirmed;
    }

    public int getNbmrConfirmed() {
        return nbmrConfirmed;
    }

    public void setNbmrConfirmed(int nbmrConfirmed) {
        this.nbmrConfirmed = nbmrConfirmed;
    }

    public int getNbmrFavorites() {
        return nbmrFavorites;
    }

    public void setNbmrFavorites(int nbmrFavorites) {
        this.nbmrFavorites = nbmrFavorites;
    }
    

    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof Event)) {
            return false;
        }
        Event event = (Event) o;
        return Objects.equals(id, event.id);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(id);
    }

    

    
    
    
}