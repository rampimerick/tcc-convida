package br.gov.ufpr.convida.repository;

import br.gov.ufpr.convida.domain.Event;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;


@Repository
public interface EventRepository extends MongoRepository<Event, String>{

    @Query("{'name':{ $regex: ?0, $options: 'i'} }")
    List<Event> findByName(String text);

    @Query("{'type':{ $regex: ?0, $options: 'i'} }")
    List<Event> findByType(String text);

    List<Event> findMyEventsByAuthor(String text);

    @Query("{$and:[{'active': true}, {'name':{$regex: ?0, $options: 'i'}}, {'type': {$regex: ?1, $options: 'i'}}, {'dateStart':{$gte: ?2}}]}")
    List<Event> findByNameTypeGte(String text, String type, Date date, Sort sort);

     @Query("{$and:[{'active': true}, {'name':{$regex: ?0, $options: 'i'}}, {'type': {$regex: ?1, $options: 'i'}}, {'dateStart':{$lt: ?2}}]}")
    List<Event> findByNameTypeLt(String text, String type, Date date, Sort sort);

    @Query("{$and: [{'active': true},{'name':{$regex: ?0, $options: 'i'}}, {'dateStart':{$gte: ?8}}, {$or: [{'type':{$regex: ?1, $options: 'i'}},{'type':{$regex: ?2, $options: 'i'}},{'type':{$regex: ?3, $options: 'i'}},{'type':{$regex: ?4, $options: 'i'}},{'type':{$regex: ?5, $options: 'i'}},{'type':{$regex: ?6, $options: 'i'}},{'type':{$regex: ?7, $options: 'i'}}]}]}")
    List<Event> findByNameMultTypeGte(String name, String type, String type1, String type2, String type3, String type4, String type5, String type6, Date date, Sort sort);

    @Query("{$and: [{'active': true},{'name':{$regex: ?0, $options: 'i'}}, {'dateStart':{$lt: ?8}}, {$or: [{'type':{$regex: ?1, $options: 'i'}},{'type':{$regex: ?2, $options: 'i'}},{'type':{$regex: ?3, $options: 'i'}},{'type':{$regex: ?4, $options: 'i'}},{'type':{$regex: ?5, $options: 'i'}},{'type':{$regex: ?6, $options: 'i'}},{'type':{$regex: ?7, $options: 'i'}}]}]}")
    List<Event> findByNameMultTypeLt(String name, String type, String type1, String type2, String type3, String type4, String type5, String type6, Date date, Sort sort);


    @Query("{$and:[{'online': true}, {'active': true}, {'name':{$regex: ?0, $options: 'i'}}, {'type': {$regex: ?1, $options: 'i'}}, {'dateStart':{$gte: ?2}}]}")
    List<Event> findByNameTypeOnlineGte(String text, String type, Date date, Sort sort);

    @Query("{$and:[{'online': true}, {'active': true}, {'name':{$regex: ?0, $options: 'i'}}, {'type': {$regex: ?1, $options: 'i'}}, {'dateStart':{$lt: ?2}}]}")
    List<Event> findByNameTypeOnlineLt(String text, String type, Date date, Sort sort);

    //@Query("{'dateEnd' : {$gte : ?0}}")
    List<Event> findByDateEndGreaterThanEqual(Date date);

    @Query("{$and: [{'active': true},{$and:[{'dateStart':{$lte: ?0}}, {'dateEnd': {$gte: ?0}}]}]}")
    List<Event> findToday(Date date);

    @Query("{$and: [{'active': true}, {$or: [{'type':{$regex: ?0}},{'type':{$regex: ?1}},{'type':{$regex: ?2}},{'type':{$regex: ?3}},{'type':{$regex: ?4}},{'type':{$regex: ?5}},{'type':{$regex: ?6}}]}]}")
    List<Event> findByMultType(String text, String text1, String text2, String text3, String text4, String text5, String text6);

    @Query("{$and: [{'active': true},{'dateStart':{$lt: ?1}}, {'dateStart':{$gte: ?0}}, {'dateEnd': {$lte: ?1}}]}")
    List<Event> findWeek(Date minDate, Date maxDate);

    @Query("{$and: [{'active': true},{$and: [{$or:[{'dateStart':{$gte: ?0}}, {'dateEnd':{$gte: ?0}}]}, {$or: [{'dateStart':{$lte: ?1}},{'dateEnd':{$lte: ?1}}]}] },{$or:[{'type':{$regex: ?2}},{'type': {$regex: ?3}},{'type': {$regex: ?4}},{'type': {$regex: ?5}},{'type': {$regex: ?6}},{'type': {$regex: ?7}}]}]}")
    List<Event> findWeekType(Date minDate, Date maxDate, String text, String text1, String text2, String text3, String text4, String text5,String text6);

    @Query("{$and: [{'name':{ $regex: ?8, $options: 'i'} }, {'active': true},{$and: [{$or:[{'dateStart':{$gte: ?0}}, {'dateEnd':{$gte: ?0}}]}, {$or: [{'dateStart':{$lte: ?1}},{'dateEnd':{$lte: ?1}}]}] },{$or:[{'type':{$regex: ?2}},{'type': {$regex: ?3}},{'type': {$regex: ?4}},{'type': {$regex: ?5}},{'type': {$regex: ?6}},{'type': {$regex: ?7}}]}]}")
    List<Event> findNameWeekType(Date minDate, Date maxDate, String text, String text1, String text2, String text3, String text4, String text5,String text6, String name);

    @Query("{$and: [{'active': true}, {$and: [{'dateStart':{$lte: ?0}}, {'dateEnd': {$gt: ?1}}]},{$or:[{'type':{$regex: ?2}},{'type': {$regex: ?3}},{'type': {$regex: ?4}},{'type': {$regex: ?5}},{'type': {$regex: ?6}},{'type': {$regex: ?7}}]}]}")
    List<Event> findTodayType(Date minDate, Date maxDate, String text, String text1, String text2, String text3, String text4, String text5,String text6);

    @Query("{$and: [{'name':{ $regex: ?8, $options: 'i'} }, {'active': true}, {$and: [{'dateStart':{$lte: ?0}}, {'dateEnd': {$gt: ?1}}]},{$or:[{'type':{$regex: ?2}},{'type': {$regex: ?3}},{'type': {$regex: ?4}},{'type': {$regex: ?5}},{'type': {$regex: ?6}},{'type': {$regex: ?7}}]}]}")
    List<Event> findNameTodayType(Date minDate, Date maxDate, String text, String text1, String text2, String text3, String text4, String text5,String text6, String name);

    @Query("{'active': true}")
    List<Event> findAll();

    @Query("{'reported': true}")
    List<Event> findByReportsNotNull();
    
    List<Event> findAllByOrderByNbmrConfirmedDesc();

    @Query("{'active': false}")
    List<Event> findAllDeactivatedEvents();
}