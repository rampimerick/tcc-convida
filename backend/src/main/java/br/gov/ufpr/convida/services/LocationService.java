package br.gov.ufpr.convida.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.gov.ufpr.convida.domain.Location;
import br.gov.ufpr.convida.repository.LocationRepository;
import javassist.tools.rmi.ObjectNotFoundException;

@Service
public class LocationService{

    @Autowired
    private LocationRepository repo;

    public List<Location> findAll(){
        return repo.findAll();
    }

    public Location findById(String id) throws ObjectNotFoundException{
        Optional <Location> local = repo.findById(id);
        return local.orElseThrow(()-> new ObjectNotFoundException("Esta localização não está cadastrada em nossa base de dados"));
    }

    public Location insert(Location obj){
        return repo.insert(obj);
    }



}