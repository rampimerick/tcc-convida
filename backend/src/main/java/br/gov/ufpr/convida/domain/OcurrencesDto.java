package br.gov.ufpr.convida.domain;

import java.util.List;

public class OcurrencesDto {
    
    public Event event;
    public List<Occurrence> occurrences;
   
    public OcurrencesDto() {
    }

    public Event getEvent() {
        return event;
    }
    public void setEvent(Event event) {
        this.event = event;
    }
    public List<Occurrence> getOccurrences() {
        return occurrences;
    }
    public void setOccurrences(List<Occurrence> occurrences) {
        this.occurrences = occurrences;
    }

    
    
}
