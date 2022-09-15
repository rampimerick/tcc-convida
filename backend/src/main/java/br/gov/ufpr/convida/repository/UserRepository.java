package br.gov.ufpr.convida.repository;

import br.gov.ufpr.convida.domain.User;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends MongoRepository<User, String> {

  User findByEmail(String email);

  User findByLogin(String login);

  @Query("{'adm': true}")
  List<User> findAllAdmin();

  @Query("{'name':{ $regex: ?0, $options: 'i'} }")
  List<User> findByName(String name);

}