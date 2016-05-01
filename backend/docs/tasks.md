## TASKS:
Here describing some tasks which allow us be happier to manage the project. The list is growing, if you have some manual work we encourage to automate it through a task that everyone can use.

Note that if you want run any of below tasks on server keep in mind you will need prefix the command with

```sh
APP_ENV=staging /opt/rbenv/bin/rbenv exec [my task]
```

* [Create Execution Pictures](#create-execution-pictures)
* [Create Results](#create-results)
* [Reprocess Execution](#reprocess-execution)
* [Create Basic Tag Definitions](#create-basic-tag-definitions)
* [Validate Execution Pictures](#validate-execution-pictures)
* [Elasticsearch Reprocess](#elasticsearch-reprocess)
* [Elasticsearch Delete Indexes](#elasticsearch-delete-indexes)
* [Delete Executions](#delete-executions)

### Create Execution Pictures
This task allows to create dummy executions with Picture Questions.
This create the pictures in the database (execution_picture table) and also in elastic_search.
This uses 4 picture paths from s3 to make the dummy pictures.
The number of pictures created will be NUM_ACTIVITIES * NUM_QUESTIONS * NUM_EXECUTIONS.

```bash
  Params:
    String with COMPANY_UUID
    integer with NUM_ACTIVITIES. Default: 1
    integer with NUM_QUESTIONS which is the number of picture questions each activity will have. Default: 1
    integer with NUM_EXECUTIONS which is the number of executions each activity will have. Default: 1
    boolean `ASYNC` which means if you want this process running on background. Default `false`
    boolean `REAL` which means if you want to use real data from data base to create the results. Default `false`
     If this is true it will take the users, stores and tags from the database.
  Usage:
    bundle exec rake data_collector:create_execution_pictures COMPANY_UUID=some-uuid [NUM_ACTIVITIES=some_number]
    [NUM_EXECUTIONS=some_number] [NUM_QUESTIONS=some_number] [ASYNC=true|false] [REAL=true|false]
```

### Create Results
This task allows to create dummy executions with results that affect the store index.
This create the executions and its results in the database (executions, results, execution_answers) and also in elastic_search.
The number of results created will be NUM_ACTIVITIES * NUM_QUESTIONS * NUM_EXECUTIONS.

```bash
  Params:
    String with COMPANY_UUID
    integer with NUM_ACTIVITIES. Default: 1
    integer with NUM_QUESTIONS which is the number of questions each activity will have. Default: 1
    integer with NUM_EXECUTIONS which is the number of executions each activity will have. Default: 1
    boolean `ASYNC` which means if you want this process running on background. Default `false`
    boolean `REAL` which means if you want to use real data from data base to create the results. Default `false`
     If this is true it will take the users, stores and tags from the database.
  Usage:
    bundle exec rake data_collector:create_results COMPANY_UUID=some-uuid [NUM_ACTIVITIES=some_number]
    [NUM_EXECUTIONS=some_number] [NUM_QUESTIONS=some_number] [ASYNC=true|false] [REAL=true|false]
```

### Reprocess Execution
This task allows to reprocess an execution o a group of executions after it has been created.
    It calls the perform_analysis process on the given execution.. (see full doc `rake -D`)'

```bash
    Params:
      String with COMPANY_UUID
      String with ACTIVITY_UUID wich is the activity uuid for the executions group
      String with EXECUTION_UUID wich is the uuid of an specific execution.
      boolean `ASYNC` which means if you want this process running on background. Default `TRUE`
    Usage:
      bundle exec rake data_collector:reprocess_execution COMPANY_UUID=company-uuid [ACTIVITY_UUID=activity-uuid]
                                                          [EXECUTION_UUID=some-uuid] [ASYNC=true|false]
```

### Create Basic Tag Definitions
This task allows to create the basic tag definitions for a company: business_unit, product_category, kpi, instore_section.

```bash
  Params:
    String with COMPANY_UUID
    boolean `CLEAN` which means if you want to previously delete all tags and tag_definitions from the company. Default `FALSE`
  Usage:
    bundle exec rake data_collector:tags_base COMPANY_UUID=some-uuid [CLEAN=true|false]
```

### Validate Execution Pictures
This task allows to validate if there was some error while saving the pictures for a given execution.
It returns the errors, if existed, and where did they occurred.

```bash
  Params:
    String with EXECUTION_UUID
    String with APP_ENV which indicates in which environment the validation will be executed
  Usage:
    bundle exec rake data_collector:validate_execution_documents EXECUTION_UUID=some-uuid APP_ENV=some_environment
```

### Elasticsearch Reprocess
This task allows to reprocess the data into Elasticsearch.
It is possible reprocess a single company or all of them. (see full doc `rake -D`)'

This task generate a new version which should be used on task [Elasticsearch Delete Indexes](#elasticsearch-delete-indexes) once has been finished the reprocess all executions (check sidekiq) 

```bash
  Params:
    String with VERSION. Set the version token that will be use as suffix in the index alias. By Default this task
      will be create a version using the time as an integer.
    String with COMPANY_UUID. By default reprocess all the companies.
  Usage:
    bundle exec rake data_collector:elastic_search_reprocess [VERSION=version] [COMPANY_UUID=some-uuid]
```

### Elasticsearch Delete Indexes
This task allows to delete all the companies indexes in Elastic Search and then create an alias for the previously
created 'new index' (this task is a complement to the task 'elastic_search_reprocess'). (see full doc `rake -D`)'

```bash
  Params:
    String with VERSION. Version of the alias that will be use (Example: VERSION=_ver1438274562).
    String with COMPANY_UUID. By default reprocess all the companies.
  Usage:
    bundle exec rake data_collector:elastic_search_delete_indexes VERSION=version [COMPANY_UUID=some-uuid]
```

### Delete Executions
This task allows to delete ALL the executions of a specific Activity (you can pass several activities uuids separate
by comma) OR you can delete SPECIFIC executions passing its uuids.
Both params are optional, but you must pass one of them.
ACTIVITY_UUID has priority over EXECUTION_UUID. (see full doc `rake -D`)'

```bash
Params:
  String with ACTIVITY_UUID which is an array of activities uuids separate by comma
  String with EXECUTION_UUID which is an array of executions uuids separate by comma
Usage:
  bundle exec rake data_collector:delete_executions [ACTIVITY_UUID=some-uuids] [EXECUTION_UUID=some-uuids]
```
