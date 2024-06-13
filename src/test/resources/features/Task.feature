@Clockify @Task
Feature: Task

  Background:
    Given call Project.feature@GetAllProjectsOnWorkspace
    And base url https://api.clockify.me/api
    And header x-api-key = M2Y0YzBlMTYtNjQ1YS00MjI1LTgwYWYtYmM2ZmRkMjU0ZWFl
    And header content-type = application/json

  @FindTasksOnProject
  Scenario: Find tasks on project
    Given endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}/tasks
    When  execute method GET
    Then the status code should be 200
    * define taskId = $.[0].id

  @AddANewTaskOnProject
  Scenario Outline: : Add a new task on project
    Given endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}/tasks
    And set value <task_name> of key name in body jsons/bodies/AddANewTaskOnProject.json
    When execute method POST
    Then the status code should be 201
    * define taskId = $.id

    Examples:
    | task_name |
    | Task02        |

  @UpdateTaskOnProject
  Scenario Outline: Update task on project
    Given call Task.feature@FindTasksOnProject
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}/tasks/{{taskId}}
    And set value <name> of key name in body jsons/bodies/UpdateTaskOnProject.json
    And set value <status> of key status in body jsons/bodies/UpdateTaskOnProject.json
    When execute method PUT
    Then the status code should be 200

    Examples:
      | name                  | status |
      | TaskEdit02         | DONE  |

  @DeleteTaskFromProject
  Scenario: Delete task from project
    Given call Task.feature@UpdateTaskOnProject
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}/tasks/{{taskId}}
    When execute method DELETE
    Then the status code should be 200