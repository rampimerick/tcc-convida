package br.gov.ufpr.convida.resources;

import java.net.URI;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;


import br.gov.ufpr.convida.domain.Location;
import br.gov.ufpr.convida.services.LocationService;
import javassist.tools.rmi.ObjectNotFoundException;

@RestController
@RequestMapping(value = "/locations")
public class LocationResource{

    @Autowired
    private LocationService service;

    @GetMapping
    public ResponseEntity<List<Location>> findAll(){
        List<Location> list = service.findAll();
        return ResponseEntity.ok().body(list);
        }
    
    
        @GetMapping("/{id}")
    public ResponseEntity<Location> findById(@PathVariable String id) throws ObjectNotFoundException{
        Location obj = service.findById(id);
        return ResponseEntity.ok().body(obj);
    }

    @PostMapping
    public ResponseEntity<Void> insert(@RequestBody Location obj){
        obj = service.insert(obj);
        URI uri = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(obj.getCoord()).toUri();
        return ResponseEntity.created(uri).build();


    }


}