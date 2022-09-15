package br.gov.ufpr.convida.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Location implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    private String coord;
    private String name;
    private String address;
    private String nmbr;
    private String cep;
    private String city;
    private String state;
    
    
    @DBRef(lazy = true)
    private List<Event> event = new ArrayList<>();


    public Location() {
    }

    public Location(String coord,String name, String address, String nmbr, String cep, String city, String state, List<Event> event) {
        this.coord = coord;
        this.name = name;
        this.address = address;
        this.nmbr = nmbr;
        this.cep = cep;
        this.city = city;
        this.state = state;
        this.event = event;
    }


    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }



    public String getCoord() {
        return this.coord;
    }

    public void setCoord(String coord) {
        this.coord = coord;
    }

    public String getAddress() {
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNmbr() {
        return this.nmbr;
    }

    public void setNmbr(String nmbr) {
        this.nmbr = nmbr;
    }

    public String getCep() {
        return this.cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getCity() {
        return this.city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return this.state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public List<Event> getEvent() {
        return this.event;
    }

    public void setEvent(List<Event> event) {
        this.event = event;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof Location)) {
            return false;
        }
        Location location = (Location) o;
        return Objects.equals(coord, location.coord) && Objects.equals(address, location.address) && Objects.equals(nmbr, location.nmbr) && Objects.equals(cep, location.cep) && Objects.equals(city, location.city) && Objects.equals(state, location.state) && Objects.equals(event, location.event);
    }

    @Override
    public int hashCode() {
        return Objects.hash(coord, address, nmbr, cep, city, state, event);
    }
    


}