package br.gov.ufpr.convida.resources;

import java.net.URI;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import br.gov.ufpr.convida.config.SendEmail;
import br.gov.ufpr.convida.domain.AccountCredentials;
import br.gov.ufpr.convida.domain.Bfav;
import br.gov.ufpr.convida.domain.Event;
import br.gov.ufpr.convida.domain.User;
import br.gov.ufpr.convida.services.EventService;
import br.gov.ufpr.convida.services.UserService;
import javassist.tools.rmi.ObjectNotFoundException;

@RestController
@RequestMapping(value = "/users")
public class UserResource {

    @Autowired
    private UserService service;

    @Autowired
    private EventService eserv;

    @Autowired
    PasswordEncoder bcrypt;

    @Autowired
    private SendEmail email;

   


    @GetMapping
    public ResponseEntity<List<User>> findAll(){
        List <User> users = service.findAll();
        return ResponseEntity.ok().body(users);
    }

    @GetMapping("/{id}")
    public ResponseEntity<User> findById(@PathVariable String id) throws ObjectNotFoundException {
        User obj = service.findById(id);
        return ResponseEntity.ok().body(obj);
    }

    @GetMapping("/namesearch")
    public ResponseEntity<List<User>> findByName(@RequestParam(value = "text", defaultValue = "") String text){
      text = Search.decode(text);
      List<User> users = service.findByName(text);
      return ResponseEntity.ok().body(users);
    }

    @PostMapping 
    public ResponseEntity<Void> insert(@RequestBody User user){

        user.setAdm(false);
        user = service.insert(user);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(user.getId()).toUri();
        return ResponseEntity.created(uri).build();
    }

    @PutMapping(value = "/{id}")
    public ResponseEntity<Void> update(@RequestBody User user, @PathVariable String id){
        user.setId(id);
        user = service.update(user);
        return ResponseEntity.noContent().build();
    }

    @PutMapping(value = "/checkpass")
    public ResponseEntity<Boolean> passcheck(@RequestBody AccountCredentials user) throws ObjectNotFoundException {
        User u = service.findById(user.getUsername());
        Boolean x =  bcrypt.matches(user.getPassword(), u.getPassword());
        return ResponseEntity.ok().body(x);  

    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Void> deleteuser(@PathVariable String id){
        service.delete(id);
        return ResponseEntity.status(200).build();
    }
    

    @PostMapping(value = "/fav")
    public ResponseEntity<Void> updateFav(@RequestBody Bfav ids) throws ObjectNotFoundException {
        
        User obj = service.findById(ids.getGrr());
        Event event = eserv.findById(ids.getId());

        event.setNbmrFavorites(event.getNbmrFavorites() + 1);
        obj.getFav().add(event);
        
        eserv.update(event);
        service.insertFav(obj);

        return ResponseEntity.noContent().build();

    }

    @PostMapping(value="/isfav")
    
    public ResponseEntity<Void> containsEvent(@RequestBody Bfav ids) throws ObjectNotFoundException {
       
         User user = service.findById(ids.getGrr());
        Event ev = eserv.findById(ids.getId());

       if(user.getFav().contains(ev)){
           return ResponseEntity.ok().build();

       }else{
           return ResponseEntity.status(404).build();
       }
        
    }

    @PostMapping(value ="/recovery")
    public ResponseEntity<Void> recovery(@RequestBody AccountCredentials a) throws ObjectNotFoundException{

        User u = service.findById(a.getPassword());

        String emailEnv = a.getUsername();
        String emailBd = u.getEmail();

        
        if(emailEnv.equals(emailBd)){
            
                Random r = new Random();
                Integer nPass = r.nextInt(99999);
                String s = "convida" + nPass.toString();


                email.sendEmail(u.getEmail(), s);
                
                u.setPassword(s);
                service.update(u);

                return ResponseEntity.noContent().build();
        }else{
            
            return ResponseEntity.status(401).build();
        }
    }

    @PostMapping(value = "/rfav")
    public ResponseEntity<Void> delete(@RequestBody Bfav ids) throws ObjectNotFoundException {

        User user = service.findById(ids.getGrr());
        Event event = eserv.findById(ids.getId());
        
        if(event.getNbmrFavorites() < 1) {
            event.setNbmrFavorites(0);
        } else {
            event.setNbmrFavorites(event.getNbmrFavorites() - 1);
        }
        eserv.update(event);
        
        user.getFav().remove(event);
        service.insertFav(user);

        return ResponseEntity.noContent().build();
    }
    
    @GetMapping(value = "/fav/{id}")
    public ResponseEntity<List<Event>> findFav(@PathVariable String id) throws ObjectNotFoundException {
        
        User user = service.findById(id);
        List<Event> fav = user.getFav();
        if(fav == null){
            return ResponseEntity.status(404).build();
        }else{
        return ResponseEntity.ok().body(fav);
        }
    }

    @GetMapping(value ="/myevents")
    public ResponseEntity<List<Event>> myEvents(@RequestParam(value = "text", defaultValue = "") String text){
       text = Search.decode(text);
       List<Event> events = eserv.findMyEvents(text);
       return ResponseEntity.ok().body(events);

    }


    @GetMapping(value="/conadmzd87l3/{id}")
    public ResponseEntity<Void> adm(@PathVariable String id) throws ObjectNotFoundException{

        User user = service.findById(id);
        user.setAdm(true);
        service.turnadm(user);

        return ResponseEntity.ok().build();
    }

    @GetMapping(value="/removeadmin/{id}")
    public ResponseEntity<Void> unturnAdmin(@PathVariable String id){
      User user = service.findById(id);
      user.setAdm(false);
      service.turnadm(user);

      return ResponseEntity.ok().build();
    }


    @GetMapping(value="/checkemail/{email}")
    public ResponseEntity<Boolean> checkEmail(@PathVariable String email){
        
        Boolean r;
    
       r = service.findByEmail(email);

       return ResponseEntity.status(200).body(r);

    }

    @GetMapping(value="/findAllAdmin")
    public ResponseEntity<List<User>> findAllAdmin(){
      List<User> admins = service.findAllAdmin();

      if(admins.isEmpty()){
        return ResponseEntity.status(404).build();
      }else{
        return ResponseEntity.ok().body(admins);
      }
      
    }

    @GetMapping(value="/findMyConfirmedEvents/{id}")
    public ResponseEntity<List<Event>> findMyConfirmedEvents(@PathVariable String id){
      
        List<Event> confirmedEvents = new ArrayList<>();
        User user = service.findById(id);
      
        confirmedEvents = user.getConfirmedEvents();
      
        return ResponseEntity.ok().body(confirmedEvents);  

    }



}