package br.gov.ufpr.convida.domain;

import java.util.Date;

public class Occurrence {

  private Date start;
  private Date end;
  
  public Occurrence() {
  }

  public Date getStart() {
    return start;
  }
  public void setStart(Date start) {
    this.start = start;
  }
  public Date getEnd() {
    return end;
  }
  public void setEnd(Date end) {
    this.end = end;
  }
  
  
}
