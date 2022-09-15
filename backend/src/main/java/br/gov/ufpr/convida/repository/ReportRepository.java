package br.gov.ufpr.convida.repository;

import br.gov.ufpr.convida.domain.Report;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface ReportRepository extends MongoRepository<Report, String> {

}