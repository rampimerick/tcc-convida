package br.gov.ufpr.convida.domain;

import java.io.Serializable;
import java.util.Objects;

public class Bfav implements Serializable{

    private static final long serialVersionUID = 1L;

    private String grr;
    private String id;

    public Bfav(){}




    public String getGrr() {
        return this.grr;
    }

    public void setGrr(String grr) {
        this.grr = grr;
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }



    @Override
    public boolean equals(Object o) {
        if (o == this)
            return true;
        if (!(o instanceof Bfav)) {
            return false;
        }
        Bfav bfav = (Bfav) o;
        return Objects.equals(grr, bfav.grr) && Objects.equals(id, bfav.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(grr, id);
    }



}