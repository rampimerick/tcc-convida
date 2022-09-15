package br.gov.ufpr.convida.repository;


import br.gov.ufpr.convida.domain.Location;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface LocationRepository extends MongoRepository<Location, String>{


}