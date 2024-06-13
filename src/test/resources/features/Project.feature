@Clockify @Project
Feature: Project

  Background:
    Given base url https://api.clockify.me/api
    And header x-api-key = M2Y0YzBlMTYtNjQ1YS00MjI1LTgwYWYtYmM2ZmRkMjU0ZWFl
    And header content-type = application/json

  @GetAllProjectsOnWorkspace
  Scenario: Get all projects on workspace
    Given call Workspace.feature@GetAllMyWorkspaces
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    When execute method GET
    Then the status code should be 200
    * define projectId = $.[0].id

  @FindProjectByID
  Scenario: Find project by ID
    Given call Project.feature@GetAllProjectsOnWorkspace
    And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
    When execute method GET
    Then  the status code should be 200

  @AddANewProject
  Scenario Outline: Add a new project
    Given call Workspace.feature@GetAllProjectsOnWorkspace
    And endpoint /v1/workspaces/{{workspaceId}}/projects
    And set value <project_name> of key name in body jsons/bodies/AddANewProject.json
    When execute method POST
    Then  the status code should be 201
    And response should be $.name = <project_name>
    * define projectId = $.id

    Examples:
    | project_name  |
    | Proyecto02      |

  @UpdateProjectOnWorkspace
  Scenario: Update project on workspace
      Given call Project.feature@GetAllProjectsOnWorkspace
      * define projectId = $.[-1].id
      And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
      And set value true of key archived in body jsons/bodies/UpdateProjectOnWorkspace.json
      When execute method PUT
      Then  the status code should be 200

    @DeleteProjectFromWorkspace
    Scenario: Delete Project From Workspace
      Given call Project.feature@UpdateProjectOnWorkspace
      And endpoint /v1/workspaces/{{workspaceId}}/projects/{{projectId}}
      When execute method DELETE
      Then  the status code should be 200



