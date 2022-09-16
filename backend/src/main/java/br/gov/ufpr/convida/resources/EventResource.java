package br.gov.ufpr.convida.resources;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import br.gov.ufpr.convida.domain.Event;
import br.gov.ufpr.convida.domain.OcurrencesDto;
import br.gov.ufpr.convida.domain.Report;
import br.gov.ufpr.convida.domain.User;
import br.gov.ufpr.convida.repository.ReportRepository;
import br.gov.ufpr.convida.services.EventService;
import br.gov.ufpr.convida.services.UserService;
import javassist.tools.rmi.ObjectNotFoundException;

@RestController
@RequestMapping(value = "/events")
     
public class EventResource {

    @Autowired
    private EventService service;

    @Autowired
    private ReportRepository rerepo;

    @Autowired
    private UserService userService;

  

    @GetMapping
    public ResponseEntity<List<Event>> findAll() {
        List<Event> list = service.findAll();
        return ResponseEntity.ok().body(list);

    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<Event> findById(@PathVariable String id) throws ObjectNotFoundException {
        Event obj = service.findById(id);
        return ResponseEntity.ok().body(obj);

    }

    @PostMapping
    public ResponseEntity<Void> insert(@RequestBody Event obj){
        if((!obj.getLink().toLowerCase().startsWith("http://")) && 
           (!obj.getLink().toLowerCase().startsWith("https://"))) {
            
            obj.setLink("http://" + obj.getLink());
        }
        String[] newLink;
        newLink = obj.getLink().split(":");
        obj.setLink(newLink[0].toLowerCase() + ":" + newLink[1]);
        
        obj = service.insert(obj);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(obj.getId()).toUri();
        return ResponseEntity.created(uri).build();
    }

    @PostMapping(value = "/recurrent")
    public ResponseEntity<Void> insertRecurrentEvent(@RequestBody OcurrencesDto occurences){
        
        if((!occurences.getEvent().getLink().toLowerCase().startsWith("http://")) && 
           (!occurences.getEvent().getLink().toLowerCase().startsWith("https://"))) {
            
            occurences.getEvent().setLink("http://" + occurences.getEvent().getLink());
        }
        String[] newLink;
        newLink = occurences.getEvent().getLink().split(":");
        occurences.getEvent().setLink(newLink[0].toLowerCase() + ":" + newLink[1]);
        
        service.insertOccurences(occurences.getEvent(), occurences.getOccurrences());
        return ResponseEntity.ok().build();
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<Void> update(@RequestBody Event event, @PathVariable String id){
        if((!event.getLink().toLowerCase().startsWith("http://")) && 
           (!event.getLink().toLowerCase().startsWith("https://"))){
            
            event.setLink("http://" + event.getLink());
        }
        String[] newLink;
        newLink = event.getLink().split(":");
        event.setLink(newLink[0].toLowerCase() + ":" + newLink[1]);
        
        service.update(event);
        return ResponseEntity.status(200).build();
        
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> delete(@PathVariable String id ) throws ObjectNotFoundException {

        service.delete(id);
        return ResponseEntity.status(200).build();
        
    }
    
    @GetMapping(value = "/namesearch")
    public ResponseEntity<List<Event>> findByName(@RequestParam(value = "text", defaultValue = "") String text){
        text = Search.decode(text);
        List<Event> events = service.findByName(text);
        return ResponseEntity.ok().body(events);

    }

    @GetMapping(value = "/typesearch")
    public ResponseEntity<List<Event>> findByType(@RequestParam(value = "text", defaultValue = "") String text){
        text = Search.decode(text);
        List<Event> events = service.findByType(text);
        return ResponseEntity.ok().body(events);
    }

    @GetMapping(value = "/nametypesearch")
    public ResponseEntity<List<Event>> findByNameinType(@RequestParam(value = "text", defaultValue = "") String text,
            @RequestParam(value = "type", defaultValue = "") String type){
            
        text = Search.decode(text);
        type = Search.decode(type);
        List<Event> events = service.findByNameType(text, type);
        return ResponseEntity.ok().body(events);           
    }

    @GetMapping(value = "/active")

    public ResponseEntity<List<Event>> findActiveEvent(){
        List<Event> list = service.findActiveEvents();
        return ResponseEntity.ok().body(list);
    }

    @GetMapping(value = "/today")
    public ResponseEntity<List<Event>> findToday(){
        List<Event> list = service.findEventToday();
        return ResponseEntity.ok().body(list);
    }


    @GetMapping(value = "/week")
    public ResponseEntity<List<Event>> findWeek(){
        List<Event> list = service.findEventWeek();
        return ResponseEntity.ok().body(list);
    }

    @PutMapping(value = "/report/{id}")
    public ResponseEntity<Void> report(@PathVariable String id, @RequestBody Report report)  throws ObjectNotFoundException{
        
        rerepo.insert(report);
        service.report(id, report);
        return ResponseEntity.ok().build();

    }

    @GetMapping(value = "/deactivate/{id}")
    public ResponseEntity<Void> deactivate(@PathVariable String id) throws ObjectNotFoundException{

        Event e = service.findById(id);
        e.setActive(false);
        service.deactivate(e);
        return ResponseEntity.ok().build();
    }


    @GetMapping(value = "/activate/{id}")
    public ResponseEntity<Void> activate(@PathVariable String id) throws ObjectNotFoundException{

        Event e = service.findById(id);
        if(e.getActive() == false){
            e.setActive(true);
        }
        service.deactivate(e);
        return ResponseEntity.ok().build();
    }


    @GetMapping(value = "/report/{id}")
    public ResponseEntity<List<Report>> vreport(@PathVariable String id){
         List<Report> r = service.findReports(id);
         return ResponseEntity.ok().body(r);
        

    }

    @GetMapping(value = "/multtype")
    public ResponseEntity<List<Event>> findByMultType(@RequestParam(value = "text", defaultValue = "") String text,
    @RequestParam(value = "text1", defaultValue = "") String text1,
    @RequestParam(value = "text2", defaultValue = "") String text2,
    @RequestParam(value = "text3", defaultValue = "") String text3,
    @RequestParam(value = "text4", defaultValue = "") String text4,
    @RequestParam(value = "text5", defaultValue = "") String text5,
    @RequestParam(value = "text6", defaultValue = "") String text6){
            
        text = Search.decode(text);
        text1 = Search.decode(text1);
        text2 = Search.decode(text2);
        text3 = Search.decode(text3);
        text4 = Search.decode(text4);
        text5 = Search.decode(text5);
        text6 = Search.decode(text6);
        


        
        List<Event> events = service.findByMultType(text, text1,text2,text3,text4,text5,text6);
        return ResponseEntity.ok().body(events);           
    }

    @GetMapping(value="/namemulttype")
    public ResponseEntity<List<Event>> findNameMultType (@RequestParam(value = "name", defaultValue = "") String name,
    @RequestParam(value = "text", defaultValue = "") String text,
    @RequestParam(value = "text1", defaultValue = "") String text1,
    @RequestParam(value = "text2", defaultValue = "") String text2,
    @RequestParam(value = "text3", defaultValue = "") String text3,
    @RequestParam(value = "text4", defaultValue = "") String text4,
    @RequestParam(value = "text5", defaultValue = "") String text5,
    @RequestParam(value = "text6", defaultValue = "") String text6){

        name = Search.decode(name);
        text = Search.decode(text);
        text1 = Search.decode(text1);
        text2 = Search.decode(text2);
        text3 = Search.decode(text3);
        text4 = Search.decode(text4);
        text5 = Search.decode(text5);
        text6 = Search.decode(text6);
        
        List<Event> events = service.findByMultTypeAndName(text, text1, text2, text3, text4, text5, text6, name);
        
        return ResponseEntity.ok().body(events);


    }

    @GetMapping(value = "/weektype")
    public ResponseEntity<List<Event>> findWeekType(@RequestParam(value = "text", defaultValue = "") String text,
    @RequestParam(value = "text1", defaultValue = "") String text1,
    @RequestParam(value = "text2", defaultValue = "") String text2,
    @RequestParam(value = "text3", defaultValue = "") String text3,
    @RequestParam(value = "text4", defaultValue = "") String text4,
    @RequestParam(value = "text5", defaultValue = "") String text5,
    @RequestParam(value = "text6", defaultValue = "") String text6){
            
        text = Search.decode(text);
        text1 = Search.decode(text1);
        text2 = Search.decode(text2);
        text3 = Search.decode(text3);
        text4 = Search.decode(text4);
        text5 = Search.decode(text5);
        text6 = Search.decode(text6);
        
     

        
        List<Event> events =  service.findWeekType(text, text1, text2, text3, text4, text5,text6);
        return ResponseEntity.ok().body(events);           
    }

    @GetMapping(value = "/nameweektype")
    public ResponseEntity<List<Event>> findNameWeekType(@RequestParam(value = "text", defaultValue = "") String text,
    @RequestParam(value = "text1", defaultValue = "") String text1,
    @RequestParam(value = "text2", defaultValue = "") String text2,
    @RequestParam(value = "text3", defaultValue = "") String text3,
    @RequestParam(value = "text4", defaultValue = "") String text4,
    @RequestParam(value = "text5", defaultValue = "") String text5,
    @RequestParam(value = "text6", defaultValue = "") String text6,
    @RequestParam(value = "name") String name){
            
        text = Search.decode(text);
        text1 = Search.decode(text1);
        text2 = Search.decode(text2);
        text3 = Search.decode(text3);
        text4 = Search.decode(text4);
        text5 = Search.decode(text5);
        text6 = Search.decode(text6);
        name = Search.decode(name);
        
     

        
        List<Event> events =  service.findNameWeekType(text, text1, text2, text3, text4, text5,text6, name);
        return ResponseEntity.ok().body(events);           
    }

    @GetMapping(value = "/nametodaytype")
    public ResponseEntity<List<Event>> findNameTodayType(@RequestParam(value = "text", defaultValue = "") String text,
    @RequestParam(value = "text1", defaultValue = "") String text1,
    @RequestParam(value = "text2", defaultValue = "") String text2,
    @RequestParam(value = "text3", defaultValue = "") String text3,
    @RequestParam(value = "text4", defaultValue = "") String text4,
    @RequestParam(value = "text5", defaultValue = "") String text5,
    @RequestParam(value = "text6", defaultValue = "") String text6,
    @RequestParam(value = "name") String name){

        
        text = Search.decode(text);
        text1 = Search.decode(text1);
        text2 = Search.decode(text2);
        text3 = Search.decode(text3);
        text4 = Search.decode(text4);
        text5 = Search.decode(text5);
        text6 = Search.decode(text6);
        name = Search.decode(name);
        

       
        List<Event> events =  service.findNameTodayType(text, text1, text2, text3, text4, text5,text6,name);
        return ResponseEntity.ok().body(events);           
    }

    @GetMapping(value = "/todaytype")
    public ResponseEntity<List<Event>> findTodayType(@RequestParam(value = "text", defaultValue = "") String text,
    @RequestParam(value = "text1", defaultValue = "") String text1,
    @RequestParam(value = "text2", defaultValue = "") String text2,
    @RequestParam(value = "text3", defaultValue = "") String text3,
    @RequestParam(value = "text4", defaultValue = "") String text4,
    @RequestParam(value = "text5", defaultValue = "") String text5,
    @RequestParam(value = "text6", defaultValue = "") String text6){

        
        text = Search.decode(text);
        text1 = Search.decode(text1);
        text2 = Search.decode(text2);
        text3 = Search.decode(text3);
        text4 = Search.decode(text4);
        text5 = Search.decode(text5);
        text6 = Search.decode(text6);
        

       
        List<Event> events =  service.findTodayType(text, text1, text2, text3, text4, text5,text6);
        return ResponseEntity.ok().body(events);           
    }

    @GetMapping(value = "/reported")
    public ResponseEntity<List<Event>> findReported(){
        List<Event> reported = service.findReported();
        return ResponseEntity.ok().body(reported);

    }

    @GetMapping(value="/ignore/{id}")
    public ResponseEntity<Void> ignoreReport(@PathVariable String id) throws ObjectNotFoundException{

        Report r = rerepo.findById(id).orElse(null);

        if(r != null){
            r.setIgnored(true);
            rerepo.save(r);
            return ResponseEntity.status(200).build();

        }else{
            return ResponseEntity.notFound().build();
            
        }
    }

    @GetMapping(value = "/nametypeonlinesearch")
    public ResponseEntity<List<Event>> findByNameTypeOnline(@RequestParam(value = "text", defaultValue = "") String text,
            @RequestParam(value = "type", defaultValue = "") String type){
            
        text = Search.decode(text);
        type = Search.decode(type);
        List<Event> events = service.findByNameTypeOnline(text, type);
        return ResponseEntity.ok().body(events);           
    }

    @GetMapping(value="/confirmpresence")
    public ResponseEntity<Void> confirmPresence(@RequestParam(value = "eventId", defaultValue = "") String eventId,
    @RequestParam(value = "userId", defaultValue = "") String userId) throws ObjectNotFoundException {

        try{
        
        User user = userService.findById(userId);
        Event event = service.findById(eventId);

        user.getConfirmedEvents().add(event);
        event.getConfirmed().add(user.getId());

        event.setNbmrConfirmed(event.getConfirmed().size());

        service.saveConfirmedEvents(user, event);
        
        return ResponseEntity.ok().build();
        

        
        }catch(Exception e){
            e.printStackTrace();
            return ResponseEntity.status(405).build();        }

    }

    @GetMapping(value="/removepresence")
    public ResponseEntity<Void> removePresence(@RequestParam(value = "eventId", defaultValue = "") String eventId,
    @RequestParam(value = "userId", defaultValue = "") String userId) throws ObjectNotFoundException {

        try{
        User user = userService.findById(userId);
        Event event = service.findById(eventId);

        user.getConfirmedEvents().remove(event);
        event.getConfirmed().remove(user.getId());

        event.setNbmrConfirmed(event.getConfirmed().size());

        service.saveConfirmedEvents(user, event);
        
        return ResponseEntity.ok().build();
        

        
        }catch(Exception e){
            e.printStackTrace();
            return ResponseEntity.status(405).build();        
        }

    }

    @GetMapping(value="/presence")
    public ResponseEntity<Boolean> presence(@RequestParam(value = "eventId", defaultValue = "") String eventId,
    @RequestParam(value = "userId", defaultValue = "") String userId) throws ObjectNotFoundException {

        try{
            
            User user = userService.findById(userId);
            Event event = service.findById(eventId);


            if(user.getConfirmedEvents().contains(event)){
                return ResponseEntity.ok().body(true);
            }else{
                return ResponseEntity.ok().body(false);
            }
        }catch(Exception e){
            e.printStackTrace();
            return ResponseEntity.status(405).build();
        }
    }
    
    @GetMapping(value = "/confirmed")
    public ResponseEntity<List<Event>> findOrderByConfirmed() {
        
        List<Event> list = service.findAllByConfirmed();
        return ResponseEntity.ok().body(list);
    }

    @GetMapping(value = "/confirmedUsers/{id}")
    public ResponseEntity<List<User>> findConfirmedUsers(@PathVariable String id) throws ObjectNotFoundException{
      Event event = service.findById(id);
      List<User> users = new ArrayList<>();
      
      for(String userId : event.getConfirmed() ){
        User newUser = userService.findById(userId);
        users.add(newUser);
      }
      
      if(users.isEmpty()){
        return ResponseEntity.status(404).build();
      }else{
        return ResponseEntity.ok().body(users);
      }
      
    }


    @GetMapping( value = "/deactivatedEvents")
    public ResponseEntity<List<Event>> findDeactivatedEvents(){
      
      List<Event> deactivatedEvents = new ArrayList<>();
      deactivatedEvents = service.findAllDeactivatedEvents();

      return ResponseEntity.ok().body(deactivatedEvents);

    }

}
