package br.gov.ufpr.convida.resources;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import br.gov.ufpr.convida.config.JwtTokenUtil;
import br.gov.ufpr.convida.domain.AccountCredentials;
import br.gov.ufpr.convida.domain.LoginResponse;
import br.gov.ufpr.convida.domain.User;
import br.gov.ufpr.convida.repository.UserRepository;
import br.gov.ufpr.convida.security.LdapConnection;
import br.gov.ufpr.convida.services.JwtUserDetailsService;

@RestController
@CrossOrigin
public class JwtAuthenticationController {
    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Autowired
    private JwtUserDetailsService userDetailsService;
    @Autowired
    UserRepository user;
    @Autowired
    private PasswordEncoder bcrypt;

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ResponseEntity<?> createAuthenticationToken(@RequestBody AccountCredentials authenticationRequest)
            throws Exception {

        if (authenticationRequest.getUsername().endsWith("@ufpr.br")) {
            

            LdapConnection auth = new LdapConnection();
            if (auth.connectToLDAP(authenticationRequest.getUsername(), authenticationRequest.getPassword(), "200.17.209.253") == true) {
        

                User newUserLdap = user.findByLogin(authenticationRequest.getUsername());
                LoginResponse r = new LoginResponse();

                if(newUserLdap == null){
                     
                    r.setRegistered(false);
                    
                    return ResponseEntity.ok().body(r);

                }else{
                    LoginResponse rLdap = ldapUser(authenticationRequest.getUsername(),authenticationRequest.getPassword());
            	    return ResponseEntity.ok().body(rLdap);
                }
           
            } else if(auth.connectToLDAP(authenticationRequest.getUsername(), authenticationRequest.getPassword(), "200.17.209.252") == true) {
            
            	User newUserLdap = user.findByLogin(authenticationRequest.getUsername());
                LoginResponse r = new LoginResponse();

                if(newUserLdap == null){

                    r.setRegistered(false);
                    
                    return ResponseEntity.ok().body(r);

                }else{

                    LoginResponse rLdap = ldapUser(authenticationRequest.getUsername(),authenticationRequest.getPassword());
            	    return ResponseEntity.ok().body(rLdap);
                }
           
            }else{
            	return ResponseEntity.status(405).build();
         
            }
        } else if(authenticationRequest.getUsername().endsWith("@divulgacao.ufpr")){
        	
        	User newUser = user.findByLogin(authenticationRequest.getUsername());
        	
        	authenticate(authenticationRequest.getUsername(), authenticationRequest.getPassword());
        	LoginResponse r = new LoginResponse();
			final UserDetails userDetails = userDetailsService.loadUserByUsername(authenticationRequest.getUsername());
			final String token = jwtTokenUtil.generateToken(userDetails);
			r.setUserId(newUser.getId());
			r.setToken(token);
			return ResponseEntity.ok().body(r);
        	
        	
        }else {
        	
        		String url = "https://www.prppg.ufpr.br/siga/autenticacaoterceiros/discente/graduacao";
        		
        		HttpHeaders httpHeaders = new HttpHeaders();
        		httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        	
        		JSONObject json = new JSONObject();
        		json.put("cpf", authenticationRequest.getUsername());
        		json.put("senha", authenticationRequest.getPassword());
        		json.put("token", "da39a3ee5e6b4b0d3255bfef95601890afd80709");
        		
        		HttpEntity <String> httpEntity = new HttpEntity <String> (json.toString(), httpHeaders);
        		RestTemplate restTemplate = new RestTemplate();
        		
        		try{
        		String response = restTemplate.postForObject(url, httpEntity, String.class);
	
        		User newUser = user.findByLogin(authenticationRequest.getUsername());
        		
        		if(newUser == null){
        				
        				
                        LoginResponse r = new LoginResponse();
                      
                        r.setRegistered(false);
                        
                        return ResponseEntity.ok().body(r);
        				
        				
        			}else {
        			
        				LoginResponse r = new LoginResponse();
        				final UserDetails userDetails = userDetailsService.loadUserByUsername(authenticationRequest.getUsername());
        				final String token = jwtTokenUtil.generateToken(userDetails);
        				r.setUserId(newUser.getId());
        				r.setToken(token);
                        r.setRegistered(true);
        				return ResponseEntity.ok().body(r);
        			}
        		
        		}catch(Exception e){
        			e.printStackTrace();
        			return ResponseEntity.status(401).build();
        		}			
        }
        		
    }
    
    
    private LoginResponse ldapUser(String username, String password){
    	
    	User newUser = user.findByLogin(username);
        
        if (newUser == null) {
            User u = new User();
            u.setLogin((username));
            u.setPassword(bcrypt.encode(password));
            u.setEmail(username);
            user.insert(u);
            String userId = u.getId();

            
            final UserDetails userDetails = userDetailsService
                    .loadUserByUsername(username);
                        
            LoginResponse r = new LoginResponse();
           
            
            final String token = jwtTokenUtil.generateToken(userDetails);
            
            r.setUserId(userId);
            r.setToken(token);
            r.setRegistered(true);
            return r;
        } else {

            final UserDetails userDetails = userDetailsService
                    .loadUserByUsername(username);
            final String token = jwtTokenUtil.generateToken(userDetails);
            
            LoginResponse r = new LoginResponse();
            r.setUserId(newUser.getId());
            r.setToken(token);
            
            
            return r;
        }
    }

    private void authenticate(String username, String password) throws Exception {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
        } catch (DisabledException e) {
            throw new Exception("USER_DISABLED", e);
        } catch (BadCredentialsException e) {
            throw new Exception("INVALID_CREDENTIALS", e);
        }
    }
}