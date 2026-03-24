public class LeadProcessor implements Database.Batchable<sObject> , Database.Stateful{

    public Integer recordsProcessed = 0;
    
    public Database.QueryLocator start(Database.BatchableContext BC){       
        return Database.getQueryLocator(
            'SELECT Id FROM Lead'
        );
    }

    public void execute(Database.BatchableContext BC, List<Lead> scope){
        for(Lead lead : scope){
            lead.LeadSource = 'Dreamforce';
            recordsProcessed++;
        }
        update scope;
    }

    public void finish(Database.BatchableContext BC){
        System.debug('Finished processing leads');
        System.debug('Total records processed: ' + recordsProcessed);
    }
}








/*

Crie uma classe do Apex que implemente a interface Database.Batchable para atualizar todos os registros de lead na organização com um LeadSource específico.
Crie uma classe do Apex:
Nome: LeadProcessor
Interface: Database.Batchable
Use um QueryLocator no método start para capturar todos os registros Lead na organização
O método execute precisa atualizar todos os registros Lead na organização com valor LeadSource de Dreamforce
Crie uma classe de teste do Apex:
Nome: LeadProcessorTest
Na classe de teste, insira 200 registros Lead, execute a classe Batch LeadProcessor e teste se todos os registros Lead foram atualizados corretamente
Os testes de unidade precisam cobrir todas as linhas de código incluídas na classe LeadProcessor, resultando em 100% de cobertura de código
Antes de verificar este desafio, execute sua classe de teste pelo menos uma vez usando o recurso do Developer Console Run All




*/