package br.gov.ufpr.convida.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import br.gov.ufpr.convida.repository.UserRepository;
import br.gov.ufpr.convida.domain.Event;
import br.gov.ufpr.convida.domain.User;

@Service
public class UserService {

    @Autowired
    private UserRepository repo;
    @Autowired
    private PasswordEncoder bcrypt;


    public List<User> findAll() {
        return repo.findAll();
    }

    public User findById(String id) {
        User user = repo.findById(id).orElse(null);
        return user;

    }
    
    public User findByLogin(String login){
    	User user = repo.findByLogin(login);
    	return user;
    }

    public User insert(User user) {
        
        user.setPassword(bcrypt.encode(user.getPassword()));
        return repo.insert(user);

    }

    public User insertFav(User user){
         return repo.save(user);
    }

    public void deleteFav(User user, Event event){
        user.getFav().remove(event);

    }

    public User update(User user){
        User newUser = repo.findById(user.getId()).orElse(null);
        updateData(newUser, user);
        return repo.save(newUser);
    }

    public void updateData(User newUser, User user){
        newUser.setName(user.getName());
        newUser.setLastName(user.getLastName());
        newUser.setLogin(user.getLogin());
        newUser.setEmail(user.getEmail());
        newUser.setBirth(user.getBirth());
    }

    public void delete(String id){
        repo.deleteById(id);
    }

    public void turnadm(User user){
        repo.save(user);
    }

    public Boolean findByEmail(String email){
        

        User u = repo.findByEmail(email);

        if(u == null){
            return true;
        }else{
            return false;
        }
    }

    public List<User> findAllAdmin(){
      List<User> admins = new ArrayList<>();
      admins = repo.findAllAdmin();

      for(User a : admins){
        a.setFav(null);
        a.setConfirmedEvents(null);

      }
      return admins;
    }

    public List<User> findByName(String name){
      return repo.findByName(name);
    }



}