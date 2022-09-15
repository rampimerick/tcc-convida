package br.gov.ufpr.convida.security;


import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.Context;
import javax.naming.NamingException;
import java.lang.String;

import java.util.Hashtable;



public class LdapConnection {

    public boolean connectToLDAP(String user, String password, String url) throws NamingException{
        try{

        String[] u = user.split("@");
        Hashtable<String, String> env = new Hashtable<>();
        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        env.put(Context.PROVIDER_URL, "ldap://"+url+":389");
        env.put(Context.SECURITY_AUTHENTICATION, "simple");
        env.put(Context.SECURITY_PRINCIPAL, "uid="+u[0]+" , ou=people, dc=ufpr,dc=br");
        env.put(Context.SECURITY_CREDENTIALS, password);
        env.put("com.sun.jndi.ldap.connect.timeout", "10000");

        DirContext ctx = new InitialDirContext(env);
        
        System.out.println(" ---------------- Success---------------------");
        
        ctx.close();
        return true;   
        
        }catch (NamingException e){	
            e.printStackTrace();
            return false;
        }

      }
}
