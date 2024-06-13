@Clockify @Client
Feature: Client

  Background:
    Given call Workspace.feature@GetAllMyWorkspaces
    And base url https://api.clockify.me/api
    And header x-api-key = M2Y0YzBlMTYtNjQ1YS00MjI1LTgwYWYtYmM2ZmRkMjU0ZWFl
    And header content-type = application/json

  @AddANewClient
  Scenario Outline: Add a new client
    Given endpoint /v1/workspaces/{{workspaceId}}/clients
    And set value <Client_name> of key name in body jsons/bodies/AddANewClient.json
    When execute method POST
    Then the status code should be 201

    Examples:
    | Client_name |
    | Client02        |

  @FindClientsOnWorkspace
  Scenario: Find clients on workspace
    Given endpoint /v1/workspaces/{{workspaceId}}/clients
    When execute method GET
    Then the status code should be 200

  @UpdateClient
  Scenario Outline: Update client
    Given call Client.feature@FindClientsOnWorkspace
    * define clientId = $.[-1].id
    And set value <Client_archived> of key archived in body jsons/bodies/UpdateClient.json
    And endpoint /v1/workspaces/{{workspaceId}}/clients/{{clientId}}
    When execute method PUT
    Then the status code should be 200

    Examples:
      | Client_archived |
      | true                     |

  @DeleteClient
  Scenario: Delete client
    Given call Client.feature@FindClientsOnWorkspace
    * define clientId = $.[-1].id
    And endpoint /v1/workspaces/{{workspaceId}}/clients/{{clientId}}
    When execute method DELETE
    Then the status code should be 200