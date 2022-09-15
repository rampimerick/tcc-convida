package br.gov.ufpr.convida.services;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import br.gov.ufpr.convida.domain.User;
import br.gov.ufpr.convida.repository.UserRepository;

@Service
public class JwtUserDetailsService implements UserDetailsService {

    @Autowired
    UserRepository user;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {


        User newUser = user.findByLogin(username);
        if(user == null) {
            throw new UsernameNotFoundException("User not found");
        }else{
            return new org.springframework.security.core.userdetails.User(newUser.getLogin(),newUser.getPassword(),new ArrayList<>());
        }
    }
    }
